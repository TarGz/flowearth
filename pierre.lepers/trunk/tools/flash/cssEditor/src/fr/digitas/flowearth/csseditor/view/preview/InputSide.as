package fr.digitas.flowearth.csseditor.view.preview {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;	

	/**
	 * @author Pierre Lepers
	 */
	public class InputSide extends Sprite {
		
		
		public function InputSide() {
			_build( );
		}
		
		public function getText() : String {
			return _tf.text;
		}
		
		override public function set width(value : Number) : void {
			_tf.width = value;
		}

		override public function set height(value : Number) : void {
			_tf.height = value;
		}
		
		private function _build() : void {
			
			_tf = new TextField();
			_tf.defaultTextFormat = new TextFormat( "Courier New", 12 );
			_tf.multiline = true;
			_tf.wordWrap = true;
			_tf.background = true;
			_tf.type = TextFieldType.INPUT;
			_tf.text = DEFAULT_TEXT;
			_tf.addEventListener( Event.CHANGE , onTftChange );
			
			addChild( _tf );
			
		}
		
		private function onTftChange(event : Event) : void {
			dispatchEvent( event );
		}
		
		private static const DEFAULT_TEXT : String = "Lorem ipsum";
		
		
		private var _tf : TextField;
	}
}
