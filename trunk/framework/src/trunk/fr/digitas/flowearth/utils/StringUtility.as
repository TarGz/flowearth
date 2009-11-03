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


package fr.digitas.flowearth.utils {
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;	

	/**
	* Static class containing string utilities.
	*/
	public class StringUtility {
		
	
		
		/**
		* Duplicates a given string for the amount of given times.
		* @param str String to duplicate.
		* @paran Amount of time to duplicate.
		*/
		public static function multiply(str : String, n : Number):String {
			var ret:String = "";
			for(var i:Number=0;i<n;i++) ret += str;
			return ret;
		}
		
	
		public static function StringToURLRequest(p : String) : URLRequest {
			var split : Array = p.split("?");
			var request:URLRequest = new URLRequest(split[0]);
			request.method = URLRequestMethod.POST;
			try{
				if( split[1] ) request.data = new URLVariables(split[1]);
			}catch( e : Error ) {}
			return request;
		}
		
		/**
		 * renvoi la chaine passé en parametre avec la premiere lettre en majuscule.
		 */
		public static function upperFirstLetter(str : String ) : String {
			str = str.charAt(0).toUpperCase() + str.slice(1);
			return str;
		}
		
		/**
		 * renvoi la chaine passé en parametre sans les tag html.
		 */
		public static function cleanHtmlTags( str : String ) : String 
		{
			var tf : TextField = new TextField();
			tf.htmlText = str;

			return tf.text;
		}
		
		
	}

}