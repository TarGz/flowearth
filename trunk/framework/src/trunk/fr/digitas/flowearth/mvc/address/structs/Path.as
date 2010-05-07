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

package fr.digitas.flowearth.mvc.address.structs {
	import fr.digitas.flowearth.event.NodeEvent;
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractPath;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;
	import fr.digitas.flowearth.utils.VariablesTools;
	
	import flash.net.URLVariables;
	
	import fr.digitas.flowearth.bi_internal;
	
	use namespace bi_internal;	

	/**
	 * Concrete implementation of AbstractPath.
	 * Able to solve path and manage node's structure
	 * 
	 * @author Pierre Lepers
	 */
	public class Path extends AbstractPath implements IPath {
		
		public function Path( path : String = null , params : URLVariables = null ) {
			_system = GLOBAL_SYSTEM;
			if( path != null ) _solve( path );
			if( params ) _params = params;
		}

		override public function append(path : IPath) : IPath {
			var params : URLVariables = VariablesTools.concat( _params , path.getParams( ) );
			var p : Path = new Path( null , params );
			
			var rb : int;
			var cs : Array;
			var _segLen : int = _segments.length;
			if( (rb = ( path as Path )._rbackCount) > 0 )
				cs = _segments.slice( 0 , _segLen - rb );
			else
				cs = _segments;
			p.bi_internal::precompile( cs.concat( path.segments( ) ) , _device , _types , _rbackCount );
			return p;
		}

		override public function clone() : IPath {
			var p : Path = new Path( null , _params );
			p.bi_internal::precompile( _segments, _device, _types, _rbackCount, _path );
			return p;
		}
		
		/**
		 * provide a copy of internaly solved node's branch
		 */
		override public function nodes(until : INode = null) : Array/*INode*/ {
			return []/*INode*/.concat( _getNodes() );
		}

		override public function toNode() : INode {
			var na : Array/*INode*/ = _getNodes( );
			if( ! _exist ) return null;
			return na[ na.length - 1 ];
		}
		
		override public function nodeExist() : Boolean {
			if( ! _nodes ) _nodes = _solveNodes( );
			return _exist;
		}

		override public function makeRelative(parent : IPath) : IPath {
			var str : String = makeRelativeString( parent );
			if( str == null ) return null;
			return new Path( str , _params );
		}

		override public function cleanup() : IPath {
			if( ! _nodes ) _nodes = _solveNodes( );
			return _nodes[ _nodes.length - 1 ].path();
		}

		/**
		 * lazy creation of node's branch
		 */
		protected function _getNodes() : Array/*INode*/ {
			if( ! _nodes ) _nodes = _solveNodes( );
			return _nodes;
		}
		
		protected function _solveNodes() : Array/*INode*/ {
				
			var ref : Path;
			
			if( ! isAbsolute() ) 
				ref = makeAbsolute( _system.getDefaultPath() ) as Path;
			else 
				ref = this;
			
			var segs : Array = ref.segments();
			var currNode : INode = ref._getBaseNode( );
			
			var ns : Array/*INode*/ = []/*INode*/;
			ns.push( currNode );
			
			var l : int = segs.length;
			var i : int = - 1;
			_exist = true;
			while( ++ i < l ) {
				if( ! currNode.hasChild( segs[i] ) ) {
					_exist = false;
					break;	
				}
				currNode = currNode.getChild( segs[i] );
				ns.push( currNode );
			}
			
			currNode.addEventListener( NodeEvent.CHILD_ADDED , onChildAdded , false , 200 , true );
			return ns;
		}
		
		/**
		 * @internal
		 * invalidate _nodes value, whenever the structure is modified
		 */
		protected function onChildAdded(event : NodeEvent) : void {
			//if( _nodes ) return;
			while( _nodes.length > 0 )
				_nodes.pop( ).removeEventListener( NodeEvent.CHILD_ADDED , onChildAdded, false );
			_nodes = null;
		}

		
		internal function _getBaseNode() : INode {
			if( ! isAbsolute( ) )
				return null;
			return _device ? _system.getDevice( _device ) : _system.getDefaultDevice( );
		}

		protected var _nodes : Array/*INode*/;

		protected var _exist : Boolean;

		protected var _system : INodeSystem;
		
		public static var GLOBAL_SYSTEM : INodeSystem = nodeSystem;
	}
}
