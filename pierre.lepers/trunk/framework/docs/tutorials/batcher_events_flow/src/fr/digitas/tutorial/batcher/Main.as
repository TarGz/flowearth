package fr.digitas.tutorial.batcher {
	import fr.digitas.tutorial.batcher.BatcherEventFlow;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;	

	/**
	 * @author Pierre Lepers
	 */
	public class Main extends Sprite {
		
		public function Main() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			addChild( new BatcherEventFlow() );
		}
		
	}
}
