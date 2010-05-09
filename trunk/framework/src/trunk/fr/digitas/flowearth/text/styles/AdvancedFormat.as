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
	/*FDT_IGNORE*/
	/*-FP10*/
	import flashx.textLayout.elements.IConfiguration;
	import flashx.textLayout.formats.ITextLayoutFormat;
	/*FP10-*/ 
	/*FDT_IGNORE*/

	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author Pierre Lepers
	 */
	public class AdvancedFormat {

		
		public function format( tf : TextField ) : void {
			_formatter.format( tf );
			tf.defaultTextFormat = _format;
			tf.setTextFormat( _format );
		}

		
		internal function parseObject( obj : Object ) : void {
			_format = new FormatFactory( obj ).format( );
			_formatter = new Formatter( obj );
			_obj = obj;
		}

		internal function getFormatter() : Formatter {
			return _formatter;	
		}

		public function getObject() : Object {
			return _obj;
		}


		/*FDT_IGNORE*/
		/*-FP10*/
		public function getTlfConfig () : IConfiguration {
			return _formatter.tlfConfig;
		}

		public function getTlfFormat () : ITextLayoutFormat {
			return _formatter.tlformat;
		}
		/*FP10-*/
		/*FDT_IGNORE*/
		

		private var _obj : Object;

		private var _format : TextFormat;
		private var _formatter : Formatter;
	}
}
/*FDT_IGNORE*/
/*-FP10*/
import flashx.textLayout.elements.Configuration;
import flashx.textLayout.elements.IConfiguration;
import flashx.textLayout.formats.ITextLayoutFormat;
import flashx.textLayout.formats.TextLayoutFormat;
/*FP10-*/
/*FDT_IGNORE*/

import fr.digitas.flowearth.text.styles.TypeMapper;
import fr.digitas.flowearth.text.styles.TypeMapping;

import flash.text.StyleSheet;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Dictionary;

//_____________________________________________________________________________
//																 FORMAT FACTORY
//
//		FFFFFF  OOOO  RRRRR   MM   MM   AAA   TTTTTT         FFFFFF   AAA    CCCCC  TTTTTT  OOOO  RRRRR   YY  YY  
//		FF     OO  OO RR  RR  MMM MMM  AAAAA    TT           FF      AAAAA  CC   CC   TT   OO  OO RR  RR   YYYY   
//		FFFF   OO  OO RRRRR   MMMMMMM AA   AA   TT           FFFF   AA   AA CC        TT   OO  OO RRRRR     YY    
//		FF     OO  OO RR  RR  MM M MM AAAAAAA   TT           FF     AAAAAAA CC   CC   TT   OO  OO RR  RR    YY    
//		FF      OOOO  RR   RR MM   MM AA   AA   TT           FF     AA   AA  CCCCC    TT    OOOO  RR   RR   YY



final class FormatFactory extends StyleSheet {

	
	
	private var _obj : Object;

	public function FormatFactory( obj : Object ) {
		_obj = obj;
	}

	public function format() : TextFormat {
		return transform( _obj );
	}
}

//_____________________________________________________________________________
//																 	  FORMATTER
//
//		FFFFFF  OOOO  RRRRR   MM   MM   AAA   TTTTTT TTTTTT EEEEEEE RRRRR   
//		FF     OO  OO RR  RR  MMM MMM  AAAAA    TT     TT   EE      RR  RR  
//		FFFF   OO  OO RRRRR   MMMMMMM AA   AA   TT     TT   EEEE    RRRRR   
//		FF     OO  OO RR  RR  MM M MM AAAAAAA   TT     TT   EE      RR  RR  
//		FF      OOOO  RR   RR MM   MM AA   AA   TT     TT   EEEEEEE RR   RR 



final class Formatter {


	public function Formatter( obj : Object ) {
		_props = new Dictionary( );
		_tfp =  new Array();
		/*FDT_IGNORE*//*-FP10*/
		tlfConfig = new Configuration( );
		tlformat = new TextLayoutFormat( );
		/*FP10-*//*FDT_IGNORE*/
		_compileProps( obj );
	}

	public function format( tf : TextField) : void {
		if( ! tf )
			throw new Error( "com.nissan.core.styles.Style - format() textfield parameters cannot be null" );
		var  l : int = _tfp.length;
		var pname : String;
		while( -- l > - 1 ) {
			pname = _tfp[l];
			tf[ pname ] = _props[pname];
		}
	}

	private function _compileProps(obj : Object) : void {
		var pname : String;
		var tmapping : TypeMapping;
		
		for( pname in obj ) {
			tmapping = TypeMapper.transtype( pname , obj[ pname ] );
			if( tmapping != null ) {
				
				/*-FP9
				_props[ pname ] = tmapping.value;
				_tfp.push( pname );
				FP9-*/
				 
				
				/*FDT_IGNORE*//*-FP10*/
				if( tmapping.handleStyleSheet() ) {
					_props[ pname ] = tmapping.value;
					_tfp.push( pname );
				}
				if( tmapping.handleTlfConfig() )
					tlfConfig[ pname ] = tmapping.value;
				else if( tmapping.handleTlfFormat() )
					tlformat[ pname ] = tmapping.value;
				/*FP10-*//*FDT_IGNORE*/
				
			}
			
			
		}
	}

	private var _tfp : Array;
	
	private var _props : Dictionary;
	/*FDT_IGNORE*/
	/*-FP10*/
	internal var tlfConfig : IConfiguration;
	internal var tlformat : ITextLayoutFormat;
	/*FP10-*/
	/*FDT_IGNORE*/
}
