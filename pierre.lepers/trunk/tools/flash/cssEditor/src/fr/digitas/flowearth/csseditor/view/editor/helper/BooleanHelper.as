package fr.digitas.flowearth.csseditor.view.editor.helper {
	import fl.controls.CheckBox;
	
	import fr.digitas.flowearth.csseditor.event.PropertyEvent;
	import fr.digitas.flowearth.csseditor.view.editor.helper.AbstractHelper;
	import fr.digitas.flowearth.ui.utils.FlUtils;
	
	import flash.events.Event;		

	/**
	 * @author Pierre Lepers
	 */
	public class BooleanHelper extends AbstractHelper {
		
		public function BooleanHelper() {
			super( );
		}

		override protected function _init() : void {
			super._init( );
			_buildCb( );
			onValueChange( null );
		}
		

		
		override protected function onValueChange(event : PropertyEvent) : void {
			super.onValueChange( event );
			_cb.selected = _prop.value;
		}

		
		override public function dispose() : void {
			super.dispose( );
			_cb.removeEventListener( Event.CHANGE , onCbChange );
			removeChild( _cb );
			_cb = null;
		}

		private function _buildCb() : void {
			_cb = new CheckBox();
//			_cb.focusManager = FlUtils.nullFocusManager;
			addChild( _cb );
			
			_cb.addEventListener( Event.CHANGE , onCbChange );
		}
		
		private function onCbChange(event : Event) : void {
			_prop.value = _cb.selected;
		}

		private var _cb : CheckBox;
	}
}
