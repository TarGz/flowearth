package  
{
	
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.Font;
	
	public class cssEditorFontTest_2 extends Sprite implements IFontsProvider {
		
		[Embed(fontStyle='normal', fontWeight='normal', unicodeRange='U+0041,U+0042,U+0043,U+0061,U+0062,U+0063', fontName='FontA', source='D:/work/workspaces/as3/Flowearth_sandbox/tools/flash/cssEditor/test/fonts/HelveticaNeueLTStd-XBlkCn.otf', _pathsep='true', mimeType='application/x-font')]
private static var _embed__font_FontA_normalnormal:Class;


		
		function cssEditorFontTest_2 () {
		
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
