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


package fr.digitas.flowearth.event {
	import flash.events.Event;					

	/**
	 * Event containing uint value;
	 * @author Pierre Lepers
	 */
	final public class UintEvent extends Event {
		
		public function get value() : uint {
			return _value;	
		}
		
		public function UintEvent(type : String, value : uint, bubble : Boolean = false, cancelable : Boolean = false) {
			super( type, bubble, cancelable );
			_value = value;
		}

		override public function clone() : Event {
			return new UintEvent( type, _value, bubbles, cancelable );
		}

		private var _value : uint;
	}
}
