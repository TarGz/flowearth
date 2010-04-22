package fr.digitas.flowearth.csseditor.event {
	import fr.digitas.flowearth.csseditor.data.fonts.FontSource;	
	
	import flash.events.Event;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class FontEvent extends Event {

		
		public static const FONT_UNLOADED : String = "FONT_UNLOADED";

		public static const FONT_LOADED : String = "FONT_LOADED";

		public static const FONT_ADDED : String = "FONT_ADDED";

		public static const FONT_REMOVED : String = "FONT_REMOVED";

		public static const FILE_CHANGE : String = "FONT_FILE_CHANGE";
		
		public static const SELECTION_CHANGE : String = "fontprofile_selectionchange";

		public static const SANDBOX_READY : String = "SANDBOX_READY";

		public function FontEvent( type : String, source : FontSource ) {
			_source = source;
			super( type );
		}
		
		public function get source() : FontSource {
			return _source;
		}

		override public function clone() : Event {
			return new FontEvent( type , _source  );
		}

		private var _source : FontSource;

	}
}
