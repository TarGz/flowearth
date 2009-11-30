package fr.digitas.tutorial.batcher.watch.filters {
	import fl.controls.Button;
	
	import fr.digitas.tutorial.batcher.watch.EventListItem;
	
	import flash.events.EventPhase;		

	/**
	 * @author Pierre Lepers
	 */
	public class FlowFilter extends Filter {

		
		public function FlowFilter(button : Button, hideCapture : Boolean ) {
			_hideCapture = hideCapture;
			super( button );
		}

		override public function filterCallback(element : EventListItem, index : int, arr : Array) : Boolean {
			if( _state ) return true;
			return ( element.watcherItem.event.eventPhase == EventPhase.CAPTURING_PHASE ) == _hideCapture;
		}

		private var _hideCapture : Boolean;
		
	}
}
