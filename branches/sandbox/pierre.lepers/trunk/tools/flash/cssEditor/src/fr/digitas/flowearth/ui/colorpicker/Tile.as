package fr.digitas.flowearth.ui.colorpicker {
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
			graphics.drawRect(0, 0, 10, 10);
		}

		private var _color : uint;

	}
}
