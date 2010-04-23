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
	public class VBlockRenderer extends BlockRenderer {

		
		
		public function VBlockRenderer () {
		}

		override public function init (padding : Rectangle, margin : Rectangle, w : Number, h : Number) : void {
			super.init( padding, margin, w, h );
			_baseLine 	= _margin.left + _padding.left;
			_offset = padding.top;
			_rheight = _rwidth = 0;
		}

		override public function render ( child : ILayoutItem ) : void {
			var w : Number = child.getWidth();
			var h : Number = child.getHeight();
			var _do : DisplayObject = child.getDisplay();
			
			if( _offset + _margin.bottom + _padding.height + h > _mawHeight && ! _firstItem ) lineBreak();
			_baseOffset = Math.max( _baseOffset , w );
			
			_offset += _margin.top;
			_do.x = _baseLine;
			_do.y = _offset;
			
			//_rwidth = ( _rwidth > _baseLine+w ) ? _rwidth : _baseLine+w;
			_rheight = ( _rheight > _offset+h ) ? _rheight : _offset+h;

			_offset += _margin.height + h;
			
			_firstItem = false;
		}

		override public function complete() : void {
			_rwidth = _baseLine + _baseOffset;
			super.complete( );
		}

		private function lineBreak() : void {
			_baseLine += _baseOffset+ _margin.width + _margin.left;
			_lineBreaks.push( _baseLine - _margin.left );
			_baseOffset = 0;
			_offset = _padding.top;
		}
	}
}
