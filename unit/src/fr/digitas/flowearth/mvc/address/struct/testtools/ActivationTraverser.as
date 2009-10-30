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


package fr.digitas.flowearth.mvc.address.struct.testtools {
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;	

	/**
	 * @author Pierre Lepers
	 */
	public class ActivationTraverser implements INodeTraverser {
		
		public function get activeString() : String {
			return _activeString;
		}
		
		public function ActivationTraverser() {
			_activeString = "";
		}

		public function enter(node : INode) : Boolean {
			if( node.isActive() ) 
				_activeString += "/" + node.getId();
			
			return node.isActive();
		}
		
		public function leave(node : INode) : void {
			
		}
		
		private var _activeString : String;
		
	}
}
