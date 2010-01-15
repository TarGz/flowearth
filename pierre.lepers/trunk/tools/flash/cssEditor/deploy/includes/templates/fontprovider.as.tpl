package ${fptpl_package} 
{
	
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import flash.display.Sprite;
	import flash.system.Security;
	import flash.text.Font;
	
	public class ${fptpl_classname} extends Sprite implements IFontsProvider {
		
		${fptpl_fontsDecl}
		
		function ${fptpl_classname} () {
		
			if( Security.sandboxType != "application" )
				Security.allowDomain("*");
				
			//_register();
		}
		
		public function getFonts() : Array {
			return [ 
						${fptpl_fontsList}
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
