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


package fr.digitas.flowearth.mvc.address.structs.traverser {
	import fr.digitas.flowearth.mvc.address.structs.INode;				

	/**
	 * @author Pierre Lepers
	 */
	public interface INodeTraverser {

		function enter( node  : INode ) : Boolean;

		function leave( node  : INode ) : void;

	}
	
}
