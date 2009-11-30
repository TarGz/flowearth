package fr.digitas.flowearth.csseditor {
	import fr.digitas.flowearth.csseditor.view.MainLayout;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;		

	/**
	 * @author Pierre Lepers
	 */
	public class Main extends Sprite {

		
		public function Main() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			App.run( this );
			
			addChild( new MainLayout( ) );
//			addChild( new TestTabs( ) );

		}
	}
}
