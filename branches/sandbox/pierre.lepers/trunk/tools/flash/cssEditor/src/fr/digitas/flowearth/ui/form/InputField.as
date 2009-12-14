package fr.digitas.flowearth.ui.form {
	import fr.digitas.flowearth.csseditor.view.console.Console;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.ui.Keyboard;	

	/**
	 * @author Pierre Lepers
	 */
	public class InputField extends EventDispatcher {

		
		
		public function InputField( tf : TextField ) {
			_tf = tf;
			_init();
			
		}
		
		public function get tf() : TextField {
			return _tf;
		}

		
//		private function onRemoved( e : Event ) : void {
//			stage.removeEventListener( MouseEvent.MOUSE_DOWN , onStageDown );
//		}
		

		public function get text() : String {
			return _tf.text;
		}
		
		public function set text(text : String) : void {
			_tf.text = text;
		}
		
		
		public function get inputMode() : Boolean {
			return _inputMode;
		}

		private function _init() : void {
//			x = _tf.x;
//			y = _tf.y;
//			_tf.x = _tf.y = 0;
//			_tf.parent.addChildAt( this, _tf.parent.getChildIndex( _tf ) );
//			addChild( _tf );
			
			_tf.addEventListener( FocusEvent.FOCUS_IN , focusIn );
			_tf.addEventListener( FocusEvent.FOCUS_OUT , focusOut );
//			addEventListener( FocusEvent.KEY_FOCUS_CHANGE , kFocusChange );
//			addEventListener( FocusEvent.FOCUS_IN , thisFocusIn );
			
			_tf.addEventListener( TextEvent.TEXT_INPUT , onTextInput );
			_tf.addEventListener( Event.CHANGE , onTextChange );
			
//			if( _tf.stage ) onAdded( null );
			_tf.addEventListener( Event.ADDED_TO_STAGE , onAdded );
			_tf.addEventListener( Event.REMOVED_FROM_STAGE , onRemoved );
				
			_tf.type = TextFieldType.INPUT;
			_tf.tabEnabled = true;
//			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}
//		
		protected function onAdded(event : Event) : void {
		}

		protected function onRemoved(event : Event) : void {
			_tf.stage.removeEventListener( KeyboardEvent.KEY_DOWN , keyDown, true );
			_tf.stage.removeEventListener( KeyboardEvent.KEY_UP , keyUp, true );
		}

		//		protected function kFocusChange(event : FocusEvent) : void {
//			Console.log( "fr.digitas.flowearth.ui.form.InputField - kFocusChange -- "+event.relatedObject );
//			Console.log( (event.relatedObject == this).toString() );
//			if( event.relatedObject && event.relatedObject == this ) {
//				event.preventDefault();
//			}
//		}

//		protected function thisFocusIn(event : FocusEvent) : void {
//			if( stage ) stage.focus = _tf;
//		}
		
		protected function onTextChange(event : Event) : void {
			dispatchEvent( event );
		}

		protected function onTextInput(event : TextEvent) : void {
			Console.log( "input" );
			if( _lockInput ) event.preventDefault();
		}

		protected function focusIn(event : FocusEvent) : void {
			
			if( ! _tf.stage ) return;
			Console.log( "focusIn" );
			_tf.stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown, true, 100 );
			_tf.stage.addEventListener( KeyboardEvent.KEY_UP , keyUp, true, 100 );
			_tf.selectable = 
			_tf.background = 
			_tf.border = true;
			
			var index : int = _tf.getCharIndexAtPoint( _tf.mouseX, _tf.mouseY );
			_tf.setSelection( index, _tf.text.length );
			
//			stage.addEventListener( MouseEvent.MOUSE_DOWN , onStageDown );
//			addEventListener( MouseEvent.MOUSE_DOWN , onDown );
		}
		
//		private function onDown(event : MouseEvent) : void {
//			event.stopPropagation();
//		}
//
//		private function onStageDown(event : MouseEvent) : void {
////			stage.focus = null;
//		}

		protected function focusOut(event : FocusEvent) : void {
			
			if( ! _tf.stage ) return;
			Console.log( "focusOut" );
			_tf.stage.removeEventListener( KeyboardEvent.KEY_DOWN , keyDown, true );
			_tf.stage.removeEventListener( KeyboardEvent.KEY_UP , keyUp, true );
//			stage.removeEventListener( MouseEvent.MOUSE_DOWN , onStageDown );
//			removeEventListener( MouseEvent.MOUSE_DOWN , onDown );

			//_tf.type = TextFieldType.DYNAMIC;
			_tf.selectable = 
			_tf.border = 
			_tf.background = false;
		}
		
		protected function keyUp(event : KeyboardEvent) : void {
			if( ! event.ctrlKey ) {
				_lockInput = false;
				_tf.borderColor = 0x0000;
			}
		}

		protected function keyDown(event : KeyboardEvent) : void {
			Console.log( "ctrlkey"+ event.ctrlKey.toString() )
			if( event.ctrlKey ) {
				_lockInput = true;
				_tf.borderColor = 0xFF0000;
			}
			
			else if( event.keyCode == Keyboard.ENTER )
				onEnterKey( );
		}
		
		protected function onEnterKey() : void {
			//if( _tf.stage ) _tf.stage.focus = _tf.parent;
		}

		protected var _tf : TextField;
		
		protected var _inputMode : Boolean = false;
		
		protected var _lockInput : Boolean = false;
		
	}
}
