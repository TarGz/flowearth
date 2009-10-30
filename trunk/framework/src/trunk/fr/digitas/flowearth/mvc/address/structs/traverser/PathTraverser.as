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
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;	

	/**
	 * @author Pierre Lepers
	 */
	public class PathTraverser implements INodeTraverser {

		public function PathTraverser( path : IPath ) {
			this.path = path;
			_compile( );
		}
		
		public function enter(node : INode) : Boolean {
			if( node.getId() != _current )
				return false;
			_current = _segs.shift();
			return true;
		}
		
		public function leave(node : INode) : void {
			
		}
	
		protected function _compile() : void {
			_segs = path.segments();
			_current = _segs.shift();
		}

		protected var path : IPath;
		
		protected var _segs : Array;
		
		protected var _current : String;
	
	}
}
