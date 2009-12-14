package  
{
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import flash.display.Sprite;
	import flash.system.Security;
	
	public class FontA extends Sprite implements IFontsProvider {
		
		[Embed(fontStyle='normal', fontWeight='normal', unicodeRange='U+0000-U+0001', fontName='arial', source='C:/WINDOWS/Fonts/ARIAL.ttf', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_arial_normal:Class;

[Embed(fontStyle='italic', fontWeight='bold', unicodeRange='U+0000-U+0001', fontName='arial_bold_italic', systemFont='Arial', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_arial_bold_italic_bold:Class;


		
		function FontA () {
			if( Security.sandboxType != "application" )
				Security.allowDomain("*");
		}
		
		public function getFonts() : Array {
			return [ 
						_embed__font_arial_normal,_embed__font_arial_bold_italic_bold
					 ];
		}
		
	}
}
