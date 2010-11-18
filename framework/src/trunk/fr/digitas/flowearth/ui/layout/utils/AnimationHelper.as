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


package fr.digitas.flowearth.ui.layout.utils {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	import fr.digitas.flowearth.utils.motion.psplitter.IProgressive;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;	

	/**
	 * 
	 */
	public class AnimationHelper extends Shape implements ILayoutItem, IProgressive {

		
		public var timeStretch : Number = 1;
		
		public function AnimationHelper ( original : ILayoutItem ) {
			super( );
			_original = original;
			if ( _original is IInterpolable ) timeStretch = ( _original as IInterpolable ).timeStretch;
		}
		
		public function getDisplay() : DisplayObject {
			return this;
		}

		public function getWidth () : Number {
			return _original.getWidth( );
		}

		public function getHeight () : Number {
			return _original.getHeight( );
		}

		
		public function get original () : ILayoutItem {
			return _original;
		}
		
		public function setProgress ( p : Number ) : void {
			_progress = p;
		}

		public function getProgress () : Number {
			return _progress;
		}

		public function get pond () : Number {
			return timeStretch;
		}

		protected var _original : ILayoutItem;

		private var _progress : Number;
		
	}
}
