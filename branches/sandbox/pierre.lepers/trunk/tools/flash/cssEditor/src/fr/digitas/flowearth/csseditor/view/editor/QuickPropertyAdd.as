package fr.digitas.flowearth.csseditor.view.editor {
	import fr.digitas.flowearth.csseditor.data.StyleData;
	import fr.digitas.flowearth.csseditor.data.StyleProperty;
	
	import flash.events.FocusEvent;
	import flash.utils.setTimeout;		

	/**
	 * @author Pierre Lepers
	 */
	public class QuickPropertyAdd extends PropertyItemRenderer_FC {

		private var _sdata : StyleData;
		
		public function QuickPropertyAdd( sdata : StyleData ) {
			
			super( );

			_sdata = sdata;
			
			nameLabel.textColor = 0x808080;
			
			_nameInput.tf.addEventListener( FocusEvent.FOCUS_IN , onFocusIn, false, -100 );
			addEventListener( FocusEvent.MOUSE_FOCUS_CHANGE , onFocusChange );
			addEventListener( FocusEvent.KEY_FOCUS_CHANGE , onFocusChange );
			
			init( new StyleProperty( "add new property") );
		}
		
		private function onFocusIn(event : FocusEvent) : void {
			_nameInput.tf.text = "add new property"; 
			setTimeout( startFocusIn, 20 );
		}

		private function startFocusIn() : void {
			_nameInput.tf.setSelection( 0 , _nameInput.tf.text.length );
		}

		private function onFocusChange(event : FocusEvent) : void {
			if( event.relatedObject && contains( event.relatedObject ) )
				return;
				
			onNameInputChange( null );
			if( _nameInput.text != "add new property" && _nameInput.text != "" ) {
				if( ! _sdata.hasProperty(_nameInput.text ) ) {
					_sdata.addProperty( _prop );
					super.dispose();
					init( new StyleProperty( "add new property") );
				} else {
					// name already exist
				}
			} else {
				_nameInput.text = "add new property";
			}
		}

		override public function dispose() : void {
			super.dispose( );
			_sdata = null;
			removeEventListener( FocusEvent.MOUSE_FOCUS_CHANGE , onFocusChange );
			removeEventListener( FocusEvent.KEY_FOCUS_CHANGE , onFocusChange );
			_nameInput.tf.removeEventListener( FocusEvent.FOCUS_IN , onFocusIn );
		}
		
	}
}
