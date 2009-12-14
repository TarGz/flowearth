package fr.digitas.flowearth.csseditor.view.editor.helper {
	import fl.controls.ComboBox;
	import fl.managers.FocusManager;
	
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.builder.types.StringEnum;
	import fr.digitas.flowearth.csseditor.event.PropertyEvent;
	import fr.digitas.flowearth.ui.utils.FlUtils;
	
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class StringEnumHelper extends AbstractHelper {

		override protected function _init() : void {
			super._init( );
			
			_enum = _prop.type as StringEnum;
			
			_invalidItem = { label : "---" };
			
			_buildCb( );
		}

		override public function dispose() : void {
			super.dispose( );
			_cb.removeEventListener( Event.CHANGE , onChange );
			_enum = null;
			
		}

		private function _buildCb() : void {
			_cb = new ComboBox();
			_cb.focusManager = FlUtils.nullFocusManager;
			_cb.height = 19;
			_cb.y = 1;
			_cb.dropdown.setStyle( "contentPadding",  1 );
			_cb.dropdown.rowHeight = 14;
			_cb.setStyle( "textPadding",  1 );
			
			addChild( _cb );
			
			var iter : IIterator = _enum.values;
			var item : String;
			while( item	= iter.next() as String ) {
				_cb.addItem( { label:item } );
			}
			

			FlUtils.autoSizeCombo( _cb );
			
			_cb.addEventListener( Event.CHANGE , onChange );
			
			onValueChange( null );
			
		}

		override protected function onValueChange(event : PropertyEvent) : void {
			super.onValueChange( event );
			var val : String = _prop.value as String;
			var i : uint;
			var found : Boolean = false;
			for (i = 0; i < _cb.length ; i ++) {
				if( _cb.getItemAt( i ).label == val ) {
					found = true;
					_cb.selectedIndex = i;
					if( _cb.getItemAt(0) == _invalidItem  ) _cb.removeItemAt( 0 );
					break;
				}
			}
			
			if( ! found ) {
				if( _cb.getItemAt(0) != _invalidItem )
					_cb.addItemAt( _invalidItem , 0 );
				_cb.selectedIndex = 0;
			}
			
		}

		private function onChange(event : Event) : void {
			if( _cb.selectedItem == _invalidItem ) return;
			_prop.value = _cb.selectedLabel;
		}

		private var _enum : StringEnum;
		
		private var _cb : ComboBox;
		
		private var _invalidItem : Object;
	}
}
