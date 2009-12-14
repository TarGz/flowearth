package fr.digitas.flowearth.csseditor.view.editor.helper {
	import fr.digitas.flowearth.csseditor.data.StyleProperty;	
	
	import flash.utils.Dictionary;import flash.utils.getQualifiedClassName;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class HelperFactory {

		
		public static function getHelper( prop : StyleProperty ) : AbstractHelper {
			var factory : Function = _helperMap[ getQualifiedClassName( prop.type ) ];
			if( factory == null ) return null;
			var h : AbstractHelper = factory( prop );
			if( h ) h.setProp( prop );
			return h;
		}

		private static var _helperMap : Dictionary = _getHelperMap();
		
		private static function _getHelperMap() : Dictionary {
			var res : Dictionary = new Dictionary();
			
//			res[ "fr.digitas.flowearth.csseditor.data.builder.types::StringEnum" ] 		= get_StringEnumHelper;
			res[ "fr.digitas.flowearth.csseditor.data.builder.types::CSSUint" ] 		= get_ColorHelper;
			
			res[ "fr.digitas.flowearth.csseditor.data.builder.types::PropertyType" ] 	= get_genericType;


//			res[ "Boolean" ] 	= get_BooleanHelper;
			res[ "uint" ] 		= get_ColorHelper;
			
			return res;
		}

		private static function get_StringEnumHelper( prop : StyleProperty ) : AbstractHelper {
			return new StringEnumHelper();
			prop;
		}

		private static function get_BooleanHelper( prop : StyleProperty ) : AbstractHelper {
			return new BooleanHelper();
			prop;
		}

		private static function get_ColorHelper( prop : StyleProperty ) : AbstractHelper {
			return new ColorHelper( );
			prop;
		}

		private static function get_genericType( prop : StyleProperty ) : AbstractHelper {
			var nativeType : Class = prop.type.getNativeType();
			var factory : Function = _helperMap[ getQualifiedClassName( nativeType ) ];
			if( factory == null ) return null;
			return factory( prop );
		}
	}
}
