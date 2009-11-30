package ${fptpl_package} 
{
	
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	import flash.display.Sprite;
	import flash.system.Security;
	
	public class ${fptpl_classname} extends Sprite implements IFontsProvider {
		
		${fptpl_fontsDecl}
		
		function ${fptpl_classname} () {
			if( Security.sandboxType != "application" )
				Security.allowDomain("*");
		}
		
		public function getFonts() : Array {
			return [ 
						${fptpl_fontsList}
					 ];
		}
		
	}
}
