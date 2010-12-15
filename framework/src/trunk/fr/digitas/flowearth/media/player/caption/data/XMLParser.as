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

	
	/**
	 * Parse des soustitre au format xml
	 * 
	 * @author vanneaup
	 * 
	 * format : 
	 * <pre>
	 * 	<captions>
	 *		<caption id="1" begin="00:00:00,000" end="00:00:02,323"><![CDATA[«Magnifique»…]]></caption> 
	 *		<caption id="2" begin="00:00:03,339" end="00:00:05,610"><![CDATA[It is femininity in all its splendour]]></caption> 
	 *		<caption id="3" begin="00:00:09,290" end="00:00:11,160"><![CDATA[It’s a loving patience]]></caption> 
	 * 	</captions>
	 * </pre>
	 */
	public class XMLParser implements ICaptionParser {

		
		public function XMLParser () {
		}

		
		public function parse ( dataXml : * ) : CaptionProvider {
			
			var captionsXML : XML = XML( dataXml ); 
			var captionsArray : Array = new Array( );
			var list : XMLList = captionsXML.caption;
			
			for each( var captionData : XML in list ) {
				var cd : CaptionData = new CaptionData( );
				
				cd.id = parseInt( captionData.@id );
				cd.beginTimeMilliSecond = convertToNumber( captionData.@begin );
				cd.endTimeMilliSecond = convertToNumber( captionData.@end );
				cd.htmlData = captionData.text( );
				
				captionsArray[(cd.id - 1)] = cd;
			}
			return new CaptionProvider( captionsArray );
		}

		
		private function convertToNumber (inString : String) : Number {
			var milliArray : Array = inString.split( "," );
			var secArray : Array = milliArray[0].split( ":" );
			
			var hour 	: Number 	= Number( secArray[0] );
			var min 	: Number 	= Number( secArray[1] );
			var sec 	: Number 	= Number( secArray[2] );
			var milli 	: Number 	= Number( milliArray[1] );
			
			var res : Number = (hour * 3600000) + (60000 * min) + (sec * 1000) + milli;

			return res;
		}
	}
}
