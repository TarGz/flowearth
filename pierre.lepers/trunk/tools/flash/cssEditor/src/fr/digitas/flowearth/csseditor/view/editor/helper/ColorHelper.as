package fr.digitas.flowearth.csseditor.view.editor.helper {
	import fr.digitas.flowearth.csseditor.event.PropertyEvent;	
	
	import flash.events.Event;	
	
	import fr.digitas.flowearth.ui.colorpicker.ColorPicker_FC;	
	import fr.digitas.flowearth.ui.colorpicker.ColorPicker;	
	import fr.digitas.flowearth.csseditor.view.editor.helper.AbstractHelper;
	
	/**
	 * @author Pierre Lepers
	 */
	public class ColorHelper extends AbstractHelper {
		
		public function ColorHelper() {
			super( );
		}
		
		override protected function _init() : void {
			super._init( );
			_buildCb( );
			onValueChange( null );
		}

		override public function dispose() : void {
			super.dispose( );
			
			_cp.removeEventListener( Event.CHANGE , onCpChange );
			removeChild(_cp);
			_cp = null;
		}

		
		override protected function onValueChange(event : PropertyEvent) : void {
			super.onValueChange( event );
			_cp.color = _prop.value;
		}
		
		private function _buildCb() : void {
			_cp = new ColorPicker_FC( );
			addChild( _cp );
			
			_cp.addEventListener( Event.CHANGE , onCpChange );
		}
		
		private function onCpChange(event : Event) : void {
			_prop.value = _cp.color;
		}

		private var _cp : ColorPicker;
	}
}
