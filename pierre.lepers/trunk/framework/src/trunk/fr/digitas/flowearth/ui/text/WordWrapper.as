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
	import flash.text.TextField;
	import flash.text.TextRun;	

	/**
	 * Tool for substr the text of a html formated textfield
	 * @author Pierre Lepers
	 */
	final public class WordWrapper {
		
		public function get htmlText() : String {
			return _htmlText;
		}
		
		public function set htmlText(htmlText : String) : void {
			_tf.htmlText = _htmlText = htmlText;
			_text = _tf.text;
			_txtLen = _tf.length;
			_compile();
			_update( );
		}
		
		
		public function WordWrapper( tf : TextField ) {
			_tf = tf;
			htmlText = _tf.htmlText;
		}

		public function crop( index : int = -1 ) : void {
			_index = index;
			_update();
		}
		
		private function _compile() : void {
			_aRuns = _tf.getTextRuns();
		}

		private function _update() : void {
			
			_tf.text = _text.substr( 0 , _index );
			
			var l : int = _aRuns.length;
			var run : TextRun;
			for (var i : int = 0; i < l; i++) {
				run = _aRuns[ i ] as TextRun;
				if( run.endIndex >= _index ) {
					_tf.setTextFormat( run.textFormat , run.beginIndex , _index );
					break;
				}
				_tf.setTextFormat( run.textFormat , run.beginIndex , run.endIndex );
			}
		}

		private var _tf : TextField;

		private var _htmlText : String;
		
		private var _text : String;

		private var _txtLen : int;
		
		private var _aRuns : Array;

		private var _index : int = -1;
	}
}
