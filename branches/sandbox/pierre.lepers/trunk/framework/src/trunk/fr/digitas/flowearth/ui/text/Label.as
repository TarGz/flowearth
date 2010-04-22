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


package fr.digitas.flowearth.ui.text {
	import flash.display.MovieClip;
	import flash.text.TextField;	

	/**
	 * Simple clip contenant un TextField nommé 'tf'
	 * @author Pierre Lepers
	 */
	public class Label extends MovieClip {
		
		public var tf : TextField;
		
		public function set htmlText( str : String ) : void {
			_isHtml = true;
			tf.htmlText = str;	
		}

		public function get htmlText() : String {
			return tf.htmlText;	
		}

		public function set text( str : String ) : void {
			_isHtml = false;
			tf.text = str;	
		}
		
		public function get text() : String {
			return tf.text;	
		}

		public function Label() {
			if( ! tf ) 
				addChild( tf = new TextField() );
		}
		
		protected var _isHtml : Boolean;
		
	}
}
