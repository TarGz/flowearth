package fr.digitas.tutorial.layout {
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
			
			_buildLayout1();
			_buildLayout2();
			_buildLayout3();
		}

		private function _buildLayout1() : void {
			var exple1 : LayoutExample1 = new LayoutExample2();
			addChild( exple1 );
		}

		private function _buildLayout2() : void {
			
		}
		
		private function _buildLayout3() : void {
			
		}
	}
}
