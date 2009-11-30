package fr.digitas.tutorial.nodes.filters {
	import fl.controls.Button;
	
	import fr.digitas.tutorial.nodes.EventListItem;
	import fr.digitas.tutorial.nodes.filters.Filter;	

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
			return element.watcherItem.event.capureFlow == _hideCapture;
		}

		private var _hideCapture : Boolean;
		
	}
}
