package fr.digitas.flowearth.font.view {
	import fr.digitas.flowearth.font.FontConfig;
	
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontViewHeader extends FontViewHeader_FC {

		
		
		public function FontViewHeader(fontConfig : FontConfig) {
			_fontConfig = fontConfig;
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}

		private function onAdded( e : Event ) : void {
			_fontConfig.addEventListener( Event.CHANGE , update );
			update( null );
		}

		private function onRemoved( e : Event ) : void {
			_fontConfig.removeEventListener( Event.CHANGE , update );
		}
		
		private function update(event : Event) : void {
			label.text = _fontConfig.fontFamily;
		}

		private var _fontConfig : FontConfig;

	}
}
