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

	final public class XmlEvent extends Event{
		public static const ON_DATA : String = "on_data";
		public static const ON_PROGRESS : String = "on_progress";

		private var _xml:XML;
		
		public function get xml() : XML {
			return _xml;
		}

		public function XmlEvent(type:String, datas:XML , bubble : Boolean = false, cancelable : Boolean = false) {
			super( type, bubble, cancelable );
			_xml = datas;
		}

		override public function clone() : Event {
			return new XmlEvent( type, _xml, bubbles, cancelable );
		}
	}
}