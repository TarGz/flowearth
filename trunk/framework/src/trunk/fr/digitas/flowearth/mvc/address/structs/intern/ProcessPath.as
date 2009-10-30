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


package fr.digitas.flowearth.mvc.address.structs.intern {
	import fr.digitas.flowearth.core.IDisposable;	
	import fr.digitas.flowearth.mvc.address.structs.INodeSystem;
	import fr.digitas.flowearth.mvc.address.structs.Path;	

	/**
	 * Path running in specific <code>INodeSystem</code>
	 * internal use
	 * 
	 * if relative, treated as a Path object
	 * if absolute, root node solved with given specific system 
	 * 
	 * @author Pierre Lepers
	 */
	public class ProcessPath extends Path implements IDisposable {

		public function ProcessPath( system : INodeSystem, path : String = "/" ) {
			super( path );
			_system = system;
		}
		
		public function dispose() : void {
			_system = null;
		}
		
	}
	
}
