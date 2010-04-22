package fr.digitas.flowearth.ui.layout {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.DisplayObject;	

	/**
	 * @author Pierre Lepers
	 */
	internal final class InternalLayoutItem implements ILayoutItem {
		
		public function InternalLayoutItem( _do : DisplayObject ) {
			_display = _do;
		}

		
		
		public function getDisplay() : DisplayObject {
			return _display;
		}

		public function getWidth() : Number {
			return _display.width;
		}
		
		public function getHeight() : Number {
			return _display.height;
		}

		private var _display : DisplayObject;
		
	}
}
