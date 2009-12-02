package fr.digitas.flowearth.csseditor.fonts {
	import fr.digitas.flowearth.csseditor.view.console.Console;
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import fr.digitas.flowearth.text.styles.styleManager;
	
	import flash.display.Sprite;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontSandbox extends Sprite implements IFontSandbox {

		public function FontSandbox() {
			_embeddedFonts = new Dictionary();
			_updateEmbedded();
		}
		
		public function getStyledTf( styleName : Object, htmlText : String ) : TextField {
			var tf : TextField = new TextField();
			styleManager.apply(tf, styleName , htmlText );
			return tf;
		}
		
		public function registerFonts( provider : IFontsProvider ) : void {
			var fonts : Array = provider.getFonts();
			for each (var font : Class in fonts) {
				Font.registerFont( font );
				Console.log( font.toString() );
			}
			_updateEmbedded();
		}
		
		
		private function _updateEmbedded() : void {
			var list:Array = Font.enumerateFonts();
			var n:int = list.length;
			for (var i:Number = 0; i < n; i++) 
				_embeddedFonts[ (list[i] as Font).fontName ] = list[i];
			
		}

		private var _embeddedFonts : Dictionary;

	}
}
