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
	import flash.events.Event;
	import flash.events.EventPhase;	

	/**
	 * @author Pierre Lepers
	 */
	public class FlowEvent extends Event {

		
		public function get nativeType() : String {
			return _nativeType;
		}
		
		public function get capureFlow() : Boolean {
			return _capureFlow;
		}

		override public function get eventPhase() : uint {
			return _capureFlow ? EventPhase.CAPTURING_PHASE : ( target == currentTarget ? EventPhase.AT_TARGET : EventPhase.BUBBLING_PHASE);
		}

		public function FlowEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false, capureFlow : Boolean = false ) {
			_nativeType = type;
			if( capureFlow ) type = FlowEventDispatcher.CAPTURE_PREFIX + _nativeType;
			_capureFlow = capureFlow;
			super( type , bubbles , cancelable );
		}

		override public function clone() : Event {
			var c : FlowEvent = new FlowEvent( type, bubbles, cancelable );
			return c;
		}
		
		protected var _nativeType : String;

		protected var _capureFlow : Boolean;
	}
}
