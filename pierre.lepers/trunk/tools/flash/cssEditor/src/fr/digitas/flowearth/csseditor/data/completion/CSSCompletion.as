package fr.digitas.flowearth.csseditor.data.completion {
	import fr.digitas.flowearth.ui.form.CompletionData;
	import fr.digitas.flowearth.ui.form.CompletionProvider;	

	/**
	 * @author Pierre Lepers
	 */
	public class CSSCompletion {

		
		public static function getPropNamesCompletions() : CompletionProvider {
			return _propNamesCompletions;
		}
		
		private static function _init() : Boolean {
			
			_propNamesCompletions = new CompletionProvider();
			
			_propNamesCompletions.addItem( _getCompletionData( "maxChars" ) );
			_propNamesCompletions.addItem( _getCompletionData( "scrollH" ) );
			_propNamesCompletions.addItem( _getCompletionData( "scrollV" ) );
			_propNamesCompletions.addItem( _getCompletionData( "tabIndex" ) ); 
			_propNamesCompletions.addItem( _getCompletionData( "borderColor" ) );
			_propNamesCompletions.addItem( _getCompletionData( "textColor" ) );
			_propNamesCompletions.addItem( _getCompletionData( "backgroundColor" ) ); 
			_propNamesCompletions.addItem( _getCompletionData( "alpha" ) );
			_propNamesCompletions.addItem( _getCompletionData( "rotation" ) );
			_propNamesCompletions.addItem( _getCompletionData( "scaleX" ) );
			_propNamesCompletions.addItem( _getCompletionData( "scaleY" ) );
			_propNamesCompletions.addItem( _getCompletionData( "height" ) );
			_propNamesCompletions.addItem( _getCompletionData( "sharpness" ) );
			_propNamesCompletions.addItem( _getCompletionData( "thickness" ) );
			_propNamesCompletions.addItem( _getCompletionData( "width" ) );
			_propNamesCompletions.addItem( _getCompletionData( "x" ) );
			_propNamesCompletions.addItem( _getCompletionData( "y" ) ); 
			_propNamesCompletions.addItem( _getCompletionData( "background" ) );
			_propNamesCompletions.addItem( _getCompletionData( "border" ) );
			_propNamesCompletions.addItem( _getCompletionData( "cacheAsBitmap" ) );
			_propNamesCompletions.addItem( _getCompletionData( "condenseWhite" ) );
			_propNamesCompletions.addItem( _getCompletionData( "displayAsPassword" ) );
			_propNamesCompletions.addItem( _getCompletionData( "doubleClickEnabled" ) );
			_propNamesCompletions.addItem( _getCompletionData( "embedFonts" ) );
			_propNamesCompletions.addItem( _getCompletionData( "mouseEnabled" ) );
			_propNamesCompletions.addItem( _getCompletionData( "mouseWheelEnabled" ) );
			_propNamesCompletions.addItem( _getCompletionData( "multiline" ) );
			_propNamesCompletions.addItem( _getCompletionData( "selectable" ) );
			_propNamesCompletions.addItem( _getCompletionData( "tabEnabled" ) );
			_propNamesCompletions.addItem( _getCompletionData( "useRichTextClipboard" ) );
			_propNamesCompletions.addItem( _getCompletionData( "visible" ) );
			_propNamesCompletions.addItem( _getCompletionData( "wordWrap" ) ); 
			_propNamesCompletions.addItem( _getCompletionData( "antiAliasType" ) );
			_propNamesCompletions.addItem( _getCompletionData( "autoSize" ) );
			_propNamesCompletions.addItem( _getCompletionData( "blendMode" ) );
			_propNamesCompletions.addItem( _getCompletionData( "gridFitType" ) );
			_propNamesCompletions.addItem( _getCompletionData( "htmlText" ) );
			_propNamesCompletions.addItem( _getCompletionData( "name" ) );
			_propNamesCompletions.addItem( _getCompletionData( "restrict" ) );
			_propNamesCompletions.addItem( _getCompletionData( "text" ) );
			_propNamesCompletions.addItem( _getCompletionData( "type" ) ); 
			_propNamesCompletions.addItem( _getCompletionData( "color" ) ); 
			_propNamesCompletions.addItem( _getCompletionData( "text-decoration" ) );
			_propNamesCompletions.addItem( _getCompletionData( "text-align" ) );
			_propNamesCompletions.addItem( _getCompletionData( "font-weight" ) );
			_propNamesCompletions.addItem( _getCompletionData( "font-style" ) );
			_propNamesCompletions.addItem( _getCompletionData( "font-family" ) );
			_propNamesCompletions.addItem( _getCompletionData( "display" ) ); 
			_propNamesCompletions.addItem( _getCompletionData( "font-size" ) ); 
			_propNamesCompletions.addItem( _getCompletionData( "kerning" ) );
			_propNamesCompletions.addItem( _getCompletionData( "leading" ) );
			_propNamesCompletions.addItem( _getCompletionData( "letter-spacing" ) );
			_propNamesCompletions.addItem( _getCompletionData( "margin-left" ) );
			_propNamesCompletions.addItem( _getCompletionData( "margin-right" ) );
			_propNamesCompletions.addItem( _getCompletionData( "text-indent" ) );
			
			
			return true;
		}
		
		
		
		private static const _isinit : Boolean = _init();

		private static var _propNamesCompletions : CompletionProvider;
		
		private static function _getCompletionData( str : String ) : CompletionData {
			var cdata : CompletionData = new CompletionData( );
			cdata.label = cdata.completion = str;
			cdata.refString = str.toLowerCase();
			return cdata;
		}
	}
}
