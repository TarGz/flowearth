package fr.digitas.flowearth.csseditor.data.builder {
	import flash.text.TextDisplayMode;	
	import flash.text.TextFieldType;	
	import flash.text.GridFitType;	
	import flash.display.BlendMode;	
	import flash.text.TextFieldAutoSize;	
	import flash.text.AntiAliasType;	
	
	import fr.digitas.flowearth.csseditor.data.builder.types.StringEnum;	
	import fr.digitas.flowearth.csseditor.data.builder.types.PropertyType;	
	import fr.digitas.flowearth.csseditor.data.builder.types.CSSUint;
	
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class TypeMapper {
		
		public static function getType( prop : String ) : PropertyType {
			return ( _map[ prop ] || null );
		}
		
		
		private static var _isinit : Boolean = _init();
		
		private static function _init() : Boolean {
			_map = new Dictionary();
			
			//_____________________________________________________________________________
			//																	  TextField
			// INT
			_map[ "maxChars" ] =
			_map[ "scrollH" ] =
			_map[ "scrollV" ] =
			_map[ "tabIndex" ] = new PropertyType( int );
			
			// UINT
			_map[ "borderColor" ] =
			_map[ "textColor" ] =
			_map[ "backgroundColor" ] = new PropertyType( uint );
				
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
			_map[ "y" ] = new PropertyType( Number );
			
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
			_map[ "wordWrap" ] = new PropertyType( Boolean );
				
			// STRING
			_map[ "antiAliasType" ] 	= new StringEnum( [ AntiAliasType.NORMAL , AntiAliasType.ADVANCED ] );
			_map[ "autoSize" ] 			= new StringEnum( [ TextFieldAutoSize.NONE , TextFieldAutoSize.LEFT , TextFieldAutoSize.CENTER , TextFieldAutoSize.RIGHT ] );
			_map[ "blendMode" ] 		= new StringEnum( [ BlendMode.ADD, BlendMode.ALPHA, BlendMode.DARKEN, BlendMode.DIFFERENCE, BlendMode.ERASE, BlendMode.HARDLIGHT, BlendMode.INVERT, BlendMode.LAYER, BlendMode.LIGHTEN, BlendMode.MULTIPLY, BlendMode.NORMAL, BlendMode.OVERLAY, BlendMode.SCREEN, BlendMode.SHADER, BlendMode.SUBTRACT ] );
			_map[ "gridFitType" ] 		= new StringEnum( [ GridFitType.NONE, GridFitType.PIXEL, GridFitType.SUBPIXEL ] );
			_map[ "type" ] 				= new StringEnum( [ TextFieldType.DYNAMIC, TextFieldType.INPUT ] );
			
			_map[ "htmlText" ] =
			_map[ "name" ] =
			_map[ "restrict" ] =
			_map[ "text" ] = new PropertyType( String );
			
			
			//_____________________________________________________________________________
			//																	  StylSheet
			
			_map[ "color" ] 			= new CSSUint();
			
			_map[ "text-decoration" ] 	= new StringEnum( [ "none", "underline" ] );
			_map[ "display" ] 			= new StringEnum( [ "none", "inline", "block" ] );
			_map[ "text-align" ] 		= new StringEnum( [ "left", "center", "right", "justify" ] );
			_map[ "font-weight" ] 		= new StringEnum( [ "normal", "bold" ] );
			_map[ "font-style" ] 		= new StringEnum( [ "normal", "italic" ] );
			
			_map[ "font-family" ] 		= new PropertyType( String );
			
			_map[ "kerning" ] = new PropertyType( Boolean );

			_map[ "font-size" ] = 
			_map[ "leading" ] =
			_map[ "letter-spacing" ] =
			_map[ "margin-left" ] =
			_map[ "margin-right" ] =
			_map[ "text-indent" ] = new PropertyType( Number );
			
			// FILTERS
//			_map[ "filters" ] = _filters_transtyper;
			
			// BitmapFilter
			//_map[ "dropShadow"
			
			
			
			_isinit;
			return true;
		}
		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		public static var _map : Dictionary;
	}
}
