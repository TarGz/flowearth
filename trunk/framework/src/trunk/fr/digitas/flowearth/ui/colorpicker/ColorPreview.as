package fr.digitas.flowearth.ui.colorpicker {
	import flash.display.Sprite;
	import flash.geom.ColorTransform;		

	/**
	 * @author Pierre Lepers
	 */
	public class ColorPreview extends Sprite {
		
		public var shape : Sprite;
		
		public function get color() : uint {
			return _color;
		}
		
		public function set color(color : uint) : void {
			_color = color;
			var ct : ColorTransform = shape.transform.colorTransform;
			ct.color = _color;
			shape.transform.colorTransform = ct;
		}

		public function ColorPreview() {
		
		}
		
		private var _color : uint;
		
	}
}
