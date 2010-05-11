/* ***** BEGIN LICENSE BLOCK *****
 * Copyright (C) 2007-2009 Digitas France
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * The Initial Developer of the Original Code is
 * Digitas France Flash Team
 *
 * Contributor(s):
 *   Digitas France Flash Team
 *
 * ***** END LICENSE BLOCK ***** */

package fr.digitas.flowearth.text.styles {
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	final public class TypeMapper {


		public static function transtype( prop : String, value : String ) : TypeMapping {
			var mdata : MapData = _map[ prop ];
			if( mdata )
				return mdata.getMapping( value );
			return null;
		}
		
		
		private static var _isinit : Boolean = _init();
		
		private static function _init() : Boolean {
			
			
			_map = new Dictionary();
			
			trace( _int_transtyper );
			trace( _int_transtyper( "2000" ) );
			trace( _map );
			trace( MapData );
			trace( TypeMapping );
			trace( TypeMapping.STYLESHEET );
			trace( new MapData( TypeMapping.STYLESHEET, _int_transtyper ) );


			//_____________________________________________________________________________
			//																	 STYLESHEET
			
			// INT
			_map[ "maxChars" ] =
			_map[ "scrollH" ] =
			_map[ "scrollV" ] =
			_map[ "tabIndex" ] = new MapData( TypeMapping.STYLESHEET, _int_transtyper );
			
			// UINT
			_map[ "borderColor" ] =
			_map[ "textColor" ] = new MapData( TypeMapping.STYLESHEET, _uint_transtyper );
			//_map[ "backgroundColor" ] = 
				
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
			_map[ "y" ] = new MapData( TypeMapping.STYLESHEET, _number_transtyper );
			
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
			_map[ "wordWrap" ] = new MapData( TypeMapping.STYLESHEET, _boolean_transtyper );
				
			// STRING
			_map[ "antiAliasType" ] =
			_map[ "autoSize" ] =
			_map[ "blendMode" ] =
			_map[ "gridFitType" ] =
			_map[ "htmlText" ] =
			_map[ "name" ] =
			_map[ "restrict" ] =
			_map[ "text" ] =
			_map[ "type" ] = new MapData( TypeMapping.STYLESHEET, _string_transtyper );
			
			_map[ "backgroundColor" ] = new MapData( TypeMapping.TLF_FORMAT | TypeMapping.STYLESHEET, _uint_transtyper );
			
			
			/*-FP10*/

			//_____________________________________________________________________________
			//																	 TLF_CONFIG
			
			if( tlfFactory.hasSupport() ) {
			
			//BOOL
			_map["enableAccessibility"] = 
			_map["manageEnterKey"] = 
			_map["manageTabKey"] = 
			_map["releaseLineCreationData"] = new MapData( TypeMapping.TLF_CONFIG, _boolean_transtyper );
			
			//STRING
			_map["overflowPolicy"] = new MapData( TypeMapping.TLF_CONFIG, _string_transtyper );
			
			//NUMBER
			_map["scrollDragDelay"] = 
			_map["scrollDragPixels"] = 
			_map["scrollMouseWheelMultiplier"] = 
			_map["scrollPagePercentage"] = new MapData( TypeMapping.TLF_CONFIG, _number_transtyper );
			
			
			//_____________________________________________________________________________
			//																	 TLF_FORMAT

			
			_map[ "alignmentBaseline" ] =
			_map[ "backgroundAlpha" ] =
			_map[ "baselineShift" ] =
			_map[ "blockProgression" ] =
			_map[ "breakOpportunity" ] =
			_map[ "cffHinting" ] =
			_map[ "color" ] =
			_map[ "columnCount" ] =
			_map[ "columnGap" ] =
			_map[ "columnWidth" ] =
			_map[ "digitCase" ] =
			_map[ "digitWidth" ] =
			_map[ "direction" ] =
			_map[ "dominantBaseline" ] =
			_map[ "firstBaselineOffset" ] =
			_map[ "fontFamily" ] =
			_map[ "fontLookup" ] =
			_map[ "fontSize" ] =
			_map[ "fontStyle" ] =
			_map[ "fontWeight" ] =
			_map[ "justificationRule" ] =
			_map[ "justificationStyle" ] =
			_map[ "kerning" ] =
			_map[ "leadingModel" ] =
			_map[ "ligatureLevel" ] =
			_map[ "lineBreak" ] =
			_map[ "lineHeight" ] =
			_map[ "lineThrough" ] =
			_map[ "locale" ] =
			_map[ "paddingBottom" ] =
			_map[ "paddingLeft" ] =
			_map[ "paddingRight" ] =
			_map[ "paddingTop" ] =
			_map[ "paragraphEndIndent" ] =
			_map[ "paragraphSpaceAfter" ] =
			_map[ "paragraphSpaceBefore" ] =
			_map[ "paragraphStartIndent" ] =
			_map[ "renderingMode" ] =
			_map[ "tabStops" ] =
			_map[ "textAlign" ] =
			_map[ "textAlignLast" ] =
			_map[ "textAlpha" ] =
			_map[ "textDecoration" ] =
			_map[ "textIndent" ] =
			_map[ "textJustify" ] =
			_map[ "textRotation" ] =
			_map[ "trackingLeft" ] =
			_map[ "trackingRight" ] =
			_map[ "typographicCase" ] =
			_map[ "verticalAlign" ] =
			_map[ "whiteSpaceCollapse" ] = new MapData( TypeMapping.TLF_FORMAT, _string_transtyper );
			
			}
			
			/*FP10-*/
			
			
			
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
		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		public static var _map : Dictionary;
		
	}
}
