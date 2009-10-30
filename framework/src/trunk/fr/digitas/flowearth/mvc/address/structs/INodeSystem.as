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

	/**
	 * Store a list of node considered as device ( root nodes of node's trees )
	 * Used by IPath to solve reference to a node
	 * 
	 * @author Pierre Lepers
	 */
	public interface INodeSystem {
		
		/**
		 * return the corresponding to the given device id
		 * return the default device if null is passed as parameter
		 * return null if the device id doesn't exist
		 */
		function getDevice( device : String = null ) : INode;

		/**
		 * check if a node exist for the given id
		 */
		function hasDevice( device : String ) : Boolean;
		
		/**
		 * return the path to use for solve relative path ("./a/b")
		 */
		function getDefaultPath() : IPath;
		
		/**
		 * device to use if no device provided in a IPath ("/a/b")
		 */
		function getDefaultDevice() : INode;
		
	}
}
