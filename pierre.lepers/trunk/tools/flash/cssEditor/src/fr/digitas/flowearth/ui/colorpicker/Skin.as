package fr.digitas.flowearth.ui.colorpicker {
	import flash.display.MovieClip;	

	/**
	 * @author Pierre Lepers
	 */
	public class Skin extends ColorPreview {

		public var bg : MovieClip;
		
		
		public function Skin() {
			
		}

		override public function set width(value : Number) : void {
			bg.width = value;
			shape.width = value - 6;
		}

		override public function set height(value : Number) : void {
			bg.height = value;
			shape.height = value - 6;
		}
	}
}
