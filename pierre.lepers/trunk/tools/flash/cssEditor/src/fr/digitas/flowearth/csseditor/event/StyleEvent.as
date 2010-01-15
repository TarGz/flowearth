package fr.digitas.flowearth.csseditor.event {
	import fr.digitas.flowearth.csseditor.data.StyleData;
	
	import flash.events.Event;		

	/**
	 * @author Pierre Lepers
	 */
	public class StyleEvent extends Event {

		public static const ADDED : String = "STYLEDATAADDED";
		
		public static const REMOVED : String = "STYLEDATAREMOVED";

		public static const RENAME : String = "RENAME";

		public static const SUPER_CHANGE : String = "superChange";
		
		
		public function get style() : StyleData {
			return _style;
		}
		

		public function StyleEvent(type : String, style : StyleData, bubbles : Boolean = false, cancelable : Boolean = false) {
			_style = style;
			super( type , bubbles , cancelable );
		}
		
		override public function clone() : Event {
			return new StyleEvent( type , _style , bubbles, cancelable );
		}

		private var _style : StyleData;
		
	}
}
