package fr.digitas.flowearth.csseditor.view.console {
	import flash.text.TextFieldType;	
	
	import fr.digitas.flowearth.ui.scroller.Scroller;
	import fr.digitas.flowearth.ui.scroller.Scroller_FC;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;		

	/**
	 * @author Pierre Lepers
	 */
	public class Console extends Sprite {

		private var tf : TextField;
		
		private var scroll : Scroller;

		public function Console() {
			
			tf = new TextField( );
			tf.defaultTextFormat = new TextFormat( "Courier New", 12 );
			tf.autoSize = "left";
			tf.multiline = true;
			tf.wordWrap = true;
			tf.background = true;
			tf.type = TextFieldType.INPUT;
			
			scroll = new Scroller_FC();
			scroll.addChild( tf );
			
			addChild( scroll );

			instance = this;
		}

		override public function set width(value : Number) : void {
			tf.width = value;
			scroll.width = value;
		}

		override public function set height(value : Number) : void {
			scroll.height = value;
		}

		public static function log( str : String ) : void {
			instance.tf.appendText( "\n" + str );
		}

		public static var instance : Console;
	}
}
