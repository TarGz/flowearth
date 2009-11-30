package fr.digitas.flowearth.csseditor.event {
	import fr.digitas.flowearth.csseditor.data.StyleProperty;
	
	import flash.events.Event;		

	/**
	 * @author Pierre Lepers
	 */
	public class PropertyEvent extends Event {

		
		public static const ADDED 	: String = "csspADDED";
		public static const REMOVED : String = "csspREMOVED";
		public static const RENAME 	: String = "csspRENAME";
		public static const VALUE_CHANGE : String = "VALUE_CHANGE";
		public static const STRVALUE_CHANGE : String = "STRVALUE_CHANGE";
		
		public function get prop() : StyleProperty {
			return _prop;
		}
		

		
		public function PropertyEvent(type : String, prop : StyleProperty, bubbles : Boolean = false, cancelable : Boolean = false) {
			_prop = prop;
			super( type , bubbles , cancelable );
		}

		override public function clone() : Event {
			return new PropertyEvent( type , _prop , bubbles, cancelable );
		}

		private var _prop : StyleProperty;
	}
}
