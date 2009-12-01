package fr.digitas.flowearth.csseditor.view.editor {
	import fl.controls.ComboBox;
	
	import fr.digitas.flowearth.csseditor.data.StyleData;
	import fr.digitas.flowearth.csseditor.data.completion.StyleExtendCompletionProvider;
	import fr.digitas.flowearth.csseditor.event.StyleEvent;
	import fr.digitas.flowearth.ui.form.CompletionInputField;
	import fr.digitas.flowearth.ui.form.InputField;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;		

	/**
	 * @author Pierre Lepers
	 */
	public final class StyleHeader extends StyleHeader_CF {

		public var extendsCb : ComboBox;
		
		private var nameInput : InputField;
		private var superInput : CompletionInputField;

		private var _sData : StyleData;

		
		public function StyleHeader() {
			_build();
		}
		
		private function _build() : void {
			nameLabel.autoSize = TextFieldAutoSize.LEFT;
			superLabel.autoSize = TextFieldAutoSize.LEFT;
			extendsLabel.autoSize = TextFieldAutoSize.LEFT;
			
			nameInput = new InputField( nameLabel );
			nameInput.addEventListener( Event.CHANGE , onInputName );

			superInput = new CompletionInputField( superLabel );
			superInput.addEventListener( Event.CHANGE , onInputSuper );
			
			bg.addEventListener( MouseEvent.MOUSE_DOWN , bgDown );
			focusRect = false;
		}

		private function bgDown(event : MouseEvent) : void {
			stage.focus = this;
		}

		public function init(sData : StyleData) : void {
			
			_sData = sData;
			_sData.addEventListener( StyleEvent.RENAME , updateName );
			_sData.addEventListener( StyleEvent.SUPER_CHANGE , updateSuper );
			
			superInput.setProvider( new StyleExtendCompletionProvider( sData ) );
			
			updateName();
			updateSuper();
			
		}
		
		public function dispose() : void {
			_sData.removeEventListener( StyleEvent.RENAME , updateName );
			_sData.removeEventListener( StyleEvent.SUPER_CHANGE , updateSuper);
			nameInput.removeEventListener( Event.CHANGE , onInputName );
			superInput.removeEventListener( Event.CHANGE , onInputSuper );
			bg.removeEventListener( MouseEvent.MOUSE_DOWN , bgDown );
			extendsLabel.removeEventListener( MouseEvent.CLICK , onAddSuper );
			_sData = null;
		}
		
		public function collapse(_collapse : Boolean) : void {
			cArrow.rotation = _collapse ? 0 : 90;
		}

		override public function set width(value : Number) : void {
			bg.width = value;
		}

		override public function get height() : Number {
			return bg.height;
		}
		
		private function updateName(event : TextEvent = null ) : void {
			nameInput.text = _sData.getName( );
			extendsLabel.x = nameInput.x + nameInput.width + 10;
			superInput.x = extendsLabel.x + extendsLabel.width + 10;
		}
		
		private function updateSuper(event : StyleEvent = null ) : void {
			if( _sData.superName == null ) {
				superInput.text = "";
				extendsLabel.text = "extends +";
				extendsLabel.addEventListener( MouseEvent.CLICK , onAddSuper );
			} else {
				extendsLabel.text = "extends";
				superInput.text = _sData.superName;
				extendsLabel.removeEventListener( MouseEvent.CLICK , onAddSuper );
			}
		}
		
		private function onAddSuper(event : MouseEvent) : void {
			stage.focus = superInput.tf;
			superInput.tf.text = "parent style";
			superInput.tf.setSelection(0, 12);
		}

		private function onInputName(event : Event) : void {
			if( nameInput.text == _sData.getName( ) ) return;
			_sData.setName( nameInput.text );
		}

		private function onInputSuper(event : Event) : void {
			if( superInput.text == _sData.superName ) return;
			_sData.superName = superInput.text;
		}
	
	}
}
