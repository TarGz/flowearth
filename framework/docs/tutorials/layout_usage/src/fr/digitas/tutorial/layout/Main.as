package fr.digitas.tutorial.layout {
	import flash.events.MouseEvent;	
	
	import fr.digitas.flowearth.ui.layout.renderer.HBlockRenderer;	
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;import flash.profiler.profile;	

	/**
	 * @author Pierre Lepers
	 */
	public class Main extends Sprite {

		public function Main() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			profile( true );
			_buildExample1( );
			
			stage.addEventListener( MouseEvent.CLICK , onSclick );
		}
		
		private function onSclick(event : MouseEvent) : void {
			l.update();
		}

		private function _buildExample1() : void {

			l = new LayoutExample( );
			l.renderer = new HBlockRenderer();
//			l.margin = new Rectangle( 5 , 5 , 5 , 5 );
//			l.padding = new Rectangle( 10 , 10 , 10 , 10 );

			for (var i : int = 0; i < 100; i++) {
				l.addChild( new ResizableLayoutItem_FC );
			}
			
			
			addChild( l );
			
			l.x = l.y = 50;
		}
		
		private var l : LayoutExample;
	}
}
