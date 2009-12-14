package  
{
	
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.Font;
	
	public class cssEditorFontTest_1 extends Sprite implements IFontsProvider {
		
		[Embed(fontStyle='normal', fontWeight='normal', unicodeRange='U+0020-U+00ff', fontName='FontA', source='C:/work/workspaces/as3/Flowearth/tools/flash/cssEditor/test/fonts/GillSans-Light.otf', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FontA_normalnormal:Class;


		
		function cssEditorFontTest_1 () {
		
			if( Security.sandboxType != "application" )
				Security.allowDomain("*");
				
			//_register();
		}
		
		public function getFonts() : Array {
			return [ 
						_embed__font_FontA_normalnormal
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
