package fr.digitas.flowearth.ui.misc {
	import flash.display.MovieClip;
	import flash.display.Sprite;	

	/**
	 * @author Pierre Lepers
	 */
	public class CollapseButton extends Sprite {
		
		
				// Public timeline properties

		public var plus : MovieClip;
		public var less : MovieClip;

		
		
		public function CollapseButton() {
			
		}

		public function collapse( flag :  Boolean ) : void {
			less.visible = !flag;
			plus.visible = flag;
		}
	}
}
