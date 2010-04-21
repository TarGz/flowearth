package fr.digitas.flowearth.ui.canvas {
	import flash.events.MouseEvent;	
	
	import fr.digitas.flowearth.ui.layout.ILayoutItem;	
	
	import flash.display.Sprite;
	
	/**
	 * @author Pierre Lepers
	 */
	public class Separator extends Sprite implements ILayoutItem {
		
		public function Separator() {
//			graphics.beginFill( 0 , 0 );
			graphics.beginFill( 0x808080 , 1 );
			graphics.drawRect( 0, 0, 50, 50 );
			alpha = 0;
//			addEventListener( MouseEvent.MOUSE_DOWN , onMouseDown );
			
			addEventListener( MouseEvent.ROLL_OVER , over );
			addEventListener( MouseEvent.ROLL_OUT , out );
			useHandCursor = buttonMode = true;
		}

		override public function set x(value : Number) : void {
			super.x = value - 3;
		}

		override public function set y(value : Number) : void {
			super.y = value - 3;
		}

		private function out(event : MouseEvent) : void {
			alpha = 0;
		}

		private function over(event : MouseEvent) : void {
			alpha = 0.8;
		}

		public function getWidth() : Number {
			return 0;
		}
		
		public function getHeight() : Number {
			return 0;
		}
	}
}