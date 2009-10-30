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


package fr.digitas.flowearth.mvc.address.structs.descriptor {
	import fr.digitas.flowearth.core.IIterator;				

	/**
	 * Basic description of an INode.
	 * 
	 * @author Pierre Lepers
	 */
	public interface INodeDescriptor {

		/**
		 * return childs (INodeDescriptor) of this node
		 */
		function getChilds() : IIterator/*INodeDescriptor*/;

		/**
		 * the id of the node
		 */
		function getId() : String;

		/**
		 * the id of the child that should be activate if no child explicitely active, null if no default id defined
		 */
		function getDefaultId() : String;
		
	}
}
