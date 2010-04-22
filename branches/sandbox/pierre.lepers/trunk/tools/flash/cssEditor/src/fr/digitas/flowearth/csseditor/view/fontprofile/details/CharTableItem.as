package fr.digitas.flowearth.csseditor.view.fontprofile.details {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.DisplayObject;
	import flash.text.Font;
	import flash.text.FontStyle;
	import flash.text.TextField;
	import flash.text.TextFormat;	

	/**
	 * @author Pierre Lepers
	 */
	public class CharTableItem extends CharTableItem_FC implements ILayoutItem {
		
		public function CharTableItem( font : Font ) {
			_font = font;
			tf.defaultTextFormat = new TextFormat( font.fontName, 30, 0, ( font.fontStyle == FontStyle.BOLD || font.fontStyle == FontStyle.BOLD_ITALIC ), ( font.fontStyle == FontStyle.ITALIC || font.fontStyle == FontStyle.BOLD_ITALIC )  );
		}

		public function set code(code : uint) : void {
			_code = code;
			_build( );
		}
		
		private function _build() : void {
			var codeStr:  String = _code.toString( 16 );
			while( codeStr.length < 4 ) 
				codeStr = "0" + codeStr;
			
			codeTf.text = "U+" + codeStr;
			
			var char : String = String.fromCharCode( _code );
			var hasGlyph : Boolean = _font.hasGlyphs( char );
			tf.embedFonts = hasGlyph;
			bg.visible = ! hasGlyph;
			tf.text = char;
		}

		private var _code : uint;
		private var _font : Font;
		
		public function getWidth() : Number {
			return WIDTH;
		}
		
		public function getHeight() : Number {
			return HEIGHT;
		}
		
		public function getDisplay() : DisplayObject {
			return this;
		}
		
		public static const WIDTH : int = 40;
		public static const HEIGHT : int = 60;
	}
}
