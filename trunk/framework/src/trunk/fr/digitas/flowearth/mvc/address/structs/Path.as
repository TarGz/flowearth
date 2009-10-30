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
	import fr.digitas.flowearth.event.NodeEvent;
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractPath;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;
	import fr.digitas.flowearth.utils.VariablesTools;
	
	import flash.net.URLVariables;	

	/**
	 * Concrete implementation of AbstractPath.
	 * Able to solve path and manage node's structure
	 * 
	 * @author Pierre Lepers
	 */
	public class Path extends AbstractPath implements IPath {
		
		public function Path( path : String , params : URLVariables = null ) {
			_system = GLOBAL_SYSTEM;
			super( path , params );
		}

		override public function append(path : IPath) : IPath {
			var fpath : String = _device ? _device + DEVICE_SEP + SEPARATOR : "";
			fpath += _path + SEPARATOR + path.getPath( );
			var params : URLVariables = VariablesTools.concat( _params , path.getParams( ) );
			return new Path( fpath , params ) as IPath;
		}

		override public function clone() : IPath {
			return new Path( toString( ) );
		}
		
		/**
		 * provide a copy of internaly solved node's branch
		 */
		override public function nodes(until : INode = null) : Array {
			return [].concat( _getNodes() );
		}

		override public function toNode() : INode {
			var na : Array = _getNodes( );
			if( ! _exist ) return null;
			return na[ na.length - 1 ];
		}
		
		override public function nodeExist() : Boolean {
			if( ! _nodes ) _nodes = _solveNodes( );
			return _exist;
		}

		override public function makeRelative(parent : IPath) : IPath {
			var str : String = makeRelativeString( parent );
			if( str == null ) return null;
			return new Path( str , _params );
		}

		override public function cleanup() : IPath {
			if( ! _nodes ) _nodes = _solveNodes( );
			return _nodes[ _nodes.length - 1 ].path();
		}

		/**
		 * lazy creation of node's branch
		 */
		protected function _getNodes( until : INode = null ) : Array {
			if( ! _nodes ) _nodes = _solveNodes( );
			return _nodes;
		}
		
		protected function _solveNodes() : Array {
			
			var ref : Path;
			
			if( ! isAbsolute() ) 
				ref = makeAbsolute( _system.getDefaultPath() ) as Path;
			else 
				ref = this;
			
			var segs : Array = ref.segments();
			var currNode : INode = ref._getBaseNode( );
			
			var ns : Array = [ currNode ];
			
			var l : int = segs.length;
			var i : int = - 1;
			_exist = true;
			while( ++ i < l ) {
				if( ! currNode.hasChild( segs[i] ) ) {
					_exist = false;
					break;	
				}
				currNode = currNode.getChild( segs[i] );
				ns.push( currNode );
			}
			
			currNode.addEventListener( NodeEvent.CHILD_ADDED , onChildAdded , false , 200 , true );
			return ns;
		}
		
		/**
		 * @internal
		 * invalidate _nodes value, whenever the structure is modified
		 */
		protected function onChildAdded(event : NodeEvent) : void {
			while( _nodes.length > 0 )
				_nodes.pop( ).removeEventListener( NodeEvent.CHILD_ADDED , onChildAdded );
			_nodes = null;
		}

		
		internal function _getBaseNode() : INode {
			if( ! isAbsolute( ) )
				return null;
			return _device ? _system.getDevice( _device ) : _system.getDefaultDevice( );
		}

		protected var _nodes : Array;

		protected var _exist : Boolean;

		protected var _system : INodeSystem;
		
		public static var GLOBAL_SYSTEM : INodeSystem = nodeSystem;
	}
}
