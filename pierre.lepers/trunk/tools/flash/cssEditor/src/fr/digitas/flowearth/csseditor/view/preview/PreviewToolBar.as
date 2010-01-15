package fr.digitas.flowearth.csseditor.view.preview {
	import fr.digitas.flowearth.ui.toobar.ToolBar;	
	
	import flash.display.Sprite;
	
	/**
	 * @author Pierre Lepers
	 */
	public class PreviewToolBar extends Sprite {
		
		public var bg : Sprite;
		
		public function PreviewToolBar() {
			_build( );
		}

		override public function set width(value : Number) : void {
			bg.width = value;
		}

		override public function get height() : Number {
			return bg.height;
		}
		
		private function _build() : void {
			_leftTb = new ToolBar();
			
			addChild( _leftTb );
		}

		private var _leftTb : ToolBar;
	}
}
