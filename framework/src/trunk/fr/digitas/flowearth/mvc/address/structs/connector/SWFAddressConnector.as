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

package fr.digitas.flowearth.mvc.address.structs.connector 
{
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.event.NodeEvent;
	import fr.digitas.flowearth.mvc.address.SWFAddress;
	import fr.digitas.flowearth.mvc.address.SWFAddressEvent;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.system.ActivationBuffer;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;
	import fr.digitas.flowearth.mvc.address.structs.utils.PathTools;
	import fr.digitas.flowearth.utils.encryption.Base64;

	import flash.events.Event;

	/**
	 * @author Pierre Lepers
	 */
	public class SWFAddressConnector extends NodeConnector 
	{

		
		public var pathSeparator : String = ",";

		public function SWFAddressConnector() 
		{
			super( );
		}

		public function connectAddress( ) : void 
		{
			SWFAddress.addEventListener( Event.CHANGE, onAddressChange );
			onAddressChange( null );
		}

		public function disconnectAddress( ) : void 
		{
			SWFAddress.removeEventListener( Event.CHANGE, onAddressChange );
		}

		override protected function nodeAdded(node : INode) : void 
		{
			super.nodeAdded( node );
			if( !nodeSystem.hasDevice( node.getId( ) ) )
				throw new Error( "SWFAddressConnector - connectNode node argument must be register in a INodeSystem" );
			_nodeChange( );
		}

		override protected function nodeRemoved(node : INode) : void 
		{
			super.nodeRemoved( node );
		}

		override protected function onPathChange(event : NodeEvent) : void 
		{
			super.onPathChange( event );
			
			_nodeChange( );
		}

		private function _nodeChange() : void 
		{
			var url : String = "";
			var buffer : ActivationBuffer;
			for each ( var n : INode in _nodes ) 
			{
				buffer = nodeSystem.getActivationBuffer( n );
				
				if( buffer.bi_internal::pendingPath )
				{
					url += encodePath( PathTools.removeDefaultPart( buffer.bi_internal::pendingPath ) );
				}
				
				url += pathSeparator;
			}
			
			url = url.replace( STRIP_PATH, "" );
			SWFAddress.setValue( url );
		}

		protected function onAddressChange( event : SWFAddressEvent ) : void 
		{
			var paths : Array = SWFAddress.getValue( ).split( pathSeparator );
			
			while( paths.length > _nodes.length ) 
				paths.pop( );

			var pLength : int = paths.length - 1;
			var path : IPath;
			var node : INode;
			
			for (var i : int = 0; i < _nodes.length ; i++) 
			{
				node = _nodes[ i ];
				path = ( i > pLength ) ? node.path( ) : node.path( ).append( new Path( decodePath( paths[i] ) ) );
				nodeSystem.getActivationBuffer( node ).bi_internal::apply( path );
			}
		}

		private function encodePath( path : IPath ) : String 
		{
			if( path.getParams( ) )
				return path.getPath( ) + "?p=" + Base64.encode( path.getParams( ).toString( ) );
			else
				return path.getPath( );
		}

		private function decodePath( str : String ) : String 
		{
			var sp : Array = str.split( "?p=" );
			if( sp.length > 1 ) 
				return sp[0] + "?" + Base64.decode( sp[1] );
				
			return str;
		}

		private static const STRIP_PATH : RegExp = new RegExp( "[,]*$", "gi" );
	}
}

