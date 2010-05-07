package fr.digitas.tutorial.graphictools {
	import fr.digitas.flowearth.utils.GraphicTools;

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;		

	/**
	 * @author Pierre Lepers
	 */
	public class Main extends Sprite {

		public function Main() {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			
			
			addChild( circleSegment1 = new Shape( ) );
			addChild( circleSegment2 = new Shape( ) );
			addChild( circleSegment3 = new Shape( ) );
			addChild( circleSegment4 = new Shape( ) );
			
			addEventListener( Event.ENTER_FRAME , _oef );
			
			draw( );
		}

		private function draw() : void {
			circleSegment1.graphics.lineStyle( 2 , 0 );
			
			circleSegment2.graphics.lineStyle( 1 , 0 );
			circleSegment2.graphics.beginFill( 0 , .5 );
			
			circleSegment4.graphics.lineStyle( 1 , 0 );
			circleSegment4.graphics.beginFill( 0 , .5 );
			
			GraphicTools.drawCircleSegment( circleSegment1.graphics , 25 , 0 , Math.PI / 2 , 100 , 100 );
			GraphicTools.drawCircleSegment( circleSegment1.graphics , 25 , 0 , Math.PI , 200 , 100 );
			GraphicTools.drawCircleSegment( circleSegment1.graphics , 25 , 0 , 3 * Math.PI / 2 , 300 , 100 );
			GraphicTools.drawCircleSegment( circleSegment1.graphics , 25 , 0 , 2 * Math.PI , 400 , 100 );
			
			
			GraphicTools.fillCircleSegment( circleSegment2.graphics , 20 , 25 , 0 , Math.PI / 2 , 100 , 200 );
			GraphicTools.fillCircleSegment( circleSegment2.graphics , 20 , 25 , 0 , Math.PI , 200 , 200 );
			GraphicTools.fillCircleSegment( circleSegment2.graphics , 20 , 25 , 0 , 3 * Math.PI / 2 , 300 , 200 );
			GraphicTools.fillCircleSegment( circleSegment2.graphics , 20 , 25 , 0 , 2 * Math.PI , 400 , 200 );

			GraphicTools.fillRoundedCircleSegment( circleSegment4.graphics , 15 , 30 , 0 , Math.PI / 2 , 6 , 100 , 300 );
			GraphicTools.fillRoundedCircleSegment( circleSegment4.graphics , 15 , 30 , 0 , Math.PI , 6 , 200 , 300 );
			GraphicTools.fillRoundedCircleSegment( circleSegment4.graphics , 15 , 30 , 0 , 3 * Math.PI / 2 , 6 , 300 , 300 );
			GraphicTools.fillRoundedCircleSegment( circleSegment4.graphics , 15 , 30 , 0 , 2 * Math.PI , 6 , 400 , 300 );
		}

		
		private function _oef(event : Event) : void {
			
			circleSegment3.graphics.clear( );
			circleSegment3.graphics.lineStyle( 2 , 0 );
			cs3A += .08;
			cs3B += .01;
			
			if( cs3A > 2 * Math.PI ) cs3A = 0;
			if( cs3B > 2 * Math.PI ) cs3B = 0;
			GraphicTools.drawCircleSegment( circleSegment3.graphics , 25 , cs3B , cs3A , 500 , 100 );
			circleSegment3.graphics.lineStyle( 1 , 0 );
			circleSegment3.graphics.beginFill( 0 , .5 );
			GraphicTools.fillCircleSegment( circleSegment3.graphics , 20 , 25 , cs3B , cs3A , 500 , 200 );
			
			GraphicTools.fillRoundedCircleSegment( circleSegment3.graphics , 15 , 30 , cs3B , cs3A , 6 , 500 , 300 );
		}

		
		private var circleSegment1 : Shape;
		private var circleSegment2 : Shape;
		private var circleSegment3 : Shape;
		private var circleSegment4 : Shape;

		private var cs3A : Number = 0;
		private var cs3B : Number = 0;
		
	}
}
