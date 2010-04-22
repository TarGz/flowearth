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
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Pile;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextLineMetrics;	

	/**
	 * Version Beta ( un peu a l'arrache )
	 * 
	 * 
	 * 
	 * @author Pierre Lepers
	 */
	public class TextFieldGroup extends Sprite {

		
		
		public function set text ( str : String ) : void {
			if( _text == str || str == null ) return;
			_text = str;
			refill( );
		}

		public function get text ( ) : String {
			return _text;
		}
		

		public function TextFieldGroup () {
			_fields = new Pile( );
		}

		
		//______________________________________________________________
		//												 Implemente Pile

		public function addField ( tf : TextField ) : void {
			_fields.addItem( tf );
		}

		public function addFieldAt ( tf : TextField, index : uint ) : void {
			_fields.addItemAt( tf, index );
		}

		public function getFieldAt ( index : uint ) : void {
			_fields.getItemAt( index );
		}

		//_____________________________________________________________________________
		//																		PRIVATES

		private function refill () : void {
			var iterator : IIterator = _fields.getIterator( );
			var tf : TextField;
			
			var remainder : String = _text;
			var fieldText : String = "";
			
			preferredHeight = this.getOptimalHeight( _text );
			
			while( iterator.hasNext( ) ) {
				tf = iterator.next( ) as TextField;
				tf.height = preferredHeight;
				tf.htmlText = remainder ;
        
				remainder = "";
				fieldText = "";
        
				var linesRemaining : int = tf.numLines;
				var linesVisible : int = tf.numLines - tf.maxScrollV + 1;
				for (var j : int = 0; j < linesRemaining ; j ++) {
					if (j < linesVisible) {
						fieldText += tf.getLineText( j );
					} else {
						remainder += tf.getLineText( j );
					}
				}
        
				tf.htmlText = fieldText ;
			}
		}

		private function getOptimalHeight ( str : String ) : Number {
			if ( _fields.length == 0 || str == "" || str == null) {
				return preferredHeight;
			}
			else {
				var field : TextField = _fields.getItemAt(0) as TextField;
				
				field.htmlText = str;

				var linesPerCol : int = Math.ceil( field.numLines / this._fields.length );
				var metrics : TextLineMetrics = field.getLineMetrics( 0 );
				var prefHeight : Number = linesPerCol * metrics.height;
				return prefHeight + 4;
			}
		}

		
		private var _fields : Pile;
		private var _text : String;
		private var preferredHeight : Number = 40;
	}
}
