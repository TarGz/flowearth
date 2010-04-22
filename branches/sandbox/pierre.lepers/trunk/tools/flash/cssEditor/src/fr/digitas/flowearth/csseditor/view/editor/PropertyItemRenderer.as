package fr.digitas.flowearth.csseditor.view.editor {
	import fr.digitas.flowearth.csseditor.managers.TabManager;	
	import fr.digitas.flowearth.ui.button.DeleteStyleButton_FC;	
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.StyleProperty;
	import fr.digitas.flowearth.csseditor.data.completion.CSSCompletion;
	import fr.digitas.flowearth.csseditor.data.errors.ValidityState;
	import fr.digitas.flowearth.csseditor.event.PropertyEvent;
	import fr.digitas.flowearth.csseditor.event.ValidityEvent;
	import fr.digitas.flowearth.csseditor.view.editor.helper.AbstractHelper;
	import fr.digitas.flowearth.csseditor.view.editor.helper.HelperFactory;
	import fr.digitas.flowearth.ui.button.BaseButton;
	import fr.digitas.flowearth.ui.form.CompletionInputField;
	import fr.digitas.flowearth.ui.form.InputField;
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.display.DisplayObject;	

	/**
	 * @author Pierre Lepers
	 */
	public class PropertyItemRenderer extends Sprite implements ILayoutItem {

		public var nameLabel : TextField;
		public var valueLabel : TextField;
		public var bg : MovieClip;
		
		private var _deleteBtn : BaseButton;
		private var _errorField : ErrorField;
		
		public function PropertyItemRenderer() {
			_build();
		}
		
		private function _build() : void {
			nameLabel.autoSize = TextFieldAutoSize.LEFT;
			_nameInput = new CompletionInputField( nameLabel );
			_nameInput.setProvider( CSSCompletion.getPropNamesCompletions() );
			_nameInput.addEventListener( Event.CHANGE , onNameInputChange );

			valueLabel.autoSize = TextFieldAutoSize.LEFT;
			_valueInput = new InputField( valueLabel );
			_valueInput.addEventListener( Event.CHANGE , onValueInputChange );
			
			
			_errorField = new ErrorField( );
			_errorField.x = _errorField.y = 3;
			addChild( _errorField );
			
			_deleteBtn = new DeleteStyleButton_FC();
			_deleteBtn.addEventListener( MouseEvent.CLICK , onDelete );
			_deleteBtn.visible = false;
			_deleteBtn.y = 2; 
			addChild( _deleteBtn );
			
			bg.addEventListener( MouseEvent.MOUSE_DOWN , bgDown );
			
			addEventListener( MouseEvent.ROLL_OVER , over );
			addEventListener( MouseEvent.ROLL_OUT , out );
			focusRect = false;
		}
		
		private function over(event : MouseEvent) : void {
			_deleteBtn.visible = true;
		}

		private function out(event : MouseEvent) : void {
			_deleteBtn.visible = false;
		}

		private function onDelete(event : MouseEvent) : void {
			_prop.remove();
		}

		private function bgDown(event : MouseEvent) : void {
			stage.focus = this;
		}
		
		public function setTabIndex() : void {
			nameLabel.tabEnabled =
			valueLabel.tabEnabled = true;
			nameLabel.tabIndex = TabManager.getIndex();
			valueLabel.tabIndex = TabManager.getIndex();
			if( _helper ) _helper.tabIndex = TabManager.getIndex();
		}

		
		
		public function init(prop : StyleProperty) : void {
			if( _prop ) throw new Error( "fr.digitas.flowearth.csseditor.view.editor.PropertyItemRenderer - double init ! " );
			_prop = prop;
			
			_buildhelper();
			
			prop.addEventListener( PropertyEvent.RENAME , updateName );
			prop.addEventListener( PropertyEvent.STRVALUE_CHANGE , updateStrValue );
			prop.addEventListener( Event.CHANGE , onPropChange );
			prop.addEventListener( ValidityEvent.VALIDITY_CHANGE , onValidityEvent );
			updateName( );
			updateStrValue( );
			checkValidity( );
		}

		private function _buildhelper() : void {
			_helper = HelperFactory.getHelper( _prop );
			if( _helper ) {
				addChild( _helper );
				_helper.x = 380;
			}
		}

		public function dispose() : void {
			_prop.removeEventListener( PropertyEvent.RENAME , updateName );
			_prop.removeEventListener( PropertyEvent.STRVALUE_CHANGE , updateStrValue );
			_prop.removeEventListener( Event.CHANGE , onPropChange );
			_prop.removeEventListener( ValidityEvent.VALIDITY_CHANGE , onValidityEvent );
			_prop = null;
			
			if( _helper ) {
				_helper.dispose();
				removeChild( _helper );
			}
			_helper = null;
			
			_errorField.clear();
		}

		override public function set width(value : Number) : void {
			bg.width = value;
			_deleteBtn.x = value - _deleteBtn.width - 3;
		}
		
		private function updateName(event : TextEvent = null ) : void {
			nameLabel.text = _prop.name;
		}

		private function updateStrValue(event : PropertyEvent = null ) : void {
			valueLabel.text = _prop.strValue || "null";
		}
		
		
		private function onPropChange(event : Event) : void {
			_errorField.clear();
		}

		
		private function onValidityEvent(event : ValidityEvent) : void {
			_errorField.addState( event.state );
		}
		
		
		private function checkValidity() : void {
			var iter : IIterator = _prop.validityStates;
			var item : ValidityState;
			while( item	= iter.next() as ValidityState ) 
				_errorField.addState( item );
		}
		

		protected function onNameInputChange(event : Event) : void {
			_prop.setName( _nameInput.text );
		}
		
		protected function onValueInputChange(event : Event) : void {
			_prop.strValue = ( _valueInput.text == "null" ) ? null : _valueInput.text;
		}

		
		protected var _prop : StyleProperty;
		
		protected var _nameInput : CompletionInputField;

		protected var _valueInput : InputField;
		
		protected var _helper : AbstractHelper;
		
		public function getWidth() : Number {
			return 0;
		}
		
		public function getHeight() : Number {
			return 22;
		}
		
		public function getDisplay() : DisplayObject {
			return this;
		}
	}
}
