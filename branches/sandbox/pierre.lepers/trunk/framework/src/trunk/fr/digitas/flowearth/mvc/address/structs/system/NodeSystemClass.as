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

package fr.digitas.flowearth.mvc.address.structs.system {
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.INodeSystem;
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	
	import flash.utils.Dictionary;	

	public class NodeSystemClass implements INodeSystem {

		
		
		function NodeSystemClass() {
			_devices = new Dictionary( );
		}

		public function getDevice( device : String = null ) : INode {
			return _devices[ device ];
		}

		public function addDevice( node : INode ) : void {
			var id : String = node.getId( );
			if( hasDevice( id ) )
			if( node != _devices[ id ] ) throw new Error( "nodeSystem - addDevice : device '" + id + "' already exist." );
			else return;
			_devices[ id ] = node;
		
			if( ! _defaultPath ) setDefaultNode( node );
			if( ! _defaultDevice ) _defaultDevice = node;
		}

		public function hasDevice( device : String ) : Boolean {
			return ( _devices[ device ] != undefined );
		}

		
		public function setDefaultNode( n : INode ) : void {
			_defaultPath = n.path( );
		}

		public function setDefaultPath( p : IPath ) : void {
			_defaultPath = p;
		}

		public function getDefaultPath() : IPath {
			return _defaultPath;
		}

		
		public function setDefaultDevice( id : String ) : void {
			_defaultDevice = getDevice( id );
		}

		public function getDefaultDevice() : INode {
			return _defaultDevice;
		}

		
		
		private var _devices : Dictionary;

		
		private var _defaultPath : IPath;

		private var _defaultDevice : INode;
	}
}
