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
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	import fr.digitas.flowearth.ui.layout.renderer.ChildRenderer;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;	

	/**
	 * @author Pierre Lepers
	 */
	public class HBlockJustifiedRenderer extends BlockRenderer {

		
		
		public function HBlockJustifiedRenderer () {
		}

		override public function init (padding : Rectangle, margin : Rectangle, w : Number, h : Number) : void {
			super.init( padding, margin, w, h );
			_lineStock = [];
			_baseLine 	= _padding.top + _margin.top;
			_offset = padding.left;
			_rheight = 0;
			_rwidth = w;
		}

		override public function render (child : ILayoutItem) : void {
			var w : Number = child.getWidth();
			var h : Number = child.getHeight();
			var _do : DisplayObject = child.getDisplay();
			
			if( _offset + w + _margin.right + _padding.width > _mawWidth && ! _firstItem ) lineBreak( _mawWidth - _offset - _padding.width );

			_lineStock.push( _do );

			_baseOffset = Math.max( _baseOffset , h );
			
			_offset += _margin.left;
			_do.x = _offset;
			_do.y = _baseLine;
			

			_offset += _margin.width + w;
			
			_firstItem = false;
		}

		override public function complete() : void {
			_rheight = _baseLine + _baseOffset +_padding.height + _margin.height;
		}

		private function lineBreak( space : Number ) : void {
			_baseLine += _baseOffset + _margin.height + _margin.top;
			_lineBreaks.push( _baseLine - _margin.top );
			_baseOffset = 0;
			_offset = _padding.left;
			
			var len : int = _lineStock.length;
			var decay : Number = space/(len-1);
			var doDecay : Number = decay;
			
			for (var i : int = 1; i < len; i++) {
				_lineStock[i].x += doDecay;
				doDecay += decay;
			}
			
			_lineStock = [];
		}
		
		private var _lineStock : Array;
		
	}
}
