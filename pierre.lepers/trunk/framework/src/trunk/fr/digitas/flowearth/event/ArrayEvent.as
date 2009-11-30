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
	 * Event contenant un parametre Array
	 * 
	 * @author Pierre Lepers
	 */
	final public class ArrayEvent extends Event {
		
		public function get array() : Array {
			return _array;	
		}
		
		public function ArrayEvent (type : String, array : Array , bubble : Boolean = false, cancelable : Boolean = false) {
			super( type, bubble, cancelable );
			_array = array;
		}

		override public function clone() : Event {
			return new ArrayEvent( type, _array, bubbles, cancelable );
		}

		
		private var _array : Array;
	}
}
