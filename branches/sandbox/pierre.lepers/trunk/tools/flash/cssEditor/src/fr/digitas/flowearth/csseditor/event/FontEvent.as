package fr.digitas.flowearth.csseditor.event {
	import flash.events.Event;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class FontEvent extends Event {

		
		
		public static const SANDBOX_READY : String = "SANDBOX_READY";
		
		public function FontEvent( type : String ) {
			super( type );
		}
	}
}
