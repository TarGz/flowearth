package fr.digitas.tutorial.batcher {
	import fr.digitas.flowearth.command.Batcher;
	import fr.digitas.flowearth.command.IBatchable;
	import fr.digitas.tutorial.batcher.BatchableView;
	
	import flash.display.Sprite;
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class ViewCreator extends Sprite {

		
		public function ViewCreator() {
		}
		
		public function init() : void {
			create();
		}

		
		
		
		private function create() : void {
			
			var view : BatchableView = new BatchableView_FC( );
			view.connect( createItem( ) );
			
			addChild( view );
			registerView( view );
			
			
		}

		private function registerView( item : BatchableView ) : void {
			if( _currentItem )
				unregisterView( _currentItem );
			
			_currentItem = item;
				
			_currentItem.addEventListener( Dragable.STOP_DRAG , onStopDragView , false , - 1000 );
			_currentItem.addEventListener( Dragable.ADDED , onViewAdded );
		}

		private function unregisterView( _currentItem : BatchableView ) : void {
			_currentItem.removeEventListener( Dragable.STOP_DRAG , onStopDragView );
			_currentItem.removeEventListener( Dragable.ADDED , onViewAdded );
		}

		private function onStopDragView(event : Event ) : void {
			if( BatchableTree.instance.empty() ) {
				BatchableTree.instance.registerView( _currentItem );
				unregisterView( _currentItem );
				create( );
			} else {
				_currentItem.x = _currentItem.y = 0;
			}
		}

		
		private function onViewAdded(event : Event ) : void {
			BatchableTree.instance.registerView( _currentItem );
			unregisterView( _currentItem );
			create( );
			
		}

		
		private function createItem() : IBatchable {
			var item : IBatchable;
			if( mode == "batcher" )
				item = new Batcher( );
			else if( mode == "item" )
				item = new BatchItem( );
			
			return item;
		}

		public var mode : String = "batcher";

		private var _currentItem : BatchableView;
	}
}
