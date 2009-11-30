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
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.event.NodeEvent;
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractNode;
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractPath;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.intern.ProcessPath;
	import fr.digitas.flowearth.mvc.address.structs.proxy.WeakNode;	
	
	/**
	 * Dispatched when activation of any descendant or this node itself change
	 * 
	 * <p>This event has the following properties :</p>
	 * <table class='innertable'>
	 * <tr><th>bubbles</th><th>true. This event bubbles in nodes structure</th></tr>
	 * <tr><th>cancelable</th><th>false</th></tr>
	 * <tr><th>currentTarget</th><th>The object that is actively processing the Event object with an event listener.</th></tr>
	 * <tr><th>target</th><th>the <code>INode</code> which has been activated</th></tr>
	 * </table>
	 * 
	 * @eventType NodeEvent.PATH_CHANGE
	 */
	[Event( name = "_pathChange", type = "fr.digitas.flowearth.event.NodeEvent" )]

	/**
	 * Dispatched when activation state of this node change.
	 * 
	 * <p>This event has the following properties :</p>
	 * <table class='innertable'>
	 * <tr><th>bubbles</th><th>false</th></tr>
	 * <tr><th>cancelable</th><th>false</th></tr>
	 * <tr><th>currentTarget</th><th>The object that is actively processing the Event object with an event listener.</th></tr>
	 * <tr><th>target</th><th>this node itself</th></tr>
	 * </table>
	 * 
	 * @eventType NodeEvent.CHANGE
	 */
	[Event( name = "_nodeChange", type = "fr.digitas.flowearth.event.NodeEvent" )]

	/**
	 * Dispatched when a child's activation state change.
	 * 
	 * <p>This event has the following properties :</p>
	 * <table class='innertable'>
	 * <tr><th>bubbles</th><th>false</th></tr>
	 * <tr><th>cancelable</th><th>false</th></tr>
	 * <tr><th>currentTarget</th><th>The object that is actively processing the Event object with an event listener.</th></tr>
	 * <tr><th>target</th><th>this node itself</th></tr>
	 * </table>
	 * 
	 * @eventType NodeEvent.CHILD_CHANGE
	 */
	[Event( name = "_child_nodeChange", type = "fr.digitas.flowearth.event.NodeEvent" )]
	
	
	
	/**
	 * Concrete implementation of AbstractNode
	 * Handle activation/deactivation action of node's branch, result of sync with a model (eg. browser Url segment) 
	 * 
	 * @author Pierre Lepers
	 */
	public class Node extends AbstractNode {

		public function Node( descriptor : INodeDescriptor = null ) {
			super( descriptor );
		}
		
		/** @inheritDoc */
		override public function get activePath() : IPath {
			return _activePath;
		}

		/** @inheritDoc */
		override public function activate( path : IPath = null ) : void {
			
			if( path ) {
				if( ! path.isAbsolute( ) ) 
					path = path.makeAbsolute( this.path( ) );
				path.toNode( ).activate( );
				return;
			}

			if( getDefaultChild() ) {
				getDefaultChild().activate();	
				return;
			}
			
			
			var l : int, i : int;
			var common : INode = this;
			var n : INode;
			var achain : Array = [];
			var uchain : Array = [];
			var dchain : Array;
			var chain : Array = uchain;
			var cross : INode;
			var ps : String = "";
			
			
			while( common ) {
				chain.push( common );
				if( common.isActive( ) ) chain = achain;
				else cross = common; //TODO optim : set multiple times for nothing?
				common = common.parent( );
			}

			
			uchain.reverse( );
			achain.reverse( );
			chain = achain.concat( uchain );

			if( isActive( ) ) {
				var cc : INode = getCurrentChild( );
				
				if( !cc ) return;
				
				l = chain.length;
				while ( -- l > - 1 ) {
					n = chain[ l ];
					n.bi_internal::_activate( new ProcessPath( n , ps ) );
					ps = AbstractPath.SEPARATOR + n.getId( ) + ps;
				}
				
				chain = chain.concat( cc.bi_internal::_deactivate( ) );
				
				i = - 1;
				l = chain.length;
				while( ++ i < l ) 	chain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , true ) );
				i --;
				while( -- i > -1 ) 	chain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , false ) );
				return;
			}
			
			//achain contain the common part
			//uchain contain the newly activated part

			cross = cross.parent( );
			
