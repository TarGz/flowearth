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

package fr.digitas.flowearth.media.player {
	import flash.events.Event;
	import flash.events.TextEvent;
	
	import fr.digitas.flowearth.core.ISizable;
	import fr.digitas.flowearth.media.player.MediaPlayer;
	import fr.digitas.flowearth.media.player.event.MetaDataEvent;
	import fr.digitas.flowearth.media.player.metadata.Metadata;	


	/**
	 * <p>centralise les erreur specifiques ( catch ) de loading (IO_ERROR, HTTP_STATUS, NET_STATUS etc) et les redispatche dans un ErrorEvent global</p>
	 * @see Event#RESIZE
	 */[Event(name="resize", type="flash.events.Event" )]	
	
	
	/**
	 * Player resizable
	 * @author Pierre Lepers
	 */
	public class SizablePlayer extends MediaPlayer implements ISizable {

		
		
		
		/**
		 * definie si le player se resize automatiquement a la reception des metadatas.
		 * 
		 * Le <code>Event.RESIZE</code> dispatché par le SizablePlayer est cancelable. si La methode Event.preventDefault() est appelé par un listener, le resize sera annulé.
		 * @default true;
		 */
		public function set autosize( flag : Boolean ) : void {
			if( _autoSize == flag ) return;
			if(_autoSize = flag)	addEventListener( METADATA, onMetaData );
			else 					removeEventListener( METADATA, onMetaData );
			if( metadata && flag ) setSize( metadata.width, metadata.height );
		}

		/** @private */
		public function get autosize( ) : Boolean {
			return _autoSize;
		}
		
		
		public function SizablePlayer() {
			super( );
			autosize = true;
		}
				

		/**
		 * redefinie la taille du display et du controls si ceux ci sont ISizables
		 */
		public function setSize( width : Number, height : Number ) : void {
			if( ! dispatchEvent( new Event( Event.RESIZE, false, true ) ) ) return;
			if( display is ISizable ) ( display as ISizable ).setSize(width, height); 
			if( controls is ISizable ) ( controls as ISizable ).setSize(width, height); 
		}
		
		/* Override for customize */
		override protected function onStageDisplayStateChange( e : TextEvent ) : void 
		{
			super.onStageDisplayStateChange(e);
		}
		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		
		private function onMetaData(e : MetaDataEvent ) : void {
			setSize( e.metadata.width, e.metadata.height );
		}

		private var _autoSize : Boolean;
	}
}
