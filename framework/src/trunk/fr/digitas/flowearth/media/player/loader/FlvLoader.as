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
	
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.event.NumberEvent;
	import fr.digitas.flowearth.media.player.cuePoint.CuePointData;	
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.event.NumberEvent;
	import fr.digitas.flowearth.media.player.MediaPlayer;
	import fr.digitas.flowearth.media.player.MediaPlayerConfig;
	import fr.digitas.flowearth.media.player.display.IMediaDisplay;
	import fr.digitas.flowearth.media.player.loader.MediaLoader;
	import fr.digitas.flowearth.media.player.metadata.FlvMetadata;
	import fr.digitas.flowearth.media.player.request.MediaRequest;
	
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
	import flash.utils.Timer;	

	/**
	 * Charge des medias de type flv non streamé pour <code>MediaPlayer</code>
	 * 
	 * @author Pierre Lepers
	 */
	public class FlvLoader extends MediaLoader {

		
		override public function set display ( disp : IMediaDisplay ) : void {
			if( _display ) {
				//				Logger.fatal( "bi.media.player.loader.FlvLoader - display -- dispose" );
				_display.getVideoHolder( ).attachNetStream( null );
				_display.getVideoHolder( ).clear( );
			}
			super.display = disp;
			if( _ns && disp ) disp.getVideoHolder( ).attachNetStream( _ns );
		}

		override public function set request ( req : MediaRequest ) : void {
			super.request = req;
			trace( "fr.digitas.flowearth.media.player.loader.FlvLoader - request -- ",req );
			openStream( _request );
		}

		public function FlvLoader ( player : MediaPlayer ) {
			super( player );
			_timer = new Timer( 50 );
			initConnection( );
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
			oefShape.removeEventListener( Event.ENTER_FRAME, dispatchBufferProgress );
			
			super.dispose( );
		}

		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		private function initConnection () : void {
			_nc = new NetConnection( );
			
			_nc.addEventListener( NetStatusEvent.NET_STATUS, ncStatus, false, 0, true );
			_nc.addEventListener( SecurityErrorEvent.SECURITY_ERROR, ncError, false, 0, true );
			_nc.addEventListener( IOErrorEvent.IO_ERROR, ncError, false, 0, true );
			_nc.addEventListener( AsyncErrorEvent.ASYNC_ERROR, ncError, false, 0, true );
            
			_nc.connect( null );
		}

		private function connectStream () : void {
			_ns = new NetStream( _nc );
			_ns.client = proxy = new ProxyClient( this );
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

		private function openStream ( req : MediaRequest ) : void {
			if( req && _ns ) {
				trace( "fr.digitas.flowearth.media.player.loader.FlvLoader - openStream -- ", req );
				_ns.checkPolicyFile = req.checkPolicyFile;
				_ns.play( req.urlRequest.url );
				oefShape.addEventListener( Event.ENTER_FRAME, dispatchLoadProgress );
				buffer( true );
			}
		}

		
		
		
		//_____________________________________________________________________________
		//														  NetConnection Handler

		private function ncStatus ( e : NetStatusEvent ) : void {
			if( e.info.code == "NetConnection.Connect.Success" )		connectStream( );
			if( e.info.level == "error" ) 	error( e.info.code );
		}

		
		private function ncError ( e : ErrorEvent ) : void {
			trace( "fr.digitas.flowearth.media.player.loader.FlvLoader - ncError -- " + e.text );
			error( e.text );
		}

		//_____________________________________________________________________________
		//															  NetStream Handler

		private function nsStatus ( e : NetStatusEvent ) : void {
			trace( "fr.digitas.flowearth.media.player.loader.FlvLoader - nsStatus -- ", e.info.code );
			
			
			if( e.info.level == "error" && e.info.code != "NetStream.Seek.InvalidTime" ) error( e.info.code + " - " + _request.urlRequest.url );
			
			
			dispatchEvent( new StatusEvent( MediaPlayer.STATUS , false, false, e.info.code, e.info.level ) );
			
			switch (e.info.code) {
				case "NetStream.Play.Stop":
					//					if( _buffFlushed ) {
					_completeMode = true;
					
//					_ns.seek( 0 );
					//					}
					if( _player && _player.autoRewind ) 
						_ns.seek( 0 );
					else
						dispatchPlayProgress(null);
						
					break;
				case "NetStream.Play.Start":
					if( ! _autoPlay ) { 
						play( false );
						_autoPlay = true;	
					}else {
						play( true );
					} 
						
					break;
				case "NetStream.Pause.Notify":
					play( false );
					break;
				case "NetStream.Unpause.Notify":
					play( true );
					break;
				case "NetStream.Seek.Notify":
					dispatchPlayProgress( null );
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
		
		
////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
////////////////////////////////////////
		
		public function onCuePoint(infoObj:Object):void {
			_cuePoint = new CuePointData ( infoObj );
			cuePoint(_cuePoint);
		} 
		
		
		override protected function dispatchPlayProgress ( e : Event ) : void {
			if( _ns && _md ) {
				playProgress( _ns.time, _md.duration );
				if( _completeMode && ( _ns.time < _md.duration / 3 || !_player.autoRewind)) 
				{
					_completeMode = false;
					playComplete( );
				}
			}
		}

		override protected function buffer ( flag : Boolean ) : void {
			super.buffer( flag );
			_buffFlushed = false;
			if( flag )
				oefShape.addEventListener( Event.ENTER_FRAME, dispatchBufferProgress );
			else
				oefShape.removeEventListener( Event.ENTER_FRAME, dispatchBufferProgress );
		}

		private function dispatchLoadProgress ( e : Event ) : void {
			if( _ns ) {
				loadProgress( _ns.bytesLoaded, _ns.bytesTotal );
				if( _ns.bytesLoaded == _ns.bytesTotal) {
					oefShape.removeEventListener( Event.ENTER_FRAME, dispatchLoadProgress );
					loadComplete( );
				}
			}
		}

		private function dispatchBufferProgress ( evt : Event ) : void {
			if( _ns ) {
				bufferProgress( _ns.bufferLength, _ns.bufferTime );
				if( _ns.bufferLength >= _ns.bufferTime )
					buffer( false );  
			}
		}

		//______________________________________________________________________________
		//																  PLAYER HANDLER

		override protected function onPlay ( e : BoolEvent ) : void {
			super.onPlay( e );
			if( ! _ns ) return;
			if( e.flag )_ns.resume( );
			else		_ns.pause( );
		}

		override protected function onSeek ( e : NumberEvent ) : void {
			if( _ns && _md ) {
				try {
					_ns.seek( e.value * _md.duration );
				} catch( err : Error ) {
				}
			}
			dispatchPlayProgress( null );
		}

		override protected function onVolume ( e : NumberEvent ) : void {
			if( _ns ) {
				var st : SoundTransform = _ns.soundTransform;
				st.volume = e.value;
				_ns.soundTransform = st;
			}
		}

		
		private var _nc : NetConnection;
		private var _ns : NetStream;
		private var _md : FlvMetadata;
		private var _cuePoint : CuePointData;

		private var _timer : Timer;
		private var _buffFlushed : Boolean = false;
		private var _completeMode : Boolean = false;
		
		private var proxy : ProxyClient;
	}
}

