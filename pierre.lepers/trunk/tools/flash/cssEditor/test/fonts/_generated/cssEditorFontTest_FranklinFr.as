package  
{
	
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.Font;
	
	public class cssEditorFontTest_FranklinFr extends Sprite implements IFontsProvider {
		
		[Embed(fontStyle='normal', fontWeight='normal', unicodeRange='U+0020-U+00ff', fontName='FranklinBook', systemFont='Franklin Gothic Book', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FranklinBook_normalnormal:Class;

[Embed(fontStyle='italic', fontWeight='normal', unicodeRange='U+0020-U+00ff', fontName='FranklinBook', systemFont='Franklin Gothic Book', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FranklinBook_normalitalic:Class;

[Embed(fontStyle='normal', fontWeight='bold', unicodeRange='U+0020-U+00ff', fontName='FranklinBook', systemFont='Franklin Gothic Book', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FranklinBook_boldnormal:Class;

[Embed(fontStyle='italic', fontWeight='bold', unicodeRange='U+0020-U+00ff', fontName='FranklinBook', systemFont='Franklin Gothic Book', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FranklinBook_bolditalic:Class;


		
		function cssEditorFontTest_FranklinFr () {
		
			if( Security.sandboxType != "application" )
				Security.allowDomain("*");
				
			//_register();
		}
		
		public function getFonts() : Array {
			return [ 
						_embed__font_FranklinBook_normalnormal,_embed__font_FranklinBook_normalitalic,_embed__font_FranklinBook_boldnormal,_embed__font_FranklinBook_bolditalic
					 ];
		}
		
		/*
		private function _register( ) : void {
			var _af : Array = getFonts();
			for each( var font : Class in _af )
				Font.registerFont( font );
		}
		*/
		
	}
}
