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

package fr.digitas.flowearth.mvc.address.structs.traverser {
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;	

	/**
	 * @author Pierre Lepers
	 */
	public class PathTraverser implements INodeTraverser {

		public function PathTraverser( path : IPath ) {
			this.path = path;
			_compile( );
		}
		
		public function enter(node : INode) : Boolean {
			if( node.getId() != _current )
				return false;
			_current = _segs.shift();
			return true;
		}
		
		public function leave(node : INode) : void {
			
		}
	
		protected function _compile() : void {
			_segs = path.segments();
			_current = _segs.shift();
		}

		protected var path : IPath;
		
		protected var _segs : Array;
		
		protected var _current : String;
	
	}
}
