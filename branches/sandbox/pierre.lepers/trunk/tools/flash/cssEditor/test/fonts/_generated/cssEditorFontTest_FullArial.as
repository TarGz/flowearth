package  
{
	
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.Font;
	
	public class cssEditorFontTest_FullArial extends Sprite implements IFontsProvider {
		
		[Embed(fontStyle='normal', fontWeight='normal', unicodeRange='U+0000-U+FFFF', fontName='FullArial', systemFont='Arial', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FullArial_normalnormal:Class;

[Embed(fontStyle='italic', fontWeight='normal', unicodeRange='U+0000-U+FFFF', fontName='FullArial', systemFont='Arial', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FullArial_normalitalic:Class;

[Embed(fontStyle='normal', fontWeight='bold', unicodeRange='U+0000-U+FFFF', fontName='FullArial', systemFont='Arial', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FullArial_boldnormal:Class;

[Embed(fontStyle='italic', fontWeight='bold', unicodeRange='U+0000-U+FFFF', fontName='FullArial', systemFont='Arial', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FullArial_bolditalic:Class;


		
		function cssEditorFontTest_FullArial () {
		
			if( Security.sandboxType != "application" )
				Security.allowDomain("*");
				
			//_register();
		}
		
		public function getFonts() : Array {
			return [ 
						_embed__font_FullArial_normalnormal,_embed__font_FullArial_normalitalic,_embed__font_FullArial_boldnormal,_embed__font_FullArial_bolditalic
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
