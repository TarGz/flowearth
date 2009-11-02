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


package fr.digitas.flowearth.event {	import flash.events.Event;					
	/**	 * Event contenant un Boolean	 * 	 * @author Pierre Lepers	 */	final public class BoolEvent extends Event {		
		
		public function get flag() : Boolean {
			return _flag;	
		}
		
		public function BoolEvent (type : String, flag : Boolean, bubble : Boolean = false, cancelable : Boolean = false) {
			super(type, bubble, cancelable );
			_flag = flag;		}
		override public function clone() : Event {
			return new BoolEvent( type, _flag, bubbles, cancelable );
		}

		private var _flag : Boolean;
			}}