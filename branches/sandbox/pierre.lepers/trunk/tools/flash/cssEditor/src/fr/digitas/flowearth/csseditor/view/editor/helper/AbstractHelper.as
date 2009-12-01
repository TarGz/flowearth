package fr.digitas.flowearth.csseditor.view.editor.helper {
	import fr.digitas.flowearth.csseditor.event.PropertyEvent;	
	import fr.digitas.flowearth.csseditor.data.StyleProperty;	
	
	import flash.display.Sprite;
	
	/**
	 * @author Pierre Lepers
	 */
	public class AbstractHelper extends Sprite {

		
		public function AbstractHelper() {
			
		}

		public function setProp( prop : StyleProperty ) : void {
			_prop = prop;
			_init( );
			_prop.addEventListener( PropertyEvent.VALUE_CHANGE , onValueChange );
		}

		public function dispose() : void {
			_prop.removeEventListener( PropertyEvent.VALUE_CHANGE , onValueChange );
			_prop = null;
		}
		
		
		protected function onValueChange(event : PropertyEvent) : void {
			
		}
		
		protected function _init() : void {
			
		}

		protected var _prop : StyleProperty;

	}
}
