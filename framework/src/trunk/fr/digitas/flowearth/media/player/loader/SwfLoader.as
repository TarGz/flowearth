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
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.event.NumberEvent;
	
	import fr.digitas.flowearth.media.player.MediaPlayer;
	import fr.digitas.flowearth.media.player.display.IMediaDisplay;
	import fr.digitas.flowearth.media.player.loader.MediaLoader;
	import fr.digitas.flowearth.media.player.metadata.SwfMetadata;
	import fr.digitas.flowearth.media.player.request.MediaRequest;	

	
	/**
	 * @author Pierre Lepers
	 */
	public class SwfLoader extends MediaLoader {
		
		
		override public function set display( disp : IMediaDisplay ) : void 
		{
			if( _display ) _display.getContentHolder( ).removeChild( loader );
			super.display = disp;
			if( disp ) _display.getContentHolder( ).addChild( loader );
			
		}
		
		override public function set request( req : MediaRequest ) : void {
			super.request = req;
			openMedia( _request );
		}		
		
		public function SwfLoader( player : MediaPlayer ) {
			super( player );
			initLoader( );
		}	
		
		override public function dispose() : void {
			loader.contentLoaderInfo.removeEventListener( Event.INIT					, onComplete );
			loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS		, dispatchLoadProgress  );
			loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR			, ioError );
			loader.contentLoaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS	, httpStatus );

			loader.unload( );	
			try { loader.close( ); }
			catch( e : Error ) {}
			loader = null;
			
			super.dispose();
		}
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		private function initLoader() : void {
			loader = new Loader( );
			loader.contentLoaderInfo.addEventListener( Event.INIT					, onComplete );
			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS		, dispatchLoadProgress  );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR		, ioError );
			loader.contentLoaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS	, httpStatus );
			
			loader.addEventListener( Event.ENTER_FRAME, checkProgress );
		}		
				
		
		private function openMedia( _request : MediaRequest ) : void {
			_md = new SwfMetadata();
			
			isPlaying = _autoPlay;
			_autoPlay = false;
			
			loader.load( _request.urlRequest );
		}
		
		//_____________________________________________________________________________
		//																 LOADER HANDLER
		
		private function onComplete( e : Event ) : void {
			loadComplete();
			if( ! onMd ) {
				_md.fill( e.target as LoaderInfo );
				metadata( _md );
				onMd = true;
			}
		}		
		
		private function ioError( e : ErrorEvent ) : void {
			error( e.text );
		}
		
		private function httpStatus( e : HTTPStatusEvent ) : void {
			var status : int = e.status;
			if(status < 100 && status > 0) 	error("bi.media.player.loader.SwfLoader - httpStatus -- flashError");
			else if(status < 200) 			return;//this.httpStatusType = "informational";
			else if(status < 300) 			return;//this.httpStatusType = "successful";
			else if(status < 400) 			return;//this.httpStatusType = "redirection";
			else if(status < 500) 			error("bi.media.player.loader.SwfLoader - httpStatus -- clientError" );
			else if(status < 600) 			error("bi.media.player.loader.SwfLoader - httpStatus -- serverError" ) ;
		}	
		
		private function dispatchLoadProgress( e : ProgressEvent ) : void {
			if( _md.fill( e.target as LoaderInfo ) ){
				if( ! onMd ) {
					metadata( _md );
					onMd = true;
				}
			}
			loadProgress( e.bytesLoaded, e.bytesTotal );
		}
		
		
		private function checkProgress( e :Event ) : void {
			try {
				getContent().stop();
				if( isPlaying ) getContent().nextFrame();
				var fps : Number = _player.stage.frameRate;	
				var position : Number = (getContent().currentFrame - 1) / fps;
				var duration : Number = (getContent().totalFrames - 1) / fps;
				playProgress(position, duration);
				
				if ( getContent().currentFrame == getContent().totalFrames )
				{
					playComplete();
					if(_player.autoRewind ) 
					{
						play(false);
						getContent().gotoAndStop( 1 );
						checkProgress(null);
					}
					loader.removeEventListener( Event.ENTER_FRAME, checkProgress );
					if (_player.loop)
					{
						getContent().gotoAndStop( 1 );
						play(true);
					}
				}
			}
			catch( error : Error ) {
				
			}
		}
		
		//______________________________________________________________________________
		//																  PLAYER HANDLER
		
		override protected function onPlay( e : BoolEvent ) : void {
			super.onPlay(e);
			isPlaying = e.flag;
			if(e.flag)	loader.addEventListener( Event.ENTER_FRAME, checkProgress );
		}
		
		override protected function onSeek( e : NumberEvent ) : void {
			getContent().gotoAndStop( Math.round( getContent().totalFrames * e.value ));
		}

		override protected function onVolume( e : NumberEvent ) : void {
			
		}
		
		
		private function getContent() : MovieClip {
			return MovieClip( loader.content );	
		}
		
		private var loader : Loader;
		private var _md : SwfMetadata;
		private var onMd : Boolean = false;
		
		private var isPlaying : Boolean;
	}
}
