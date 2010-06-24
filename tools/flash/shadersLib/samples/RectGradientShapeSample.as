package {
	import flash.geom.Rectangle;	
	
	import fr.digitas.flowearth.shaders.RectGradientShape;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;	

	/**
	 * @author Pierre Lepers
	 */
	public class RectGradientShapeSample extends Sprite {


		public function RectGradientShapeSample() {
			
			_rgs = new RectGradientShape();
			
			_rgs.x = _rgs.y = 100;
			addChild( _rgs );
			
			addEventListener( Event.ENTER_FRAME	, _oef );
		}
		
		private function _oef(event : Event) : void {
			
			var a : Number = Math.atan2( _rgs.mouseY, _rgs.mouseX );
			var d : Number = Point.distance( new Point, new Point(_rgs.mouseX, _rgs.mouseY ) );
			
			
			_rgs.angle = a;
			_rgs.distance = d;
			_rgs.bounds = new Rectangle( 0, 0, 150, 90 );
			
		}

		private var _rgs : RectGradientShape;
	}
}
