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
	import fr.digitas.flowearth.media.player.event.CuePointDataEvent;	
	import fr.digitas.flowearth.media.player.cuePoint.CuePointData;	
	
	import flash.display.Shape;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.event.NumberEvent;
	import fr.digitas.flowearth.media.player.MediaPlayer;
	import fr.digitas.flowearth.media.player.display.IMediaDisplay;
	import fr.digitas.flowearth.media.player.event.MetaDataEvent;
	import fr.digitas.flowearth.media.player.event.PlayProgressEvent;
	import fr.digitas.flowearth.media.player.metadata.Metadata;
	import fr.digitas.flowearth.media.player.request.MediaRequest;	

	/**
	 * <p>centralise les erreur specifiques des loader (IO_ERROR, HTTP_STATUS, NET_STATUS etc) et les redispatche dans un ErrorEvent global</p>
	 */[Event(name="error", type="flash.events.ErrorEvent" )]
	 
	
	/**
	 * Classe Abstraite, implementé par tout object utilisé comme loader de media apr MediaPlayer, doit etre etendu
	 * @author Pierre Lepers
	 * @see FlvLoader
	 */
	public class MediaLoader extends EventDispatcher {
		
		/** Abstract */
		public function set display( disp : IMediaDisplay ) : void {
			_display = disp;	
		}
		
		/** Abstract */
		public function set request( req : MediaRequest ) : void {
			_request = req;	
		}
		/** @private */
		public function get request( ) : MediaRequest {
			return _request;	
		}
		
		
		public function MediaLoader( player : MediaPlayer ) {
			super();
			oefShape=  new Shape();
			registerPlayer( player );
		}
		
		public function load( req : MediaRequest ) :void {
			request = req;
		}
		
		
		public function dispose() : void {
			registerPlayer( null );
			if( _display )
			{
				_display.clear();
				_display = null;
			}
			
			_request = null;
			oefShape = null;
		}
		
		protected function registerPlayer( player : MediaPlayer ) : void {
			if( player ) {
				player.addEventListener( MediaPlayer.PLAY, onPlay );
				player.addEventListener( MediaPlayer.SEEK, onSeek );
				player.addEventListener( MediaPlayer.VOLUME, onVolume );
				oefShape.addEventListener( Event.ENTER_FRAME, dispatchPlayProgress );
				_player = player;
				_autoPlay = player.autoPlay;
			}
			else if( _player ){
				_player.removeEventListener( MediaPlayer.PLAY, onPlay );
				_player.removeEventListener( MediaPlayer.SEEK, onSeek );
				_player.removeEventListener( MediaPlayer.VOLUME, onVolume );
				oefShape.removeEventListener( Event.ENTER_FRAME, dispatchPlayProgress );
				_player = null;
			}
		}
		
		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		//_____________________________________________________________________
		//														 PLAYER HANDLER
		
		protected function onPlay( e : BoolEvent ) : void {
			if( e.flag ) 	oefShape.addEventListener( Event.ENTER_FRAME, dispatchPlayProgress );
			else			oefShape.removeEventListener( Event.ENTER_FRAME, dispatchPlayProgress );
		}

		protected function onSeek( e : NumberEvent ) : void {
			// abstract
		}

		protected function onVolume( e : NumberEvent ) : void {
			// abstract
		}
		
		//_____________________________________________________________________
		//														 DEFAULT EVENTS
		
		protected function play( flag : Boolean ) : void {
			dispatchEvent( new BoolEvent( MediaPlayer.PLAY, flag ) );
		}		
		
		protected function loadProgress( loaded : uint, total : uint ) : void {
			dispatchEvent( new ProgressEvent( MediaPlayer.LOAD_PROGRESS , false, false, loaded, total ) );
		}
		
		protected function loadComplete() : void {
			dispatchEvent( new Event ( MediaPlayer.LOAD_COMPLETE ) );
		}
		
		protected function playProgress( position : Number, duration : Number ) : void {
			dispatchEvent( new PlayProgressEvent( MediaPlayer.PLAY_PROGRESS, position, duration ) );
		}
		
		protected function playComplete() : void {
			dispatchEvent( new Event ( MediaPlayer.PLAY_COMPLETE ) );
		}
		
		protected function metadata( metadata : Metadata ) : void {
			dispatchEvent( new MetaDataEvent ( MediaPlayer.METADATA, metadata ) );
		}
		
		protected function cuePoint( cuedata : CuePointData ) : void {
			dispatchEvent(new CuePointDataEvent(MediaPlayer.CUEPOINT, cuedata ) );
		}
		
		protected function error( text : String ) : void {
			dispatchEvent( new ErrorEvent( MediaPlayer.ERROR, false, false, text ) );
		}
		
		protected function buffer( flag : Boolean ) : void {
			dispatchEvent( new BoolEvent( MediaPlayer.BUFFER, flag ) );
		}
		
		protected function bufferProgress( l : Number, t : Number ) : void {
			dispatchEvent( new PlayProgressEvent( MediaPlayer.BUFFER_PROGRESS, l, t ) );
		}

		protected function dispatchPlayProgress( e : Event ) : void {
			// abstract
		}

		
		
		protected var _request 	: MediaRequest;
		protected var _display 	: IMediaDisplay;
		protected var _player 	: MediaPlayer;
		protected var _autoPlay : Boolean;

		protected var oefShape 	: Shape; 
	}
}
