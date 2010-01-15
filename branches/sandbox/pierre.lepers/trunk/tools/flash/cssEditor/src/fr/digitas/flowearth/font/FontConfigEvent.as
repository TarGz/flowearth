package fr.digitas.flowearth.font {
	import flash.events.Event;
	
	/**
	 * @author Pierre Lepers
	 */
	public class FontConfigEvent extends Event {

		public static const CONFIG_ADDED : String = "CONFIG_ADDED";
		public static const CONFIG_REMOVED: String = "CONFIG_REMOVED";
		public static const BUILD_START: String = "BUILD_START";

		private var _config : FontConfig;
		
		
		public function FontConfigEvent(type : String, config : FontConfig ) {
			_config = config;
			super( type );
		}
		
		public function get fontConfig() : FontConfig {
			return _config;
		}
		
	}
}
