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
	public class HTidyBlockRenderer extends BlockRenderer {

		
		
		public function HTidyBlockRenderer () {
		}

		override public function init (padding : Rectangle, margin : Rectangle, w : Number, h : Number) : void {
			super.init( padding, margin, w, h );
			_baseLine 	= _padding.top + _margin.top;
			_offset = padding.left;
			_rheight = _rwidth = 0;
			_lineBounds = [];
		}

		override public function render (child : ILayoutItem) : void {
			var w : Number = child.getWidth();
			var h : Number = child.getHeight();
			var _bounds : Rectangle = new Rectangle(  );
			var _do : DisplayObject = child.getDisplay();
			
			if( _offset + w + _margin.right + _padding.width > _mawWidth && ! _firstItem ) lineBreak();
			//_baseOffset = Math.max( _baseOffset , h );
			
			_bounds.x = _offset;
			_bounds.width = w + _margin.right;
			
			_offset += _margin.left;
			_do.x = _offset;
			_do.y = extractOptimizedPlace( _bounds );

			_bounds.y = _do.y - _margin.y;
			_bounds.height = h + _margin.bottom;
			
			_rwidth = ( _rwidth > _offset+w ) ? _rwidth : _offset+w;

			_offset += _margin.width + w;
			
			
			_lineBounds.push( _bounds );
			
			_firstItem = false;
		}
		
		private function extractOptimizedPlace(_bounds : Rectangle) : Number {
			
			if( ! _plineBounds ) return _baseLine;
			
			var cb : Rectangle;
			var my : Number = 0;
			for (var i : int = 0; i < _plineBounds.length; i++) {
				cb = _plineBounds[ i ];
				if( _bounds.x < cb.right && _bounds.right > cb.x ) {
					my = ( my > cb.bottom ) ? my : cb.bottom;
					if( _bounds.right > cb.right ) {
						_plineBounds.splice( i, 1 );
						i--;
					}
				}
			}
			
			return my;
		}

		override public function complete() : void {
			_plineBounds = null;
			_rheight = _baseLine + _baseOffset;
			super.complete( );
		}

		private function lineBreak() : void {
			_plineBounds = _lineBounds;
			_lineBounds = [];
			//_baseLine += _baseOffset + _margin.bottom;
			//_lineBreaks.push( _baseLine - _margin.top );
			//_baseOffset = 0;
			_offset = _padding.left;
		}
		
		private var _plineBounds : Array;
		private var _lineBounds : Array;
		
	}
}