//			trace( "uchain 1" , uchain );
//			trace( "achain 1" , achain );
//			trace( "cross" , cross );
			
			
			// deactivate old branch
			( cross as Node ).pendingSwitch( );

			if( cross && cross.getCurrentChild( ) ) {
				dchain = cross.getCurrentChild( ).bi_internal::_deactivate( );
//				dchain.reverse( );
			}
			
			// activate whole branch (common and new one)
			l = chain.length;
			while ( -- l > - 1 ) {
				n = chain[ l ];
				n.bi_internal::_activate( new ProcessPath( n , ps ) );
				ps = AbstractPath.SEPARATOR + n.getId( ) + ps;
			}
			
			
			// dispatch PATH_CHANGE (capture) in common branch
			l = achain.length;
			i = - 1;
			while( ++ i < l ) achain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , true ) );
			
			cross.dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , true ) );
			
			// dispatch PATH_CHANGE in old branch
			if( dchain ) {
				l = dchain.length;
				i = - 1;
				while( ++ i < l ) 
					dchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , true ) );
				i --;
				while( -- i > -1 ) 
					dchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , false ) );
			}
			
			// dispatch change in newly activated branch
			l = uchain.length;
			i = 0;
			while( ++ i < l ) {
				uchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , true ) );
				uchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.CHANGE , this , true ) );
			}
			i --;
			while( -- i > 0 ) {
				uchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , false ) );
				uchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.CHANGE , this , false ) );
			}

			cross.dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , false ) );
			
			// dispatch PATH_CHANGE (capture) in common branch
			l = achain.length;
			while( -- l > - 1 ) achain[ l ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , false ) );
		}

		/**
		 * called to notify this node that a child desactivation will be follow by an othe r child activation
		 * in order to delay dispatch ofchild_change event 
		 */
		private function pendingSwitch() : void {
			_pendingSwitch = true;
		}

		/** @inheritDoc */
		override public function path() : IPath {
			var pchain : Array = [ _id ];
			var n : INode = this;
			while( (n = n.parent( ) ) != null )
				pchain.push( n.getId( ) );
			pchain = pchain.reverse( );
			var pStr : String = pchain.shift( ) + AbstractPath.DEVICE_SEP + pchain.join( AbstractPath.SEPARATOR );
			return new Path( pStr );
		}
		
		/** @inheritDoc */
		override public function getCurrentChild() : INode {
			for each (var n : INode in _childs) 
				if( n.isActive( ) ) return n;
			return null;
		}
		
		/** @inheritDoc */
		override public function addChild(node : INode) : INode {
			var result : INode = super.addChild( node );
			result.addEventListener( NodeEvent.CHANGE , onChildChange , true , - 20000 );
			result.addEventListener( NodeEvent.CHANGE , onChildChange , false , - 20000 );
			return result;
		}

		
		//_____________________________________________________________________________
		//																	   PRIVATES

		/**
		 * provide a weak representation of this node, 
		 * design to be given to a module and avoid GC lock
		 * @see WeakNode
		 */
		bi_internal function weakNode( ) : INode {
			var n : INode = new WeakNode( this );
			return n;
		}
		
		/** @inheritDoc */
		bi_internal function _activate( path : ProcessPath ) : void {
			if( _activePath ) _activePath.dispose( );
			_activePath = path;
			_active = true;
			//dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , false ) );
		}
		/** @inheritDoc */
		bi_internal function _deactivate() : Array {
			//debug
			if( ! _active ) throw new Error( "bi.mvc.address.structs.Node - _deactivate : already unactive node "+getId() );
			
			var target : INode = _activePath.toNode( );
			_active = false;
			
			_activePath.dispose( );
			_activePath = null;
			

//			dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , true ) );
			dispatchEvent( new NodeEvent( NodeEvent.CHANGE , target , true ) );
			
			var res : Array;
			var cc : INode = getCurrentChild( );
			if( cc ) {
				res = cc.bi_internal::_deactivate( );
//				dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE , this , false ) );
				dispatchEvent( new NodeEvent( NodeEvent.CHANGE , target , false ) );
			} else res = [];
			
			res.unshift( this );
			return res;
		}
		/** @inheritDoc */
		override protected function createNode( descriptor : INodeDescriptor ) : INode {
			return new Node( descriptor );
		}

		private function onChildChange(event : NodeEvent) : void {
			if( ! event.nodeCurrentTarget.isActive( ) && _pendingSwitch ) return;
			_pendingSwitch = false;
			dispatchEvent( new NodeEvent( NodeEvent.CHILD_CHANGE , this , event.capureFlow ) );
		}

		protected var _activePath : ProcessPath;
		
		protected var _pendingSwitch : Boolean = false;
		
	}
}
