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

package fr.digitas.flowearth.media.player.caption.data {
	import fr.digitas.flowearth.media.player.caption.data.ICaptionParser;		

	
	/**
	 * parse des sous titre au format srt
	 * 
	 * @author Pierre Lepers
	 */
	public class SRTParser implements ICaptionParser {

		
		public function parse ( datas : * ) : CaptionProvider {
			return new CaptionProvider( _parse( datas ) );
		}

		private function _parse ( p_data : String ) : Array {
			trace( "srt 1" );
			
			trace( p_data );
			var lc : String;
			while( (lc = p_data.substring( p_data.length- 1 ) ) == "\n" || lc == "\r"  )
				p_data = p_data.substring( 0, p_data.length-1 );

			trace( p_data );
				
			var captions : Array = new Array();
			var subtitles : Array = p_data.split( "\n\r\n" );
			
			//subtitles.pop( );
			captions = subtitles.map( parse_row );       
			return captions;
		}

		private function parse_row ( row : String, ind : int, arr : Array ) : CaptionData {
			trace( "bi.media.player.caption.data.SRTParser - parse_row -- " );
			trace( row );
			var data : CaptionData = new CaptionData();
			var rows : Array = row.split( "\r\n" );

			data.id = rows.shift();
			var time : Array = rows.shift().split( " --> ");
                                
			data.htmlData = rows.join( "\n" );
			data.beginTimeMilliSecond = convertToNumber( time[0] );
			data.endTimeMilliSecond = convertToNumber( time[1] );
                                
			return data;
		}
		
		private function convertToNumber (inString : String) : Number { 
			var hour 	: int 	= parseInt( inString.substr( 0, 2 ) );
			var min 	: int 	= parseInt( inString.substr( 3, 2 ) );
			var sec 	: int 	= parseInt( inString.substr( 6, 2 ) );
			var milli 	: int 	= parseInt( inString.substr( 9, 3 ) );
			
			var res : Number = (hour * 3600000) + (60000 * min) + (sec * 1000) + milli;

			return res;
		}
		
	}
}
