package fr.digitas.flowearth.csseditor.view.misc {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public class CanvasHeader extends Sprite{


		public var label : TextField;
		
		public var bg : MovieClip;

		
		
		public function CanvasHeader() {
			
		}
		
		public function setLabel( str : String ) : void {
			label.text = str;
		}

		
		
		override public function get width() : Number {
			return bg.width;
		}

		override public function set width(value : Number) : void {
			bg.width= value;
		}

		override public function get height() : Number {
			return bg.height;
		}
	}
}
