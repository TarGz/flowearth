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
	import fr.digitas.flowearth.mvc.address.SWFAddress;
	import fr.digitas.flowearth.mvc.address.SWFAddressEvent;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.connector.NodeConnector;
	import fr.digitas.flowearth.utils.encryption.Base64;
	
	import flash.events.Event;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class SWFAddressConnector extends NodeConnector {
		
		public var pathSeparator : String = ",";
		
		public function SWFAddressConnector() {
			_buffers = new Dictionary();
			super( );
		}
		
		public function connectAddress( ) : void {
			SWFAddress.addEventListener( Event.CHANGE, onAddressChange );
			onAddressChange(null);
		}

		public function disconnectAddress( ) : void {
			SWFAddress.removeEventListener( Event.CHANGE, onAddressChange );
		}
		
		override protected function nodeAdded(node : INode) : void {
			super.nodeAdded( node );
			_buffers[node] = new ActivationBuffer( node );
			_nodeChange( );
		}

		override protected function nodeRemoved(node : INode) : void {
			super.nodeRemoved( node );
			var b : ActivationBuffer = _buffers[node];
			b.dispose();
			delete _buffers[node];
		}

		override protected function onPathChange(event : NodeEvent) : void {
			super.onPathChange( event );
			_nodeChange( );
		}
		
		private function _nodeChange() : void {
			var url : String = "";
			var buffer : ActivationBuffer;
			for each ( var n : INode in _nodes ) {
				buffer = _buffers[ n ];
				if( buffer.lockAddress() )
					url += encodePath( buffer.pendingPath );
				else {
				if( n.activePath )
					url += encodePath( n.activePath );
				}
				url += pathSeparator;
			}
			
			url = url.replace( STRIP_PATH, "" );

			SWFAddress.setValue( url );
		}
		
		protected function onAddressChange( event : SWFAddressEvent ) : void {
			
			var paths : Array = SWFAddress.getValue( ).split( pathSeparator );
			while( paths.length > _nodes.length ) 
				paths.pop();

			var pLength : int = paths.length - 1;
			var path : IPath;
			var node : INode;
			
			for (var i : int = 0; i < _nodes.length ; i ++) {
				node =_nodes[ i ];
				path = ( i > pLength ) ? node.path() : new Path( decodePath( paths[i] ) );
				_buffers[ node ].apply( path );
			}
			
		}
		
		private function encodePath( path : IPath ) : String {
			if( path.getParams() )
				return path.getPath( ) + "?p=" + Base64.encode( path.getParams().toString() );
			else
				return path.getPath( );
		}

		private function decodePath( str : String ) : String {
			var sp : Array = str.split( "?p=" );
			if( sp.length > 1 ) 
				return sp[0] + "?" + Base64.decode( sp[1] );
				
			return str;
		}
		
		private var _buffers : Dictionary;

		private static const STRIP_PATH : RegExp = new RegExp( "[,]*$" , "gi" );
		
	}
}

import fr.digitas.flowearth.event.NodeEvent;
import fr.digitas.flowearth.mvc.address.structs.INode;
import fr.digitas.flowearth.mvc.address.structs.IPath;

//_____________________________________________________________________________
//															   ActivationBuffer

//			  AAA    CCCCC  TTTTTT IIIIII V     V   AAA   TTTTTT IIIIII  OOOO  NN  NN         BBBBBB  UU   UU FFFFFF FFFFFF EEEEEEE RRRRR   
//			 AAAAA  CC   CC   TT     II   V     V  AAAAA    TT     II   OO  OO NNN NN         BB   BB UU   UU FF     FF     EE      RR  RR  
//			AA   AA CC        TT     II    V   V  AA   AA   TT     II   OO  OO NNNNNN         BBBBBB  UU   UU FFFF   FFFF   EEEE    RRRRR   
//			AAAAAAA CC   CC   TT     II     V V   AAAAAAA   TT     II   OO  OO NN NNN         BB   BB UU   UU FF     FF     EE      RR  RR  
//			AA   AA  CCCCC    TT   IIIIII    V    AA   AA   TT   IIIIII  OOOO  NN  NN         BBBBBB   UUUUU  FF     FF     EEEEEEE RR   RR 



class ActivationBuffer {

	
	
	private var _node : INode;
	
	function ActivationBuffer( node : INode ) {
		
		_node = node;
		_node.addEventListener( NodeEvent.CHILD_ADDED , onChildAdded );
	}

	internal function apply( path : IPath ) : void {
		if( path.nodeExist() ) {
			path.toNode().activate();
			_pendingPath = null;
		} else {
			_pendingPath = path;
			_lock = true;
			path.cleanup().toNode().activate();
		}
		_lock = false;
	}
	
	internal function dispose() : void {
		_node.removeEventListener( NodeEvent.CHILD_ADDED , onChildAdded );
		_node = null;
	}
	
	internal function lockAddress() : Boolean {
		return ( _lock );
	}
	
	internal function get pendingPath() : IPath{
		return _pendingPath;
	}
	
	
	private function onChildAdded(event : NodeEvent) : void {
		if( _pendingPath ) apply( _pendingPath );
	}

	private var _pendingPath : IPath;
	private var _lock : Boolean = false;


}
