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

	/**
	 * Evenement pouvant contenir un Number
	 * @author Pierre Lepers
	 */
	final public class NumberEvent extends Event {
		
		public function get value() : Number {
			return _value;	
		}
		
		public function NumberEvent(type : String, value : Number, bubble : Boolean = false, cancelable : Boolean = false) {
			super( type, bubble, cancelable );
			_value = value;
		}

		override public function clone() : Event {
			return new NumberEvent( type, _value, bubbles, cancelable );
		}

		private var _value : Number;
	}
}
