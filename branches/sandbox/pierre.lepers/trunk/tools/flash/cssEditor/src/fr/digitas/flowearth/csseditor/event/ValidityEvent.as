package fr.digitas.flowearth.csseditor.event {
	import fr.digitas.flowearth.csseditor.data.errors.ValidityState;	
	
	import flash.events.TextEvent;	
	import flash.events.Event;
	
	/**
	 * @author Pierre Lepers
	 */
	public class ValidityEvent extends TextEvent {


		public static const VALIDITY_CHANGE : String = "vliditychange";
		
		public function get state() : ValidityState {
			return _state;
		}
		
		public function ValidityEvent( type : String, state : ValidityState ) {
			super( type, false, false, text );
			_state = state;
		}
		

		override public function clone() : Event {
			return new ValidityEvent( type , _state );
		}

		private var _state : ValidityState;
		
	}
}
