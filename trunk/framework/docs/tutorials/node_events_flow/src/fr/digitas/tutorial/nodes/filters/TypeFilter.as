package fr.digitas.tutorial.nodes.filters {
	import fl.controls.Button;
	
	import fr.digitas.tutorial.nodes.EventListItem;
	import fr.digitas.tutorial.nodes.filters.Filter;	

	/**
	 * @author Pierre Lepers
	 */
	public class TypeFilter extends Filter {
		
		public function TypeFilter(button : Button, type: String ) {
			_type = type;
			super( button );
		}
		
		override public function filterCallback(element : EventListItem, index : int, arr : Array) : Boolean {
			if( _state ) return true;
			return element.watcherItem.type != _type;
		}

		private var _type : String;

	}
}
