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


package fr.digitas.flowearth.mvc.address.structs.connector {
	import fr.digitas.flowearth.event.NodeEvent;	
	import fr.digitas.flowearth.mvc.address.structs.INode;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class NodeConnector {

		
		
		public function NodeConnector() {
			_nodes = [];
		}
		
		public function connectNode( node : INode ) : void {
			if( _nodes.indexOf( node ) > -1 ) return;
			
			node.addEventListener( NodeEvent.PATH_CHANGE, onPathChange );
			_nodes.push( node );
			nodeAdded( node );
		}

		public function disconnectNode( node : INode ) : void {
			var index : int = _nodes.indexOf( node );
			if( index == -1 ) 
				throw new Error( "NodeConnector - disconnectNode : node "+node.getId()+" not registered");
			
			node.removeEventListener( NodeEvent.PATH_CHANGE, onPathChange );
			_nodes.splice( index , 1 );
			nodeRemoved( node );
		}

		
		protected function onPathChange(event : NodeEvent) : void {
			
		}

		protected function nodeAdded( node : INode ) : void {
		}

		protected function nodeRemoved( node : INode ) : void {
		}
	
		protected var _nodes : Array;
	
	}
}
