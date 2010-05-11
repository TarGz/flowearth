package fr.digitas.tutorial.tlf {
	import flashx.textLayout.formats.Direction;	
	import flashx.textLayout.formats.TextLayoutFormat;	
	import flashx.textLayout.elements.FlowElement;	
	import flashx.textLayout.elements.ParagraphElement;	
	import flashx.textLayout.edit.SelectionManager;	
	import flashx.textLayout.container.ScrollPolicy;	
	
	import flash.events.Event;	
	
	import flashx.textLayout.elements.TextFlow;	
	import flashx.textLayout.container.ContainerController;
	
	import fr.digitas.flowearth.text.styles.styleManager;
	
	import flash.display.Sprite;	

	/**
	 * @author Pierre Lepers
	 */
	public class Test extends Sprite {
		
		public function Test( text : String ) {
			
			createControllers();
			
			var styleName : String = ".main";
			
			textFlow = styleManager.getHtmlTlf( styleName, text ) as TextFlow;
			
			textFlow.interactionManager = new SelectionManager( );
			
			textFlow.flowComposer.addControllerAt( titleController, 0 );
			textFlow.flowComposer.addControllerAt( paragraphController, 1 );
			
			textFlow.flowComposer.updateAllControllers();
			
			var ns : FlowElement;
			
			
			var mft : TextLayoutFormat = new TextLayoutFormat( textFlow.hostFormat );
			mft.direction = Direction.RTL;
			mft.color = 0xFF0000;
			
			for (var i : int = 0; i < textFlow.numChildren; i++) {
				trace( i, textFlow.getChildAt( i ).getText() );
				if( i == 8 )textFlow.getChildAt( i ).format = mft;
			}
			
//			while( ns = textFlow.getNextSibling() )
//				trace( ns ) ;
//				
//			( textFlow.getElementByID( "editable" ) as ParagraphElement).columnCount = 2;

			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
			
//			addChild( label );
		}

		private function onAdded( e : Event ) : void {
			stage.addEventListener( Event.RESIZE, onResize );
			onResize( null );
		}
		
		private function onRemoved( e : Event ) : void {
		}

		private function createControllers () : void {
			titleController = new ContainerController( addChild( new Sprite() ) as Sprite );
			paragraphController = new ContainerController( addChild( new Sprite() ) as Sprite );
			titleController.container.y = 15;
			paragraphController.container.y = 50;
			titleController.container.x = paragraphController.container.x = 30;
			paragraphController.columnWidth = 230;
			paragraphController.verticalScrollPolicy = ScrollPolicy.ON;
		}

		private function onResize(event : Event) : void {
			titleController.setCompositionSize( stage.stageWidth - 60, 30 );
			paragraphController.setCompositionSize( stage.stageWidth - 60, stage.stageHeight - 90 );
			textFlow.flowComposer.updateAllControllers( );			
		}

		private var textFlow : TextFlow;
		private var titleController : ContainerController;
		private var paragraphController : ContainerController;
		
	}
}
