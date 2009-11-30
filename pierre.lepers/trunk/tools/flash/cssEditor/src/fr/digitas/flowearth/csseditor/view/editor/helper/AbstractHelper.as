package fr.digitas.flowearth.csseditor.view.editor.helper {
	import fr.digitas.flowearth.csseditor.data.StyleProperty;	
	
	import flash.display.Sprite;
	
	/**
	 * @author Pierre Lepers
	 */
	public class AbstractHelper extends Sprite {

		private var prop : StyleProperty;
		
		public function AbstractHelper() {
		}

		public function setProp( prop : StyleProperty ) : void {
			this.prop = prop;
			_init( );
		}
		
		
		
		protected function _init() : void {
			
		}
	}
}
