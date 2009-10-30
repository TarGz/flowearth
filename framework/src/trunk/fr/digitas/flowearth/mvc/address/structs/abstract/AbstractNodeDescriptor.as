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
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;	

	/**
	 * Basic implementation of <code>INodeDescriptor</code>
	 * 
	 * @author Pierre Lepers
	 */
	public class AbstractNodeDescriptor implements INodeDescriptor {
		
		
		public function getChilds() : IIterator {
			return new Iterator( _childs );
		}
		
		public function getId() : String {
			return _id;
		}
		
		public function getDefaultId() : String {
			return _defaultId;
		}
		
		protected var _id : String;
		
		protected var _defaultId : String;
		
		protected var _childs : Array/*INodeDescriptor*/; 
	}
}
