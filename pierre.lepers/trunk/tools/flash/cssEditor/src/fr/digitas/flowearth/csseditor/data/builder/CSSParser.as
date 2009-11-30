package fr.digitas.flowearth.csseditor.data.builder {
	import fr.digitas.flowearth.csseditor.data.CSSData;
	import fr.digitas.flowearth.csseditor.data.StyleData;
	import fr.digitas.flowearth.csseditor.data.StyleProperty;
	
	import flash.text.StyleSheet;		

	/**
	 * @author Pierre Lepers
	 */
	public class CSSParser {

		public static function parse( str : String, _data : CSSData ) : void {
			var baseSheet : StyleSheet = new StyleSheet( );
			baseSheet.parseCSS( str );
			
			var sdata : StyleData;
			for each (var name : String in baseSheet.styleNames ) {
				sdata = _data.addStyle(name);
				buildStyle( sdata , baseSheet.getStyle( name ) );
			}
		}

		private static function buildStyle( sdata : StyleData , obj : Object ) : void {
			
			var prop : StyleProperty;
			
			for (var pname : String in obj ) {
				prop = new StyleProperty( pname );
				prop.strValue = obj[ pname ];
				sdata.addProperty( prop );
			}
			
		}
	}
}
