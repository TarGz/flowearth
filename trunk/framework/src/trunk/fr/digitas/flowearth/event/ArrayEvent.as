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
	 * Event contenant un parametre Array
	 * 
	 * @author Pierre Lepers
	 */
	final public class ArrayEvent extends Event {
		
		public function get array() : Array {
			return _array;	
		}
		
		public function ArrayEvent (type : String, array : Array , bubble : Boolean = false, cancelable : Boolean = false) {
			super( type, bubble, cancelable );
			_array = array;
		}
		
		
		private var _array : Array;
	}
}
