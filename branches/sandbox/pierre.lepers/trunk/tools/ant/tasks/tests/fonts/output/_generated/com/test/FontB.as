package com.test 
{
	
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import flash.display.Sprite;
	import flash.system.Security;
	
	public class FontB extends Sprite implements IFontsProvider {
		
		
		
		function FontB () {
			if( Security.sandboxType != "application" )
				Security.allowDomain("*");
		}
		
		public function getFonts() : Array {
			return [ 
						
					 ];
		}
		
	}
}
