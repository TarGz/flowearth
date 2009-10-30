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
	import fr.digitas.flowearth.command.IBatchable;	
	
	import flash.events.Event;
	import flash.events.ProgressEvent;	

	/**
	 * Dispatché par les Ibatchable.
	 * 
	 * Etend <code>ProgressEvent</code> mais gere la ponderation des items pour avoir une progression lineaire du batcher
	 * 
	 * @author Pierre Lepers
	 */
	public class BatchProgressEvent extends ProgressEvent {
		
		
		public static const ITEM_PROGRESS : String = "fdf_bitemProgress";
		
		public function get item() : IBatchable {
			return _item;
		}

		public function BatchProgressEvent (type : String, item : IBatchable, bubbles : Boolean = false, bytesLoaded : uint = 0, bytesTotal : uint = 0 ) {
			_item = item;
			super( type, bubbles, false, bytesLoaded, bytesTotal );
		}

		public override function clone () : Event {
			return new BatchProgressEvent( type, _item, bubbles, bytesLoaded, bytesTotal );
		}

		private var _item : IBatchable;
	}
}
