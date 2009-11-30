package fr.digitas.flowearth.csseditor.data.builder {
	import fr.digitas.flowearth.csseditor.data.StyleProperty;
	import fr.digitas.flowearth.csseditor.data.builder.types.CSSUint;
	
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class Transtyper {
		
		public static function transtype( prop : StyleProperty ) : * {
			return ( _typers[ prop.type ] || _null_transtyper )( prop.strValue );
		}

		public static function stringify( prop : StyleProperty ) : * {
			return ( _typers[ prop.type ] || _null_stringifyer )( prop.value );
		}
		
		
		private static var _isinit : Boolean = _init( );

		private static function _init() : Boolean {
			_typers = new Dictionary();
			_typers[ int ] 		= _int_transtyper;
			_typers[ uint ] 		= _uint_transtyper;
			_typers[ Number ] 		= _number_transtyper;
			_typers[ Boolean ] 	= _boolean_transtyper;
			_typers[ String ] 		= _string_transtyper;
			_typers[ CSSUint ] 	= _cssUint_transtyper;

			_stringifyers = new Dictionary();
			_stringifyers[ int ] 		= _int_stringifyer;
			_stringifyers[ uint ] 		= _uint_stringifyer;
			_stringifyers[ Number ] 		= _number_stringifyer;
			_stringifyers[ Boolean ] 	= _boolean_stringifyer;
			_stringifyers[ String ] 		= _string_stringifyer;
			_stringifyers[ CSSUint ] 	= _cssUint_stringifyer;
			
			
			
			
			_isinit;
			return true;
		}
		
		//_____________________________________________________________________________
		//																	TRANSTYPERS
		
		private static function _cssUint_transtyper( value : String ) : CSSUint {
			if( value.charAt( 0 ) == "#" )
				value = "0x"+value.substr( 1 );
			var res : CSSUint = new CSSUint( parseInt( value ) );
			return res;
		}
		
		private static function _int_transtyper( value : String ) : int {
			if( value.charAt( 0 ) == "#" )
				value = "0x"+value.substr( 1 );
			return parseInt( value );
		}

		private static function _uint_transtyper( value : String ) : uint {
			if( value.charAt( 0 ) == "#" )
				value = "0x"+value.substr( 1 );
			return parseInt( value );
		}

		private static function _number_transtyper( value : String ) : Number {
			return parseFloat( value );
		}

		private static function _boolean_transtyper( value : String ) : Boolean {
			return ( value == "true" || value == "1" );
		}

		private static function _string_transtyper( value : String ) : String {
			return value;
		}

		private static function _null_transtyper( value : String ) : String {
			return value;
		}

		//_____________________________________________________________________________
		//																	TRANSTYPERS
		
		private static function _cssUint_stringifyer( value : CSSUint ) : String {
			return "#"+value.value.toString( 16 );
		}
		
		private static function _int_stringifyer( value : int ) : String {
			return "0x"+value.toString( 16 );
		}

		private static function _uint_stringifyer( value : uint ) : String {
			return "0x"+value.toString( 16 );
		}

		private static function _number_stringifyer( value : Number ) : String {
			return value.toString( 10 );
		}

		private static function _boolean_stringifyer( value : Boolean ) : String {
			return value.toString();
		}

		private static function _string_stringifyer( value : String ) : String {
			return value;
		}

		private static function _null_stringifyer( value : * ) : String {
			return value.toString();
		}
		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		public static var _typers : Dictionary;
		public static var _stringifyers : Dictionary;
	}
}
