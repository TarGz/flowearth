////////////////////////////////////////////////////////////////////////////////
//
//  DIGITAS FRANCE / VIVAKI COMMUNICATIONS
//  Copyright 2008-2009 Digitas France
//  All Rights Reserved.
//
//  NOTICE: Digitas permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


package fr.digitas.flowearth.text.styles {
	import flash.utils.Dictionary;				

	/**
	 * @author Pierre Lepers
	 */
	final public class TypeMapper {


		public static function transtype( prop : String, value : String ) : * {
			return ( _map[ prop ] || _null_transtyper as Object )( value );
		}
		
		
		private static var _isinit : Boolean = _init();
		
		private static function _init() : Boolean {
			_map = new Dictionary();
			// INT
			_map[ "maxChars" ] =
			_map[ "scrollH" ] =
			_map[ "scrollV" ] =
			_map[ "tabIndex" ] = _int_transtyper;
			
			// UINT
			_map[ "borderColor" ] =
			_map[ "textColor" ] =
			_map[ "backgroundColor" ] = _uint_transtyper;
				
			// NUMBER	
			_map[ "alpha" ] =
			_map[ "rotation" ] =
			_map[ "scaleX" ] =
			_map[ "scaleY" ] =
			_map[ "height" ] =
			_map[ "sharpness" ] =
			_map[ "thickness" ] =
			_map[ "width" ] =
			_map[ "x" ] =
			_map[ "y" ] = _number_transtyper;
			
			// BOOL
			_map[ "background" ] =
			_map[ "border" ] =
			_map[ "cacheAsBitmap" ] =
			_map[ "condenseWhite" ] =
			_map[ "displayAsPassword" ] =
			_map[ "doubleClickEnabled" ] =
			_map[ "embedFonts" ] =
			_map[ "mouseEnabled" ] =
			_map[ "mouseWheelEnabled" ] =
			_map[ "multiline" ] =
			_map[ "selectable" ] =
			_map[ "tabEnabled" ] =
			_map[ "useRichTextClipboard" ] =
			_map[ "visible" ] =
			_map[ "wordWrap" ] = _boolean_transtyper;
				
			// STRING
			_map[ "antiAliasType" ] =
			_map[ "autoSize" ] =
			_map[ "blendMode" ] =
			_map[ "gridFitType" ] =
			_map[ "htmlText" ] =
			_map[ "name" ] =
			_map[ "restrict" ] =
			_map[ "text" ] =
			_map[ "type" ] = _string_transtyper;
			
			// FILTERS
//			_map[ "filters" ] = _filters_transtyper;
			
			// BitmapFilter
			//_map[ "dropShadow"
			
			
			
			_isinit;
			return true;
		}
		
		//_____________________________________________________________________________
		//																	TRANSTYPERS
		
		private static function _int_transtyper( value : String ) : Number {
			if( value.charAt( 0 ) == "#" )
				value = "0x"+value.substr( 1 );
			return parseInt( value );
		}

		private static function _uint_transtyper( value : String ) : Number {
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
			return null;
			value;
		}
		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		public static var _map : Dictionary;
		
	}
}