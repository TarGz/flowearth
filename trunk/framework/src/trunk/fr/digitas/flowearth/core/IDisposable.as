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


package fr.digitas.flowearth.core {
	
	
	/**
	 * Object qui doit pouvoir etre "cleané" :
	 * 
	 * -supression des listeners
	 * -un max de propriété a null
	 * -etc
	 * 
	 * @author Pierre Lepers
	 */
	public interface IDisposable {
		
		function dispose() : void;
		
	}
}
