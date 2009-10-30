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


package fr.digitas.flowearth.mvc.address.structs.proxy {
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.event.NodeEvent;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractNode;
	
	import flash.net.URLVariables;	

	/**
	 * Provide a copy structure of a nodes structure.
	 *
	 * provide a weak representation of a node, to avoid GC lock
	 * 
	 * @author Pierre Lepers
	 */
	public class WeakNode extends AbstractNode implements INode {
		
		
		
		public function WeakNode( referer : INode ) {
			super( );
			_referer = referer;
			_id = _referer.getId( );
			register( );
		}
		
		//_____________________________________________________________________________
		//																	  OVERRIDES
		
		
		override public function isActive() :Boolean {
			return _referer.isActive();	
		}
		
		override public function activate( path : IPath = null ) : void {
			_referer.activate( path );	
		}
		
		override public function getDefaultId() : String {
			return _referer.getDefaultId();
		}

		override public function getParams() : URLVariables {
			return _referer.getParams( );
		}

		override public function path() : IPath {
			return _referer.path( );
		}
		
		override public function getCurrentChild() : INode {
			for each (var n : INode in _childs) 
				if( n.isActive() ) return n;
			return null;
		}
		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		private function register() : void {
			_referer.addEventListener( NodeEvent.PARAM_CHANGE, _refBEvent );
			_referer.addEventListener( NodeEvent.CHANGE , _refBEvent );
			_referer.addEventListener( NodeEvent.CHANGE , _refBEvent, true );
			_referer.addEventListener( NodeEvent.CHILD_CHANGE , _refBccEvent );
			_referer.addEventListener( NodeEvent.CHILD_CHANGE , _refBccEvent, true );
		}
		
		private function _refBEvent(event : NodeEvent) : void {
			dispatchEvent( event );
		}

		
		private function _refBccEvent(event : NodeEvent) : void {
			if( _childs && _childs.length > 0 )
				dispatchEvent( event );
		}


		/**
		 * internal use only
		 * called by the Tree when this node become unactive and should be eligible for GC, as well as the module connect to him.
		 * @see Tree.dispose() 
		 */
		bi_internal function dispose() : void {
			_dispose();
			
			_referer.removeEventListener( NodeEvent.PARAM_CHANGE, _refBEvent );
			_referer.removeEventListener( NodeEvent.CHANGE , _refBEvent );
			_referer.removeEventListener( NodeEvent.CHANGE , _refBEvent, true );
			_referer.removeEventListener( NodeEvent.CHILD_CHANGE , _refBccEvent );
			_referer.removeEventListener( NodeEvent.CHILD_CHANGE , _refBccEvent, true );
			_referer = null;
		}

		bi_internal function getReferer() : INode {
			return _referer;
		}
	
		
		private var _referer : INode;
	}
}
