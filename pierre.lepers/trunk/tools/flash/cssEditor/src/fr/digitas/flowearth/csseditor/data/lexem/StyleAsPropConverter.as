package fr.digitas.flowearth.csseditor.data.lexem {
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class StyleAsPropConverter {

		public static function convert( name : String ) : String {
			return _map[ name ] || name;
		}

		
		private static function _getMapper() : Dictionary {
			
			var map : Dictionary = new Dictionary( );
			
			//			map[ "display" ] = "display";
			//			map[ "kerning" ] = "kerning";
			//			map[ "color" ] = "color";
			//			map[ "leading" ] = "leading";

			map[ "textDecoration" ] = "text-decoration";
			map[ "textAlign" ] = "text-align";
			map[ "fontWeight" ] = "font-weight";
			map[ "fontStyle" ] = "font-style";
			map[ "fontFamily" ] = "font-family";
			map[ "fontSize" ] = "font-size";
			map[ "letterSpacing" ] = "letter-spacing";
			map[ "marginLeft" ] = "margin-left";
			map[ "marginRight" ] = "margin-right";
			map[ "textIndent" ] = "text-indent";
			
			return map;
		}

		private static const _map : Dictionary = _getMapper( );
	}
}
