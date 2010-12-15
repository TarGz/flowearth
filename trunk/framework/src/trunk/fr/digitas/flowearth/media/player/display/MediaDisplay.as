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

package fr.digitas.flowearth.media.player.display {
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.media.Video;	

	
	/**
	 * Classe de base pour l'affichage des medias du <code>MediaPlayer</code>.
	 * <p>Cette classe n'a pas besoin de contenu graphique, ( elle construit le 'videoHolder' si il n'extiste pas ). Donc un siple new MediaDisplay suffit </p>
	 * @author Pierre Lepers
	 */
	public class MediaDisplay extends Sprite implements IMediaDisplay {
		
		
		/**
		 * Object video dans lequel sera lu les flv
		 */
		public function getVideoHolder() : Video {
			if( ! videoHolder ) videoHolder = addChild( new Video() ) as Video;
			return videoHolder;
		}

		/**
		 * DisplayObjectContainer dans lequel sera addchildé les swf loadés
		 * @return le displayObjectContainer contenat les swf a loader
		 */
		public function getContentHolder() : DisplayObjectContainer {
			if( contentHolder ) return contentHolder;
			return addChild(contentHolder = new Sprite()) as DisplayObjectContainer;
		}
		
		public function clear() : void {
			if( videoHolder ) videoHolder.clear();
			if( contentHolder ) {
				while(contentHolder.numChildren > 0) contentHolder.removeChildAt(0);
			}
		}

		
		/**
		 * Constructor
		 */
		public function MediaDisplay() {
			
		}
		
		/**
		 * @private
		 */
		public var videoHolder 		: Video;		
		public var contentHolder 	: DisplayObjectContainer;		
	}
}
