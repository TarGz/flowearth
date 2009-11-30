package fr.digitas.flowearth.ui.tabs {
	import flash.events.Event;
	import flash.events.EventDispatcher;		

	/**
	 * @author Pierre Lepers
	 */
	public class TabData extends EventDispatcher {

		
		public function TabData( id : String ) {
			_id = id;
		}

		public function get label() : String {
			return _label;
		}
		
		public function set label(label : String) : void {
			_label = label;
			dispatchEvent( new Event( Event.CHANGE ) );
		}

		public function get id() : String {
			return _id;
		}

		private var _label : String;

		private var _id : String;
		
	}
}
