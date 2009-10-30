////////////////////////////////////////////////////////////////////////////////
//
//  DIGITAS FRANCE / VIVAKI COMMUNICATIONS
//  Copyright 2008-2009 Digitas France
//  All Rights Reserved.
//
//  NOTICE: Digitas permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


package fr.digitas.flowearth.mvc.address.structs.abstract {
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.event.FlowEventDispatcher;
	import fr.digitas.flowearth.event.NodeEvent;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;
	
	import flash.net.URLVariables;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;	

	/**
	 * Absract node. Base class to INode objects.
	 * Handle Collection nature of node's structure
	 * doesn't handle activated/deactivated state of each nodes and sync with any model.
	 * 
	 * @author Pierre Lepers
	 */
	public class AbstractNode extends FlowEventDispatcher implements INode {

		
		public function AbstractNode( descriptor : INodeDescriptor = null ) {
			_childs = new Array( );
			_cMap = new Dictionary( true );
			if( descriptor ) 
				describe( descriptor );
			super( );
		}

		/** @inheritDoc */
		public function getDefaultId() : String {
			return _default;
		}

		/** @inheritDoc */
		public function getId() : String {
			return _id;
		}

		/** 
		 * ABSTRACT
		 * @private 
		 */
		public function activate( path : IPath = null ) : void {
			// abstract, need INodeSystem
		}

		/** 
		 * ABSTRACT
		 * @private 
		 */
		public function isActive() : Boolean {
			return _active || ( _parent==null );
		}

		/** 
		 * ABSTRACT
		 * @private 
		 */
		public function getCurrentChild() : INode {
			// abstract, need INodeSystem
			return null;
		}

		
		
		/** @inheritDoc */
		public function getParams() : URLVariables {
			return _params;
		}

		
		/**
		 * add a child node to this one.
		 * if a node with the same id exist the node isn't added and the method return the current node;
		 * 
		 * @return Node true if the node is added, false otherwise
		 * 
		 * @throws Error if the node to add still added in other structure
		 */
		public function addChild( node : INode ) : INode {
			var current : AbstractNode = _cMap[ node.getId( ) ];
			if( current != null ) {
				current.describe( node );
				//if( ! current.getDefaultId( ) ) current.bi_internal::setDefaultId( node.getDefaultId( ) );
				return current;
			}
			_childs.push( node );
			_cMap[ node.getId( ) ] = node;
			( node as AbstractNode ).bi_internal::setParent( this );

			bi_internal::fireCapture( new NodeEvent( NodeEvent.CHILD_ADDED , this , true ) );
			bi_internal::fireBubbling( new NodeEvent( NodeEvent.CHILD_ADDED , this ) );
			return node;
		}

		
		/** @inheritDoc */
		public function getChilds() : IIterator {
			return new Iterator( _childs );
		}

		
		/** @inheritDoc */
		public function getDefaultChild() : INode {
			if( _default && hasChild( _default ) )
				return getChild( _default );
			return null;
		}

		
		/** @inheritDoc */
		public function getDefaultNode() : INode {
			if( _default && hasChild( _default ) )
				return getChild( _default ).getDefaultNode( );
			return this;	
		}

		
		/** @inheritDoc */
		public function getChild( id : String ) : INode {
			var res : INode = _cMap[ id ];
			if( ! res ) throw new ArgumentError( this + " No child with the given id '" + id + "' in node '" + _id + "'" );
			return _cMap[ id ];
		}

		
		/** @inheritDoc */
		public function hasChild( id : String ) : Boolean {
			return ( _cMap[ id ] != undefined );
		}

		
		/** @inheritDoc */
		public function path() : IPath {
			// abstract
			return null;
		}
		
		/** @inheritDoc */
		public function get activePath() : IPath {
			// abstract
			return null;
		}

		
		/** @inheritDoc */
		public function parent() : INode {
			return _parent;
		}

		
		/** @inheritDoc */
		public function scan(traverser : INodeTraverser) : void {
			if( ! traverser.enter( this ) ) return;
			var l : int = _childs.length;
			for (var i : int = 0; i < l ; i += 1 )
				_childs[i].scan( traverser );
			traverser.leave( this );
		}
		
		/** @inheritDoc */
		public function describe( descriptor : INodeDescriptor, target : INode = null ) : void {
			if( _id != null && _id != descriptor.getId( ) )
				throw new Error( "Node description : forbidden id redefinition" );
			_id = descriptor.getId( );
			if( descriptor.getDefaultId( ) )
				bi_internal::setDefaultId( descriptor.getDefaultId( ) );
			
			target = target || this;
			var iter : IIterator = descriptor.getChilds( );
			var subDesc : INodeDescriptor;
			
			while( iter.hasNext( ) ) {
				subDesc = iter.next( ) as INodeDescriptor;
				var node : INode = createNode( subDesc );
				node = target.addChild( node );
			}
		}

		//_____________________________________________________________________________
		//															   INodeSystem impl
		
		/**
		 * param is not used, this return himself in any case
		 * 
		 * @inheritDoc
		 */
		public function getDevice(device : String = null) : INode {
			return this;
		}
		
		/**
		 * return true if param eqauls node id
		 */
		public function hasDevice(device : String) : Boolean {
			return ( device == _id );
		}
		
		/**
		 * return path of this node
		 */
		public function getDefaultPath() : IPath {
			return path();
		}
		
		/**
		 * return himself
		 */
		public function getDefaultDevice() : INode {
			return this;
		}

		override public function toString() : String {
			return "[object "+getQualifiedClassName(this)+" id:" + _id + " ]";
		}
		
		/**
		 * by default listener are added for capture flow.
		 */
		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = true, priority : int = 0, useWeakReference : Boolean = false) : void {
			super.addEventListener( type , listener , useCapture , priority , useWeakReference );
		}

		//_____________________________________________________________________________
		//																	  INTERNALS

		bi_internal function setParent( parent : INode ) : void {
			_parent = parent;
			dispatchEvent( new NodeEvent( NodeEvent.ADDED , this ) );
		}

		bi_internal function setDefaultId( id : String ) : void {
			if( _default == id ) return;
			_default = id;
			dispatchEvent( new NodeEvent( NodeEvent.DEFAULT_CHANGE , this , false ) );
		}

		bi_internal function setParams( params : URLVariables ) : void {
			_params = params;
			dispatchEvent( new NodeEvent( NodeEvent.PARAM_CHANGE , this ) );
		}
		
		bi_internal function fireCapture( event : NodeEvent ) : void {
			if( _parent )
				_parent.bi_internal::fireCapture( event );
			dispatchEvent( event );
		}

		
		bi_internal function fireBubbling( event : NodeEvent ) : void {
			dispatchEvent( event );
			if( _parent )
				_parent.bi_internal::fireBubbling( event );
		}

		//_____________________________________________________________________________
		//																	  PROTECTED
		
		/**
		 * Create an instance of an INode corresponding to the given descriptor
		 * If you extend AbstractNode you must override this methode to create an instance fo your own type.
		 */
		protected function createNode( descriptor : INodeDescriptor ) : INode {
			return null;
			descriptor;
		}

		/**
		 * destroy this node and all his childs
		 */
		protected function _dispose() : void {
			while( _childs.length > 0 ) _childs.pop( ).bi_internal::dispose( );
			_childs = null;
			_parent = null;
			_cMap = null;
		}

		
		/**
		 * represent the name/id of the node.
		 */
		protected var _id : String;

		/**
		 * teh parent of this node.
		 * can be empty if the node is root node.
		 */
		protected var _parent : INode;

		/**
		 * actual parameters associated to node activation
		 */
		protected var _params : URLVariables;

		/**
		 * internaly store activation state
		 */
		protected var _active : Boolean;

		/**
		 * the default child id
		 */
		protected var _default : String;

		/**
		 * Childs of this node
		 * Can be empty if node is a leaf
		 */
		protected var _childs : Array/*AbstractNode*/;

		/**
		 * map of childs nodes by childs nodes id's
		 */
		protected var _cMap : Dictionary/*String,AbstractNode*/;
		
	}
}