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

	import flash.net.URLVariables;	

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
		override public function activate( params : URLVariables = null ) : void {

			if( _default && hasChild( _default ) ) {
				getChild( _default ).activate( params );	
				return;
			}
			
			
			var l : int, i : int;
			var common : INode = this;
			var n : Node;
			var achain : Array = [];
			var uchain : Array = [];
			var dchain : Array;
			var chain : Array = uchain;
			var cross : INode;
			var psegs : Array = [];
			
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
				
				if( ! cc ) return;
				
				l = chain.length;
				while ( -- l > - 1 ) {
					n = chain[ l ];
					n.bi_internal::_activate( new ProcessPath( n, psegs, params ) );
					psegs.unshift( n.getId() );
				}
				
				chain = chain.concat( cc.bi_internal::_deactivate( ) );
				
				i = - 1;
				l = chain.length;
				while( ++ i < l ) 	if( chain[i].hasEventListener( NodeEvent.PATH_CHANGE ) ) chain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, true ) );
				i --;
				while( -- i > - 1 ) 	if( chain[i].hasEventListener( NodeEvent.PATH_CHANGE ) ) chain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, false ) );
				return;
			}
			
			//achain contain the common part
			//uchain contain the newly activated part

			cross = cross.parent( );
			
			
			// deactivate old branch
			( cross as Node ).pendingSwitch( );
			
			var ccc : INode;
			if( cross && ( ccc = cross.getCurrentChild( ) ) ) {
				dchain = ccc.bi_internal::_deactivate( );
			}
			
			// activate whole branch (common and new one)
			l = chain.length;
			while ( -- l > - 1 ) {
				n = chain[ l ];
				n.bi_internal::_activate( new ProcessPath( n, psegs, params ) );
				psegs.unshift( n.getId() );
			}
			
			
			// dispatch PATH_CHANGE (capture) in common branch
			l = achain.length;
			i = - 1;
			while( ++ i < l ) if( achain[i].hasEventListener( NodeEvent.PATH_CHANGE ) ) achain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, true ) );
			
			if( cross.hasEventListener( NodeEvent.PATH_CHANGE ) ) 
				cross.dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, true ) );
			
			// dispatch PATH_CHANGE in old branch
			if( dchain ) {
				l = dchain.length;
				i = - 1;
				while( ++ i < l ) 
					if( dchain[i].hasEventListener( NodeEvent.PATH_CHANGE ) ) dchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, true ) );
				i --;
				while( -- i > - 1 ) 
					if( dchain[i].hasEventListener( NodeEvent.PATH_CHANGE ) ) dchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, false ) );
			}
			
			// dispatch change in newly activated branch
			l = uchain.length;
			i = 0;
			while( ++ i < l ) {
				if( uchain[i].hasEventListener( NodeEvent.PATH_CHANGE ) ) uchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, true ) );
				if( uchain[i].hasEventListener( NodeEvent.CHANGE ) ) uchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.CHANGE, this, true ) );
			}
			i --;
			while( -- i > 0 ) {
				if( uchain[i].hasEventListener( NodeEvent.PATH_CHANGE ) ) uchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, false ) );
				if( uchain[i].hasEventListener( NodeEvent.CHANGE ) ) uchain[ i ].dispatchEvent( new NodeEvent( NodeEvent.CHANGE, this, false ) );
			}

			if( cross.hasEventListener( NodeEvent.PATH_CHANGE ) ) 
				cross.dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, false ) );
			
			// dispatch PATH_CHANGE (capture) in common branch
			l = achain.length;
			while( -- l > - 1 ) if( achain[l].hasEventListener( NodeEvent.PATH_CHANGE ) ) achain[ l ].dispatchEvent( new NodeEvent( NodeEvent.PATH_CHANGE, this, false ) );
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
			var device : String = pchain.pop( );
			pchain = pchain.reverse( );
			
			var p : Path = new Path( null, _params );
			p.bi_internal::precompile( pchain, device, 1, 0 );
			return p;
		}

		/** @inheritDoc */
		override public function getCurrentChild() : INode {
			var l : int = _childs.length;
			var n : INode;
			for (var i : int = 0; i < l ; i ++) {
				n = _childs[ i ];
				if( n.isActive( ) ) return n;
			}
			return null;
		}

		/** @inheritDoc */
		override public function addChild(node : INode) : INode {
			var result : INode = super.addChild( node );
			result.addEventListener( NodeEvent.CHANGE, onChildChange, true, - 20000 );
			result.addEventListener( NodeEvent.CHANGE, onChildChange, false, - 20000 );
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
			bi_internal::setParams( path.getParams( ) );
		}

		/** @inheritDoc */
		bi_internal function _deactivate() : Array {
			
			if( ! _active ) throw new Error( "bi.mvc.address.structs.Node - _deactivate : already unactive node " + getId( ) );
			
			var target : INode = _activePath.toNode( );
			_active = false;
			
			_activePath.dispose( );
			_activePath = null;
			
			if( hasEventListener( NodeEvent.CHANGE ) )
				dispatchEvent( new NodeEvent( NodeEvent.CHANGE, target, true ) );
			bi_internal::setParams( null );
			
			var res : Array;
			var cc : INode = getCurrentChild( );
			if( cc ) {
				res = cc.bi_internal::_deactivate( );
				if( hasEventListener( NodeEvent.CHANGE ) )
					dispatchEvent( new NodeEvent( NodeEvent.CHANGE, target, false ) );
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
			if( hasEventListener( NodeEvent.CHILD_CHANGE ) )
				dispatchEvent( new NodeEvent( NodeEvent.CHILD_CHANGE, this, event.capureFlow ) );
		}

		protected var _activePath : ProcessPath;

		protected var _pendingSwitch : Boolean = false;
	}
}
