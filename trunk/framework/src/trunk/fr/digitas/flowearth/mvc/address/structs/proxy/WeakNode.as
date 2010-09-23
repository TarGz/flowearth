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
package fr.digitas.flowearth.mvc.address.structs.proxy
{
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.event.NodeEvent;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractNode;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;

	import flash.net.URLVariables;

	/**
	 * Provide a copy structure of a nodes structure.
	 *
	 * provide a weak representation of a node, to avoid GC lock
	 * 
	 * @author Pierre Lepers
	 */
	public class WeakNode extends AbstractNode implements INode
	{
		public function WeakNode( referer : INode )
		{
			super();
			_referer = referer;
			_id = _referer.getId();
			register();

			plolid = lolid++;
		}
		
		
		private function _proxying( ref : INode ) : INode
		{
			if( ref )
			{
//				return ref;
				return new WeakNode( ref );
			}
			else
			{
				return null;
			}
		}
		

		// _____________________________________________________________________________
		// OVERRIDES
		override public function isActive() :Boolean
		{
			return _referer.isActive();
		}

		override public function activate( params : URLVariables = null ) : void
		{
			_referer.activate( params );
		}

		override public function get activePath() : IPath
		{
			return _referer.activePath;
		}

		override public function getDefaultId() : String
		{
			return _referer.getDefaultId();
		}

		override public function getParams() : URLVariables
		{
			return _referer.getParams();
		}

		override public function path() : IPath
		{
			return _referer.path();
		}

		override public function getCurrentChild() : INode
		{
			return _proxying( _referer.getCurrentChild() );
		}

		override public function getDefaultChild() : INode
		{
			return _proxying( _referer.getDefaultChild() );
		}

		override public function getDefaultNode() : INode
		{
			return _proxying( _referer.getDefaultNode() );
		}

		override public function getChild( id : String ) : INode
		{
			return _proxying( _referer.getChild( id ) );
		}

		override public function hasChild( id : String ) : Boolean
		{
			return _referer.hasChild( id );
		}

		override public function addChild( node : INode ) : INode
		{
			if( node is WeakNode )
				throw 'Node is WeakNode';

			return _referer.addChild( node );
		}

		override public function parent() : INode
		{
			return _proxying( _referer.parent() );
		}

		override public function scan( traverser : INodeTraverser ) : void
		{
			_referer.scan( traverser );
		}

		override public function describe( descriptor : INodeDescriptor, target : INode = null ) : void
		{
			_referer.describe( descriptor, target );
		}

		override public function getChilds() : Array
		{
			var from : Array = _referer.getChilds();
			var out : Array = [];

			for (var i : int = 0; i < from.length; i++)
			{
				out[i] = _proxying( from[i] as INode );
			}

			return out;
		}

		override public function getId() : String
		{
			return _id;
		}

		override public function getDevice(device : String = null) : INode
		{
			return _referer.getDevice( device );
		}

		override public function hasDevice( device : String ) : Boolean
		{
			return _referer.hasDevice( device );
		}

		override public function getDefaultPath() : IPath
		{
			return _referer.getDefaultPath();
		}

		override public function getDefaultDevice() : INode
		{
			return _referer.getDefaultDevice();
		}

		// _____________________________________________________________________________
		// PRIVATES
		public static var lolid : int = 0;
		public var plolid : int = 0;

		private function register() : void
		{
			_referer.addEventListener( NodeEvent.ADDED, _refBEvent, false );
			_referer.addEventListener( NodeEvent.ADDED, _refBEvent, true );
			
			_referer.addEventListener( NodeEvent.CHANGE, _refBEvent, false );
			_referer.addEventListener( NodeEvent.CHANGE, _refBEvent, true );
			
			_referer.addEventListener( NodeEvent.CHILD_ADDED, _refBEvent, false);
			_referer.addEventListener( NodeEvent.CHILD_ADDED, _refBEvent, true );
			
			_referer.addEventListener( NodeEvent.CHILD_CHANGE, _refBccEvent, false );
			_referer.addEventListener( NodeEvent.CHILD_CHANGE, _refBccEvent, true );

			_referer.addEventListener( NodeEvent.DEFAULT_CHANGE, _refBEvent, false );
			_referer.addEventListener( NodeEvent.DEFAULT_CHANGE, _refBEvent, true );
			
			_referer.addEventListener( NodeEvent.PARAM_CHANGE, _refBEvent, false );
			_referer.addEventListener( NodeEvent.PARAM_CHANGE, _refBEvent, true );

			_referer.addEventListener( NodeEvent.PATH_CHANGE, _refBEvent, false );
			_referer.addEventListener( NodeEvent.PATH_CHANGE, _refBEvent, true );

		}

		private function _refBEvent( event : NodeEvent ) : void
		{
			dispatchEvent( event );
		}

		private function _refBccEvent( event : NodeEvent ) : void
		{
			//if( _childs && _childs.length > 0 )
			dispatchEvent( event );
		}

		/**
		 * internal use only
		 * called by the Tree when this node become unactive and should be eligible for GC, as well as the module connect to him.
		 * @see Tree.dispose() 
		 */
		bi_internal function dispose() : void
		{
			_dispose();
			
			_referer.removeEventListener( NodeEvent.ADDED, _refBEvent, false );
			_referer.removeEventListener( NodeEvent.ADDED, _refBEvent, true );
			
			_referer.removeEventListener( NodeEvent.CHANGE, _refBEvent, false );
			_referer.removeEventListener( NodeEvent.CHANGE, _refBEvent, true );
			
			_referer.removeEventListener( NodeEvent.CHILD_ADDED, _refBEvent, false);
			_referer.removeEventListener( NodeEvent.CHILD_ADDED, _refBEvent, true );
			
			_referer.removeEventListener( NodeEvent.CHILD_CHANGE, _refBccEvent, false );
			_referer.removeEventListener( NodeEvent.CHILD_CHANGE, _refBccEvent, true );

			_referer.removeEventListener( NodeEvent.DEFAULT_CHANGE, _refBEvent, false );
			_referer.removeEventListener( NodeEvent.DEFAULT_CHANGE, _refBEvent, true );
			
			_referer.removeEventListener( NodeEvent.PARAM_CHANGE, _refBEvent, false );
			_referer.removeEventListener( NodeEvent.PARAM_CHANGE, _refBEvent, true );

			_referer.removeEventListener( NodeEvent.PATH_CHANGE, _refBEvent, false );
			_referer.removeEventListener( NodeEvent.PATH_CHANGE, _refBEvent, true );
			
			_referer = null;
		}

		bi_internal function getReferer() : INode
		{
			return _referer;
		}

		private var _referer : INode;

	}
}
