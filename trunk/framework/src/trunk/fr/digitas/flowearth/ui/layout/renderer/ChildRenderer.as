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
	import fr.digitas.flowearth.ui.layout.IChildRenderer;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;	

	/**
	 * Classe Abstraite
	 * @author Pierre Lepers
	 */
	public class ChildRenderer extends EventDispatcher implements IChildRenderer {

		internal var _offset : Number;
		internal var _margin : Rectangle;
		internal var _padding : Rectangle;
		internal var _type : String;
		internal var _width : Number;
		internal var _height: Number;
	
		
		public function init( padding : Rectangle, margin : Rectangle, w : Number, h : Number ) : void {
			_margin = margin;
			_padding = padding;
			_width = w;
			_height = h;
		}

		public function getType() :String {
			return _type;
		}
		
		public function render( child : DisplayObject ) : void {
			
		}
		
		public function complete () : void {
			
		}
	}
}
