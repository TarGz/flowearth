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


package fr.digitas.flowearth.mvc.address.structs.system {
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.INodeSystem;
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	
	import flash.utils.Dictionary;	

	public class NodeSystemClass implements INodeSystem {

		
		
		function NodeSystemClass() {
			_devices = new Dictionary( );
		}

		public function getDevice( device : String = null ) : INode {
			return _devices[ device ];
		}

		public function addDevice( node : INode ) : void {
			var id : String = node.getId( );
			if( hasDevice( id ) )
			if( node != _devices[ id ] ) throw new Error( "nodeSystem - addDevice : device '" + id + "' already exist." );
			else return;
			_devices[ id ] = node;
		
			if( ! _defaultPath ) setDefaultNode( node );
			if( ! _defaultDevice ) _defaultDevice = node;
		}

		public function hasDevice( device : String ) : Boolean {
			return ( _devices[ device ] != undefined );
		}

		
		public function setDefaultNode( n : INode ) : void {
			_defaultPath = n.path( );
		}

		public function setDefaultPath( p : IPath ) : void {
			_defaultPath = p;
		}

		public function getDefaultPath() : IPath {
			return _defaultPath;
		}

		
		public function setDefaultDevice( id : String ) : void {
			_defaultDevice = getDevice( id );
		}

		public function getDefaultDevice() : INode {
			return _defaultDevice;
		}

		
		
		private var _devices : Dictionary;

		
		private var _defaultPath : IPath;

		private var _defaultDevice : INode;
	}
}
