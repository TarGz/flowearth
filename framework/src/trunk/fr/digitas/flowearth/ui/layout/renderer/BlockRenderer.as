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

package fr.digitas.flowearth.ui.layout.renderer {
	import fr.digitas.flowearth.ui.layout.renderer.ChildRenderer;
	
	import flash.geom.Rectangle;	

	/**
	 * Base class of "block" renderer. A BlockRenderer render place item in columns or rows until an item reach the width or height value of his Layout. 
	 * Then items is placed on a new line and so on.
	 * 
	 * 
	 * @see VBlockRenderer
	 * @see HBlockRenderer
	 * @author Pierre Lepers
	 */
	public class BlockRenderer extends ChildRenderer {

		
		public function BlockRenderer () {
			
		}
		
		/**
		 * return an array of x/y values of columns /rows linebreaks. Can be usefull to place separators in a "block" list.
		 * @return an array of x/y values of columns /rows linebreaks.
		 */
		public function get lineBreaks() : Array {
			return _lineBreaks;
		}

		override public function init (padding : Rectangle, margin : Rectangle, w : Number, h : Number) : void {
			super.init( padding, margin, w, h );
			_mawWidth 	= w;
			_mawHeight 	= h;
			_baseOffset = 0;
		}
		
		protected var _baseLine : Number;
		protected var _baseOffset : Number;
		protected var _mawWidth : Number;
		protected var _mawHeight : Number;
		protected var _lineBreaks : Array;
	}
}
