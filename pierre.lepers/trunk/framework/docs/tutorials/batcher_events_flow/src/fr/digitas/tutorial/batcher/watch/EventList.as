package fr.digitas.tutorial.batcher.watch {
	import fr.digitas.flowearth.command.IBatchable;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.tutorial.batcher.watch.filters.Filter;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;	

	/**
	 * @author Pierre Lepers
	 */
	public class EventList extends EventDispatcher {

		
		private var _watcher : EventWatcher;
		
		private var layout : Layout;

		private var _filters : Array;

		public function EventList( layout : Layout ) {
			_filters = [];
			_list = [];
			_flist = [];
			this.layout = layout;
			
			_watcher = new EventWatcher();
			_watcher.addEventListener( Event.CHANGE , onWatcherChange );
		}
		
		private function onWatcherChange(event : Event) : void {
			append( _watcher.flush() );
		}

		
		
		public function addFilter( filter : Filter ) : void {
			_filters.push( filter );
			filter.addEventListener( Event.CHANGE , onFilterChange );
			_flist = _updateFilters( _list );
			_update( );
		}
		

		private function onFilterChange(event : Event) : void {
			_flist = _updateFilters( _list );
			_update( );
		}

		private function _update() : void {
			while( layout.numChildren > 0 )
				layout.removeChildAt( 0 );
				
			for each (var item : EventListItem in _flist) {
				layout.addChild( item );
			}
		}

		private function _updateFilters( input : Array) : Array {
			var res : Array = input.concat( );
			for each (var f : Filter in _filters) 
				res = res.filter( f.filterCallback );
			return res;
		}
		
		public function registerBatchable( b : IBatchable) : void {
			_watcher.register( b );
		}

		public function clear() : void {
			
			_list = [];
			_flist = [];
			_update();
		}

		public function append( buff : Array ) : void {
			var map : Array = buff.map( buildItems );
			_list = _list.concat( map );
			_flist = _flist.concat( _updateFilters( map ) );
			_update( );
		}

		public function buildItems(element : EventWatcherItem, index : int, arr : Array) : EventListItem {
			var eli : EventListItem = new EventListItem_FC( );
			eli.init( element );
			eli.addEventListener( EventListItem.ACTION , refresh );
			return eli;
		}

		private function refresh( event : Event ) : void {
			dispatchEvent( event );
		}

		
		
		
		private var _flist : Array;
		private var _list : Array;
		
	}
}
