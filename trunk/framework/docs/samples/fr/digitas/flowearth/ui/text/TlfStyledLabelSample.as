package {
	import flashx.textLayout.container.ContainerController;
	import flashx.textLayout.elements.TextFlow;

	import fr.digitas.flowearth.text.styles.TlfSupport;
	import fr.digitas.flowearth.text.styles.styleManager;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;		

	public class TlfStyledLabelSample extends BasicExample {

		public function TlfStyledLabelSample() {
			super( );
			TlfSupport.init( );
			createControllers( );
			loadText( );
		}

		private function createLabel() : void {
			
			var styleName : String = ".my_style";
			
			textFlow = styleManager.getHtmlTlf( styleName, bigText ) as TextFlow;
			
			textFlow.flowComposer.addControllerAt( titleController, 0 );
			textFlow.flowComposer.addControllerAt( paragraphController, 1 );

			stage.addEventListener( Event.RESIZE, onResize );
			onResize( null );
			
//			addChild( label );
		}

		private function createControllers() : void {
			titleController = new ContainerController( addChild( new Sprite( ) ) as Sprite );
			paragraphController = new ContainerController( addChild( new Sprite( ) ) as Sprite );
			paragraphController.container.y = 35;
			paragraphController.container.x = 50;
			paragraphController.columnWidth = 200;
		}

		private function onResize(event : Event) : void {
			titleController.setCompositionSize( stage.stageWidth, 30 );
			paragraphController.setCompositionSize( stage.stageWidth - 60, stage.stageHeight - 40 );
			textFlow.flowComposer.updateAllControllers( );			
		}

		private var textFlow : TextFlow;
		private var titleController : ContainerController;
		private var paragraphController : ContainerController;

		
		//_____________________________________________________________________________
		//															  Load external CSS

		private function loadText() : void {
			var l : URLLoader = new URLLoader( );
			l.addEventListener( Event.COMPLETE, textLoaded );
			l.load( new URLRequest( baseUrl + "/bigtext.txt" ) );
		}

		private function loadStyles() : void {
			var l : URLLoader = new URLLoader( );
			l.addEventListener( Event.COMPLETE, stylesLoaded );
			l.load( new URLRequest( baseUrl + "/styles_tlf.css" ) );
		}

		private function textLoaded(event : Event) : void {
			bigText = event.target.data;
			loadStyles( );
		}

		private function stylesLoaded(event : Event) : void {
			styleManager.addCss( event.target.data );
			
			createLabel( );
		}

		private var bigText : String;

	}
}
