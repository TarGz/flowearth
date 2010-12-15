/* ***** BEGIN LICENSE BLOCK *****
 * Copyright (C) 2007-2009 Digitas France
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * The Initial Developer of the Original Code is
 * Digitas France Flash Team
 *
 * Contributor(s):
 *   Digitas France Flash Team
 *
 * ***** END LICENSE BLOCK ***** */

package fr.digitas.flowearth.media.player.loader {
	import flash.events.AsyncErrorEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.StatusEvent;
	import flash.media.SoundTransform;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.ObjectEncoding;
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.event.NumberEvent;

	import fr.digitas.flowearth.media.player.MediaPlayer;
	import fr.digitas.flowearth.media.player.MediaPlayerConfig;
	import fr.digitas.flowearth.media.player.display.IMediaDisplay;
	import fr.digitas.flowearth.media.player.metadata.FlvMetadata;
	import fr.digitas.flowearth.media.player.request.MediaRequest;	

	
	/**
	 * @author Franck Youdine
	 */
	public class FlvStreamLoader extends MediaLoader {
		
		private static var ID : int = 0;
		
		override public function set display ( disp : IMediaDisplay ) : void {
			if( _display ) {
				_display.getVideoHolder( ).attachNetStream( null );
				_display.getVideoHolder( ).clear( );
			}
			super.display = disp;
			if( _ns && disp ) disp.getVideoHolder( ).attachNetStream( _ns );
		}

		override public function set request ( req : MediaRequest ) : void {
			super.request = req;
			
			initConnection( );
//			openStream( _request );
		}

		
		override public function dispose () : void {
			if( _ns ) {
				_ns.removeEventListener( NetStatusEvent.NET_STATUS, nsStatus );
				_ns.removeEventListener( IOErrorEvent.IO_ERROR, nsError );
				_ns.removeEventListener( AsyncErrorEvent.ASYNC_ERROR, nsError );
				_ns.soundTransform = new SoundTransform( 0 ); 
				//fp bug
				_ns.receiveAudio( false );
				_ns.pause( );
				_ns.close( );
				_ns = null;	
			}

			if( _nc ) {
				_nc.removeEventListener( NetStatusEvent.NET_STATUS, ncStatus );
				_nc.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, ncError );
				_nc.removeEventListener( IOErrorEvent.IO_ERROR, ncError );
				_nc.removeEventListener( AsyncErrorEvent.ASYNC_ERROR, ncError );
				_nc.close( );
				_nc = null;
			}
            
			oefShape.removeEventListener( Event.ENTER_FRAME, dispatchLoadProgress );
			//			oefShape.removeEventListener( Event.ENTER_FRAME, dispatchBufferProgress );

			super.dispose( );
		}

		public function FlvStreamLoader (player : MediaPlayer) {
			super( player );
			_id = ID++;
		}

		public var _id : int;
		
		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		protected function initConnection () : void {
			
			NetConnection.defaultObjectEncoding = ObjectEncoding.AMF0;
			
			_nc = new NetConnection( );
			_nc.client = this;
			
			_nc.proxyType = "best";
			
			_nc.addEventListener( NetStatusEvent.NET_STATUS, ncStatus, false, 0, true );
			_nc.addEventListener( SecurityErrorEvent.SECURITY_ERROR, ncError, false, 0, true );
			_nc.addEventListener( IOErrorEvent.IO_ERROR, ncError, false, 0, true );
			_nc.addEventListener( AsyncErrorEvent.ASYNC_ERROR, ncError, false, 0, true );
            
			trace( "FlvStreamLoader.initConnection()", _request );
            
			_nc.connect( _request.urlRequest.url );
//            if( FlvStreamRequest( _request ).isRTMP )
//            {
//            }
//            else
//            {
//            	_nc.connect( null );
//            }
		}

		private function connectStream () : void {
			
			trace( "_nc.connectedProxyType : "+_nc.connectedProxyType );
			
			
			_ns = new NetStream( _nc );
			_ns.client = this;
			_ns.bufferTime = MediaPlayerConfig.flvBufferTime;
			_ns.addEventListener( NetStatusEvent.NET_STATUS, nsStatus );
			_ns.addEventListener( IOErrorEvent.IO_ERROR, nsError );
			_ns.addEventListener( AsyncErrorEvent.ASYNC_ERROR, nsError );
            
			var st : SoundTransform = _ns.soundTransform;
			st.volume = _player.volume;
			_ns.soundTransform = st;
			
			openStream( _request );
			if( _display ) _display.getVideoHolder( ).attachNetStream( _ns );
		}		

		protected function openStream ( req : MediaRequest ) : void {
			if( req && _ns ) {
				_ns.play( req.urlRequest.data );
				oefShape.addEventListener( Event.ENTER_FRAME, dispatchLoadProgress );
			}
		}

		public function onBWDone ( ...args ) : void {
			trace( "bi.media.player.loader.FlvStreamLoader - onBWDone -- " );
			for each(var i : * in args ) {
				//trace( "bi.media.player.loader.FlvStreamLoader - onBWDone -- ", i );
			}
		}

		
		//_____________________________________________________________________________
		//														  NetConnection Handler

		protected function ncStatus ( e : NetStatusEvent ) : void {
			//Logger.info( e.info.level, e.info.code );
			if( e.info.code == "NetConnection.Connect.Success" )		connectStream( );
			if( e.info.level == "error" ) 	error( e.info.code );
		}

		
		protected function ncError ( e : ErrorEvent ) : void {
			//Logger.error( "bi.media.player.loader.FlvLoader - ncError -- " + e.text );
			error( e.text );
		}

		//_____________________________________________________________________________
		//															  NetStream Handler

		private function nsStatus ( e : NetStatusEvent ) : void {
			trace( "bi.media.player.loader.FlvStreamLoader - nsStatus -- ", e.info.code );
			if( e.info.level == "error" ) error( e.info.code + " - " + _request.urlRequest.url + "  ##  " + _request.urlRequest.data );
			
			dispatchEvent( new StatusEvent( MediaPlayer.STATUS , false, false, e.info.code, e.info.level ) );
			
			switch ( e.info.code ) {
//				case "NetStream.Play.Stop":
//					if( _player.play && _buffFlushed ) {
//						_completeMode = true;
//						_ns.seek( 0 );
//					}
//					break;
				case "NetStream.Play.Stop":
					
					//Logger.log( "bi.media.player.loader.FlvStreamLoader - ns stop -- __id: " , (_id) );
					//Logger.log( "bi.media.player.loader.FlvStreamLoader - ns stop -- _md.duration : " , (_md.duration) );
					//Logger.log( "bi.media.player.loader.FlvStreamLoader - ns stop -- _ns.time : " , (_ns.time) );
//					Logger.debug( "_buffFlushed:" + _buffFlushed );
//				
//					if(  _player && _player.play ) // && _buffFlushed 
//					{
//						_completeMode = true;
//						Logger.debug( "autorewind:" + _player.autoRewind );
//						if( _player.autoRewind ) 
//							_ns.seek( 0 );
//						else
//							dispatchPlayProgress(null);
//					}
					break;
				case "NetStream.Play.Start":
					play( true );
					break;
				case "NetStream.Pause.Notify":
					play( false );
					break;
				case "NetStream.Seek.Notify":
					_trytoSeek = false;
//					dispatchPlayProgress( null );
					break;
				case "NetStream.Buffer.Empty":
					buffer( true );
					break;
				case "NetStream.Buffer.Full":
					buffer( false );
					break;
				case "NetStream.Buffer.Flush":
					buffer( false );
					_buffFlushed = true;
					break;
			}
		}

		private function nsError ( e : ErrorEvent ) : void {
			error( e.text );
		}

		public function onMetaData ( infoObj : Object ) : void {
			_md = new FlvMetadata( infoObj );
			metadata( _md );	
		}

		public function onPlayStatus ( infoObj : Object ) : void {
			if( infoObj.code == "NetStream.Play.Complete" ) {
				//Logger.focus( "bi.media.player.loader.FlvStreamLoader - onPlayStatus -- playComplete();" );
				playComplete();	
			}
		}

		
		
		override protected function dispatchPlayProgress ( e : Event ) : void {
			if( _ns && _md && !_trytoSeek ) {
				playProgress( _ns.time, _md.duration );
				if( _completeMode && _ns.time < _md.duration / 3 ) {
					_completeMode = false;
					//Logger.focus( "bi.media.player.loader.FlvStreamLoader - dispatchPlayProgress -- playComplete();" );
					playComplete( );
				}
			}
		}

		override protected function buffer ( flag : Boolean ) : void {
			super.buffer( flag );
			_buffFlushed = false;
		}

		protected function dispatchLoadProgress ( e : Event ) : void {
			if( _ns ) {
				loadProgress( _ns.bytesLoaded, _ns.bytesTotal );
				if( _ns.bytesLoaded == _ns.bytesTotal) {
					oefShape.removeEventListener( Event.ENTER_FRAME, dispatchLoadProgress );
					loadComplete( );
				}
			}
		}
		
		

		//______________________________________________________________________________
		//																  PLAYER HANDLER

		override protected function onPlay ( e : BoolEvent ) : void {
			super.onPlay( e );
			if( ! _ns ) return;
			if( e.flag ){
				//trace( "bi.media.player.loader.FlvStreamLoader - Resume " );
				// avoid complete browser crash !!!

				//trace( "bi.media.player.loader.FlvStreamLoader - onPlay -- __id: " , (_id) );
				//trace( "bi.media.player.loader.FlvStreamLoader - onPlay -- _md.duration : " , (_md.duration) );
				//trace( "bi.media.player.loader.FlvStreamLoader - onPlay -- _ns.time : " , (_ns.time) );
				if( _md.duration - _ns.time > 3 )
					_ns.resume( );
				else {
					//trace( "bi.media.player.loader.FlvStreamLoader - onPlay -- playComplete();" );
					playComplete();
				}
			}
			else {
				//trace( "bi.media.player.loader.FlvStreamLoader - Pause" );
				_ns.pause( );
			}
		}

		override protected function onSeek ( e : NumberEvent ) : void {
			//Logger.log( "bi.media.player.loader.FlvStreamLoader - onSeek" );
			_trytoSeek = true;
			if( _ns && _md ) _ns.seek( e.value * _md.duration );
//			dispatchPlayProgress( null );
		}

		override protected function onVolume ( e : NumberEvent ) : void {
			if( _ns ) {
				var st : SoundTransform = _ns.soundTransform;
				st.volume = e.value;
				_ns.soundTransform = st;
			}
		}

		
		protected var _nc : NetConnection;
		protected var _ns : NetStream;
		protected var _md : FlvMetadata;

		private var _buffFlushed : Boolean = false;
		private var _completeMode : Boolean = false;
		private var _trytoSeek : Boolean = false;
		
	}
}
