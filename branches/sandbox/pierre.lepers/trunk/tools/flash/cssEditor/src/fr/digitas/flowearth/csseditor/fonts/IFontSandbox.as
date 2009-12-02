package fr.digitas.flowearth.csseditor.fonts {
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public interface IFontSandbox {
	
		function getStyledTf( styleName : Object, htmlText : String ) : TextField;
		
		function registerFonts( provider : IFontsProvider ) : void;
	
	}
}
