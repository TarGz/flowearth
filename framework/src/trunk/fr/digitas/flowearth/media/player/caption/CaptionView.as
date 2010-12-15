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

package fr.digitas.flowearth.media.player.caption 
{
	import fr.digitas.flowearth.media.player.MediaPlayer;
	import fr.digitas.flowearth.media.player.caption.data.CaptionData;
	import fr.digitas.flowearth.media.player.caption.data.CaptionProvider;
	import fr.digitas.flowearth.media.player.caption.data.ICaptionParser;
	import fr.digitas.flowearth.media.player.event.MetaDataEvent;
	import fr.digitas.flowearth.media.player.event.PlayProgressEvent;
	import fr.digitas.flowearth.media.player.loader.MediaLoader;
	import fr.digitas.flowearth.media.player.metadata.Metadata;
	import fr.digitas.flowearth.media.player.request.CaptionRequest;
	import fr.digitas.flowearth.media.player.request.MediaRequest;
	import fr.digitas.flowearth.ui.text.Label;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;	

	/**
	 * @author Brice d'Annoville
	 */
	public class CaptionView extends MovieClip implements ICaptionView {

		
		public var captions : Label;
		public var background : MovieClip;
		
		public function set parser (p : ICaptionParser) : void {
			_captionParser = p;
		}

		public function CaptionView() 
		{
		}
		
		
		public function registerPlayer (player : MediaPlayer) : void {
			if( player ) {
				player.addEventListener( MediaPlayer.METADATA		, onMetaData );
				player.addEventListener( MediaPlayer.PLAY_PROGRESS	, onPlayProgress );
				player.addEventListener( MediaPlayer.LOADER_CHANGE	, onLoaderChange );
				_registeredPlayer = player;
				initialize( player );
			}
			else if( _registeredPlayer ){
				_registeredPlayer.removeEventListener( MediaPlayer.METADATA			, onMetaData );
				_registeredPlayer.removeEventListener( MediaPlayer.PLAY_PROGRESS	, onPlayProgress );
				_registeredPlayer.removeEventListener( MediaPlayer.LOADER_CHANGE	, onLoaderChange );
				reset();
				_registeredPlayer = null;
			}
		}
		
		protected function initialize ( player : MediaPlayer ) : void {
			onLoaderChange();
		}
		
		
		protected function loadCaption ( request : MediaRequest ) : void {
			reset();
			_captionProvider = null;
			trace( "bi.media.player.caption.CaptionView - loadCaption -- ", request );
			if( !( request is CaptionRequest ) ) return;
			var loader : URLLoader = new URLLoader();
			var req : URLRequest = ( request as CaptionRequest ).captionReq ;
			loader.addEventListener( Event.COMPLETE, onCaptionLoaded );
			loader.load( req );
		}

		protected function onCaptionLoaded (event : Event) : void {
			trace( "bi.media.player.caption.CaptionView - onCaptionLoaded -- " );
			var loader : URLLoader = event.target as URLLoader;
			loader.removeEventListener( Event.COMPLETE, onCaptionLoaded );
			_captionProvider = _captionParser.parse( loader.data );
		}

		
		
		
		protected function onMetaData( event : MetaDataEvent ) : void 
		{
			_metaData = event.metadata;
		}

		protected function onPlayProgress( playProgressEvent : PlayProgressEvent ) : void 
		{
			updateCaptions( playProgressEvent.position );
		}
		
		protected function onLoaderChange( event : Event  = null ) : void 
		{
			var loader : MediaLoader = _registeredPlayer.loader;
			if ( loader ) loadCaption( loader.request );
		}

		protected function updateCaptions( time : Number ) : void 
		{
			if( ! _captionProvider ) return;
			var currentCaptionData : CaptionData = _captionProvider.getCaptionByTime(time);
//			Logger.log( "bi.media.player.caption.CaptionView - updateCaptions -- ", currentCaptionData );
			if (currentCaptionData)
			{
				if( _currentCaptionId != currentCaptionData.id )
				{
					_currentCaptionId = currentCaptionData.id;
					trace("new caption : " + currentCaptionData.htmlData);
					captions.tf.htmlText=currentCaptionData.htmlData;
				}
			} else {
				if( captions.tf.htmlText != "" )
				{
//					Logger.log("new empty caption");
					captions.tf.htmlText="";
				}
			}
		}
	
		
	

		public function reset() : void
		{
			captions.tf.htmlText = "";
		}
		
		protected var _metaData 			: Metadata;
		protected var _captionProvider 	: CaptionProvider;
		protected var _captionParser 		: ICaptionParser;
		protected var _currentCaptionId 	: Number;
		protected var _registeredPlayer 	: MediaPlayer;
		
	}
}
