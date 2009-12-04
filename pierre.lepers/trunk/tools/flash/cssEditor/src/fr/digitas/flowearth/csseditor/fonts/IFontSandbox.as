package fr.digitas.flowearth.csseditor.fonts {
	import flash.display.Loader;
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public interface IFontSandbox {
	
		function getStyledTf( styleName : Object, htmlText : String ) : TextField;
		
		function loadFonts( fontFileUrl : String ) : Loader;

		function registerFonts( provider : Object ) : void;
	
	}
}
