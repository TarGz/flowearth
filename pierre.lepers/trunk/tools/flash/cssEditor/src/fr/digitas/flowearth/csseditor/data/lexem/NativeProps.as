package fr.digitas.flowearth.csseditor.data.lexem {

	/**
	 * @author Pierre Lepers
	 */
	public class NativeProps {


		public static function isNativeProp( name : String ) : Boolean {
			return _props.indexOf( name ) > -1;
		}


		private static const _props : Array = _getProps();
		
		private static function _getProps() : Array {
			var props : Array = [
								 "maxChars",
								 "scrollH",
								 "scrollV",
								 "tabIndex", 
								 "borderColor",
								 "textColor",
								 "backgroundColor", 
								 "alpha",
								 "rotation",
								 "scaleX",
								 "scaleY",
								 "height",
								 "sharpness",
								 "thickness",
								 "width",
								 "x",
								 "y", 
								 "background",
								 "border",
								 "cacheAsBitmap",
								 "condenseWhite",
								 "displayAsPassword",
								 "doubleClickEnabled",
								 "embedFonts",
								 "mouseEnabled",
								 "mouseWheelEnabled",
								 "multiline",
								 "selectable",
								 "tabEnabled",
								 "useRichTextClipboard",
								 "visible",
								 "wordWrap", 
								 "antiAliasType",
								 "autoSize",
								 "blendMode",
								 "gridFitType",
								 "htmlText",
								 "name",
								 "restrict",
								 "text",
								 "type", 
								 "color", 
								 "text-decoration",
								 "text-align",
								 "font-weight",
								 "font-style",
								 "font-family",
								 "display", 
								 "font-size", 
								 "kerning",
								 "leading",
								 "letter-spacing",
								 "margin-left",
								 "margin-right",
								 "text-indent"
			 ];
			 
			return props;
		}
		
	}
}
