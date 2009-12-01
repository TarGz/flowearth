package fr.digitas.flowearth.ui.colorpicker {
	import flash.events.MouseEvent;	
	import flash.display.Sprite;
	
	/**
	 * @author Pierre Lepers
	 */
	public class Tile extends Sprite {
		
		public function Tile( color : uint ) {
			_color = color;
			_build( );
		}
		
		private function _build() : void {
			graphics.beginFill(_color );
			graphics.drawRect(1, 1, 10, 10);
			
			addChild( _roll = new Sprite() );
			_roll.graphics.lineStyle( 1 ,0xFFFFFF );
			_roll.graphics.drawRect(0, 0, 11, 11 );
			_roll.visible = false;
			
			mouseChildren = false;
			
			addEventListener( MouseEvent.ROLL_OVER , over );
			addEventListener( MouseEvent.ROLL_OUT , out );
		}
		
		private function over(event : MouseEvent) : void {
			_roll.visible = true;
		}

		private function out(event : MouseEvent) : void {
			_roll.visible = false;
		}

		private var _color : uint;
		
		private var _roll : Sprite;
		
		public function get color() : uint {
			return _color;
		}
	}
}
