package fr.digitas.flowearth.csseditor.event {
	import fr.digitas.flowearth.csseditor.data.CSS;
	
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class CSSEvent extends Event {

		
		public static const PATH_CHANGE : String = "css_PATH_CHANGE";

		public static const INVALIDATE : String = "css_INVALIDATE";

		public static const ADDED : String = "css_ADDED";
		
		public static const REMOVED : String = "css_REMOVED";
		
		public static const CURRENT_CHANGE : String = "css_CURRENT_CHANGE";

		public static const FILE_SYNC : String = "css_FILE_SYNC";

		public function get css() : CSS {
			return _css;
		}
		

		
		public function CSSEvent(type : String, css : CSS, bubbles : Boolean = false, cancelable : Boolean = false) {
			_css = css;
			super( type , bubbles , cancelable );
		}

		override public function clone() : Event {
			return new CSSEvent( type, _css, bubbles, cancelable );
		}

		private var _css : CSS;
	}
}
