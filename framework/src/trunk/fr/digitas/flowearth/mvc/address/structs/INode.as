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


package fr.digitas.flowearth.mvc.address.structs {
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;
	
	import flash.events.IEventDispatcher;
	import flash.net.URLVariables;	

	/**
	 * Interface for all elements in a tree structure
	 * 
	 * INode can be used as a <code>INodeSystem</code>. In this can it is a NodeSystem with unique device, himself
	 * INode can be used a INodeDescriptor
	 * 
	 * @author Pierre Lepers
	 */
	public interface INode extends IEventDispatcher, INodeDescriptor, INodeSystem {

		/**
		 * return a boolean indicate if node is currently in chain of acive nodes
		 * note that a root node (node without parent is always considered as active )
		 */
		function isActive() : Boolean;

		/**
		 * activate the given relative path in this node. If no path given, activate this node that has effect to deactivate potentialy active childs.
		 * @param IPath path to activate.
		 */
		function activate( path : IPath = null ) : void;

		/**
		 * the child that should be activate if no child explicitely active, null if no default id defined
		 */
		function getDefaultChild() : INode;

		/**
		 * go down in nodes tree to find the defaults
		 * return this if no defaults
		 */
		function getDefaultNode() : INode;

		/**
		 * the child currently active, null if no child currently active
		 */
		function getCurrentChild() : INode;

		/**
		 * return a child with the given id
		 * @throws Error if there's no child with the given id.
		 */
		function getChild( id : String ) : INode;

		/**
		 * return the parameters associated to the node activation, null if no params associated.
		 */
		function getParams() : URLVariables;

		/**
		 * return true if a child with the given id exist.
		 */
		function hasChild( id : String ) : Boolean;

		/**
		 * add the given child to list of childs, 
		 * if a child with the same id already exist, given child is not added and the function return this old child.
		 */
		function addChild( node : INode ) : INode;
		
		/**
		 * return the <code>IPath</code> pointing to this node
		 */
		function path() : IPath;
		
		/**
		 * return the currently active path of this node, null if node isn't active.
		 */
		function get activePath() : IPath;
		
		/**
		 * return the parent of this node. 
		 * this value can be null if node is a tree type.
		 */
		function parent( ) : INode;
		
		/**
		 * run an INodeTraverser inside nodes hierarchie
		 */
		function scan( traverser : INodeTraverser ) : void;
		
		
		function describe( descriptor : INodeDescriptor, target : INode = null ) : void
	}
		
}
