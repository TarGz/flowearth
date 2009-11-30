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

package fr.digitas.flowearth.mvc.address.structs.utils {
	import fr.digitas.flowearth.mvc.address.structs.INode;			

	/**
	 * @author Pierre Lepers
	 */
	public class Stringifyer {

		public static function htmlString( node : INode ) : String {
			
			var t : HtmlStringifyerTraverser = new HtmlStringifyerTraverser();
			node.scan( t );
			return t.result;
			
		}
	}
}

import fr.digitas.flowearth.mvc.address.structs.INode;
import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;
import fr.digitas.flowearth.utils.StringUtility;

class HtmlStringifyerTraverser implements INodeTraverser {

	
	
	
	public function HtmlStringifyerTraverser() {
		_result = "</br>";
	}

	public function get result() : String {
		return _result;
	}

	public function enter(node : INode) : Boolean {
		_tab ++;
		var tab : String = StringUtility.multiply( "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , _tab );
		
		var params : String = "";
		if( node.getParams( ) ) params = node.getParams( ).toString( );
			
			
		if( node.isActive( ) )
			_result += tab + "|- <b>id : " + node.getId( ) + "  </b><i> " + params + " </i>";
		else
			_result += tab + "|- id : " + node.getId( ) + " <i> " + params + "</i>";
		
		if( node.getDefaultId( ) )
			_result += " <i> " + node.getDefaultId( ) + "</i>";
			
			
		_result += "</br>";
		
		return true;
	}

	public function leave(node : INode) : void {
		_tab --;
	}

	private var _result : String;
	private var _tab : int = -1;
}