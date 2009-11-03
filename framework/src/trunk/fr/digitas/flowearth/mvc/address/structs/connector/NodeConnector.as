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

package fr.digitas.flowearth.mvc.address.structs.connector {
	import fr.digitas.flowearth.event.NodeEvent;	
	import fr.digitas.flowearth.mvc.address.structs.INode;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class NodeConnector {

		
		
		public function NodeConnector() {
			_nodes = [];
		}
		
		public function connectNode( node : INode ) : void {
			if( _nodes.indexOf( node ) > -1 ) return;
			
			node.addEventListener( NodeEvent.PATH_CHANGE, onPathChange );
			_nodes.push( node );
			nodeAdded( node );
		}

		public function disconnectNode( node : INode ) : void {
			var index : int = _nodes.indexOf( node );
			if( index == -1 ) 
				throw new Error( "NodeConnector - disconnectNode : node "+node.getId()+" not registered");
			
			node.removeEventListener( NodeEvent.PATH_CHANGE, onPathChange );
			_nodes.splice( index , 1 );
			nodeRemoved( node );
		}

		
		protected function onPathChange(event : NodeEvent) : void {
			
		}

		protected function nodeAdded( node : INode ) : void {
		}

		protected function nodeRemoved( node : INode ) : void {
		}
	
		protected var _nodes : Array;
	
	}
}
