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

package fr.digitas.flowearth.ui.controls {
	import flash.display.Sprite;
	

	
	/**
	 * @author Pierre Lepers
	 */
	public class SeekBar extends Slider {
		
		
		//_____________________________________________________________________________
		//																	   ELEMENTS
		
		public var buffer 	: Buffer;
		public var loading 	: Sprite;
		
		//_____________________________________________________________________________
		//																	 PARAMETRES
		
		/**
		 * progression de la lecture , comprise entre 0 et 1
		 */
		public function get playProgress ( ) : Number {
			return value;
		}
		/** @private */
		public function set playProgress ( val :  Number ) : void {
			value = val;
		}
		
		override public function set value ( val :  Number ) : void {
			super.value = Math.min( _loadProgress, Math.max( 0, val ) );
		}

		/**
		 * progression du loading, entre 0 et 1
		 */
		public function get loadProgress ( ) : Number {
			return _loadProgress;
		}
		/** @private */
		public function set loadProgress ( val : Number ) : void {
			if( _loadProgress == val ) return;
			_loadProgress = Math.min( 1, Math.max( 0, val ) );
			updateLoad();
		}
		
		
		//_____________________________________________________________________________
		//																   CONSTRUCTEUR
		
		public function SeekBar() {
			super( );
			loadProgress = 0;
		}
		
		/**
		 * active ou desactive l'anim de buffer
		 */
		public function setBuffer( flag : Boolean ) : void {
			if( buffer ) {
				if( flag ) 	buffer.show();
				else 		buffer.hide();
			}
		}
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		protected function updateLoad() : void {
			if( loading ) loading.width = track.width * _loadProgress;
		}
		
		protected var _loadProgress 		: Number;
		
	}
}
