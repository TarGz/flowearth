package fr.digitas.tutorial.batcher.watch {
	import fr.digitas.flowearth.command.IBatchable;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;	

	/**
	 * @author Pierre Lepers
	 */
	public class EventWatcher extends EventDispatcher {

		public function flush() : Array {
			var copy : Array = _buffer.concat( );
			_buffer = [];
			return copy;
		}

		public function EventWatcher() {
			_items = [];
			_buffer = [];
		}


		public function register(b : IBatchable) : Boolean {
			
			for ( var type : String in EventWatcherItem.TYPE_MAP ) {
				b.addEventListener( type , onEvent, true );
				b.addEventListener( type , onEvent );
			}
		
			return true;
		}
		
		
		private function onEvent(event : Event) : void {
			var item : EventWatcherItem = new EventWatcherItem( event );
			_items.push( item );
			_buffer.push( item );
			dispatchEvent( new Event( Event.CHANGE ) );
		}

		public function clear() : void {
			_items = [];
			_buffer = [];
		}

		
		private var _buffer : Array;

		private var _items : Array;
	}
}
