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


package fr.digitas.flowearth.event {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;	

	/**
	 * EventDispatch support dispatch in capture flow, using a prefix in eventTypes
	 * 
	 * @author Pierre Lepers
	 */
	public class FlowEventDispatcher extends EventDispatcher {

		public static const CAPTURE_PREFIX : String = "__ucf__";

		public function FlowEventDispatcher(target : IEventDispatcher = null) {
			super( target );
		}
		
		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			if( useCapture ) type = CAPTURE_PREFIX + type;
			super.addEventListener( type , listener , false , priority , useWeakReference );
		}

		override public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false ) : void {
			if( useCapture ) type = CAPTURE_PREFIX + type;
			super.removeEventListener( type , listener , false  );
		}

		override public function hasEventListener(type : String) : Boolean {
			return ( super.hasEventListener( type ) || super.hasEventListener( CAPTURE_PREFIX + type ) );
		}

		
	}
}
