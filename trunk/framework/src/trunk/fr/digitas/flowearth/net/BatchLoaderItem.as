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


package fr.digitas.flowearth.net {
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.event.BatchEvent;
	import fr.digitas.flowearth.net.AbstractBLoader;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;	
	
	use namespace bi_internal;
	
	/**
	 * dispatché lorsque le loader est initialisé
	 */[Event(name="init", type="flash.events.Event")]	

	/**
	 * Loader batchable, egalement <code>IProgressor</code>
	 * 
	 * @author Pierre Lepers
	 */
	public class BatchLoaderItem extends AbstractBLoader {

		public var loader : Loader;
		
		/**
		 * if set to true item will be considered as complete when INIT event is dispatched.
		 */
		public var useInit : Boolean = false;
		
		
		public function BatchLoaderItem ( request : URLRequest, context : LoaderContext = null, params : Object = null, statusMessage : String = null, failOnError : Boolean = false ) : void {
			super( request, context, params, statusMessage, failOnError );
			loader = new Loader( );
			register( loader.contentLoaderInfo );
		}

		override public function execute () : void {
			super.execute();
			loader.load( _request, _context );
		}		

		
		override public function dispose () : void {
			try {	
				loader.close( );
				loader.unload( );
			} catch( e : Error ) {};
			unregister( );
			dispatchEvent( new BatchEvent( BatchEvent.DISPOSED, this ) );
			super.dispose();
		}

		override protected function onInit(e : Event) : void {
			super.onInit( e );
			if( useInit ) {
				dispatchEvent( new Event( Event.COMPLETE ) );
			}
		}
	}
}