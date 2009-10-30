package fr.digitas.tutorial.batcher {
	import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;
	import fr.digitas.tutorial.batcher.watch.EventList;
	import fr.digitas.tutorial.batcher.watch.EventListLayout;
	import fr.digitas.tutorial.batcher.watch.filters.FlowFilter;
	import fr.digitas.tutorial.batcher.watch.filters.TypeFilter;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;		

	/**
	 * @author Pierre Lepers
	 */
	public class BatcherEventFlow extends Sprite {
		
		
		
		public function BatcherEventFlow() {
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
			
		}

		private function onAdded( e : Event ) : void {
			stage.addEventListener( Event.RESIZE , onResize );
			BatchableTree.start( stage );
			buildCreators();
			buildWatcher( );
			buildControls( );
			buildFilters( );
			onResize( );

			stage.addChild( viewLayer );
			stage.addChild( insertionGhost );
		}
		
		private function buildFilters() : void {
			
			eventList.addFilter( new FlowFilter( controls.showCapture , false ) );
			eventList.addFilter( new FlowFilter( controls.showBubbling , true ) );
			eventList.addFilter( new TypeFilter( controls.showChange , "CHANGE" ) );
			eventList.addFilter( new TypeFilter( controls.showChildChange , "CHILD_CHANGE" ) );
			eventList.addFilter( new TypeFilter( controls.showPathChange , "PATH_CHANGE" ) );
			
		}

		private function buildControls() : void {
			controls = new Controls_FC();
			
			controls.clearBt.addEventListener( MouseEvent.CLICK , onClear );
			controls.showBubbling.selected = true;
			controls.showCapture.selected = true;
			controls.showChange.selected = true;
			controls.showChildChange.selected = true;
			
			addChild( controls );
		}
		
		private function onClear(event : MouseEvent) : void {
			eventList.clear();
			
		}

		private function onRemoved( e : Event ) : void {
			stage.removeEventListener( Event.RESIZE , onResize );
		}
		
		private function onResize(event : Event = null ) : void {
			creatorContainer.x = stage.stageWidth;
		}

		private function buildWatcher() : void {
			eventListLayout = new EventListLayout( );
			eventListLayout.renderer = new TopRenderer( );
			addChild( eventListLayout );
			
			eventListLayout.y = 20;
			eventListLayout.x = 5;
			
			eventList = new EventList( eventListLayout );
			BatchableTree.instance.connectWatcher( eventList );
		}

		private function buildCreators() : void {
			addChild( creatorContainer = new Sprite() );
			
			
			batchableCreator = new ViewCreator();
			batchableCreator.mode = "item";
			batcherCreator = new ViewCreator();
			batcherCreator.mode = "batcher";
			
			creatorContainer.addChild( batchableCreator );
			creatorContainer.addChild( batcherCreator );
			
			batchableCreator.y = 30;
			batchableCreator.x = batcherCreator.x = -155;
			
			batchableCreator.init();
			batcherCreator.init();
		}


		private var eventList : EventList;
		private var eventListLayout : EventListLayout;

		private var batcherCreator : ViewCreator;
		private var batchableCreator : ViewCreator;
		
		private var creatorContainer : Sprite;
		
		private var controls : Controls_FC;
		
		public static const insertionGhost : DisplayObject = new InsertionGhost_FC();

		public static const viewLayer : Sprite = new Sprite();
	}
}
