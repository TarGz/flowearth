package fr.digitas.tutorial.batcher.watch.filters {
	import fl.controls.Button;
	
	import fr.digitas.tutorial.batcher.watch.EventListItem;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;	

	/**
	 * @author Pierre Lepers
	 */
	public class Filter extends EventDispatcher {

		
		
		
		public function Filter( button : Button ) {
			_button = button;
			_state = _button.selected;
			button.addEventListener( Event.CHANGE , onChange );
		}

		public function filterCallback( element : EventListItem, index : int, arr : Array) : Boolean {
			return true;
		}

		
		
		protected function onChange(event : Event) : void {
			_state = _button.selected;
			dispatchEvent( event );
		}

		protected var _state : Boolean;

		protected var _button : Button;
	}
}
