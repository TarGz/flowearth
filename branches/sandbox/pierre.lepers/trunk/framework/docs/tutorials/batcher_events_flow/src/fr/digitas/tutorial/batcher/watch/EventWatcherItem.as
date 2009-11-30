package fr.digitas.tutorial.batcher.watch {
	import fr.digitas.flowearth.command.IBatchable;
	import fr.digitas.flowearth.event.BatchErrorEvent;
	import fr.digitas.flowearth.event.BatchEvent;
	import fr.digitas.tutorial.batcher.BatchableTree;
	import fr.digitas.tutorial.batcher.BatchableView;
	
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */

	
	public class EventWatcherItem {

		public function get currentTarget() : IBatchable {
			return _event.currentTarget as IBatchable;
		}

		public function get target() : IBatchable {
			return _event.target as IBatchable;
		}

		public function get item() : IBatchable {
			if( _event is BatchEvent )
				return ( _event as BatchEvent).item as IBatchable;
			return null;
		}

		
		public function get event() : Event {
			return _event;
		}

		public function getString( ) : String {
			return _string;
		}
		
		private var _view : BatchableView;
		private var _tview : BatchableView;

		
		public function EventWatcherItem( event : Event ) {
			_event = event;
			_type = TYPE_MAP[ _event.type ];
			_view = BatchableTree.instance.getView( currentTarget );
			_tview = BatchableTree.instance.getView( target );
			build( );
		}

		private function build() : void {
			_string = stringifyEvent( );
		}

		
		private function stringifyEvent( ) : String {
		
			var str : String = "";
		
			str += getDecoration( );
			str += "[" + _type + "] ";
			str += BatchableTree.instance.getView( _event.currentTarget as IBatchable ).label.text;
		
			return str;
		}

		private function getDecoration() : String {
			if( _event.eventPhase == EventPhase.CAPTURING_PHASE )
				return "<font color='#AA0000'>C </font>";
			else
				return "<font color='#00AA00'>B </font>";
			return "";
		}


		
		
		private var _event : Event;

		private var _type : String;

		private var _string : String;

		public function decorateNode() : void {
			var str : String = getDecoration( );
			str += _type;
			_view.eventDecoration = str;
		}

		public function decorateTarget() : void {
			_tview.eventDecoration += "<font color='#AA0000'> target</font>";
		}

		public function decorateItem() : void {
			if( item )
			BatchableTree.instance.getView( item ).eventDecoration += "<font color='#00AA00'> item</font>";
		}

		public function clearDecorations() : void {
			_tview.eventDecoration = _view.eventDecoration = "";
			if( item )
				BatchableTree.instance.getView( item ).eventDecoration = "";
		}

		internal static const TYPE_MAP : Dictionary = _init( );

		private static function _init() : Dictionary {
			var tm : Dictionary = new Dictionary();
			tm[ Event.COMPLETE 					] = "Event.COMPLETE";
			tm[ Event.OPEN 						] = "Event.OPEN";
			tm[ Event.CLOSE 					] = "Event.CLOSE";
			
			tm[ BatchEvent.ADDED 				] = "BatchEvent.ADDED";
			tm[ BatchEvent.ADDED_TO_GROUP 		] = "BatchEvent.ADDED_TO_GROUP";
			tm[ BatchEvent.DISPOSED 			] = "BatchEvent.DISPOSED";
			tm[ BatchEvent.ITEM_ADDED 			] = "BatchEvent.ITEM_ADDED";
			tm[ BatchEvent.ITEM_COMPLETE 		] = "BatchEvent.ITEM_COMPLETE";
			tm[ BatchEvent.ITEM_REMOVED 		] = "BatchEvent.ITEM_REMOVED";
			tm[ BatchEvent.ITEM_START 			] = "BatchEvent.ITEM_START";
			tm[ BatchEvent.REMOVED 				] = "BatchEvent.REMOVED";
			tm[ BatchEvent.REMOVED_FROM_GROUP 	] = "BatchEvent.REMOVED_FROM_GROUP";
			tm[ BatchEvent.START 				] = "BatchEvent.START";
			tm[ BatchEvent.STOP 				] = "BatchEvent.STOP";
			
			tm[ BatchErrorEvent.ERROR 			] = "BatchErrorEvent.ERROR";

//			tm[ BatchProgressEvent.ITEM_PROGRESS] = "BatchProgressEvent.ITEM_PROGRESS";
//			tm[ ProgressEvent.PROGRESS 			] = "ProgressEvent.PROGRESS";
			
			return tm;
		}


		public function get type() : String {
			return _type;
		}
	}
}
