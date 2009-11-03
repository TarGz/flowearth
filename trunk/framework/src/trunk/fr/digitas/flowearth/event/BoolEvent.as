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

package fr.digitas.flowearth.event {	import flash.events.Event;					
	/**	 * Event contenant un Boolean	 * 	 * @author Pierre Lepers	 */	final public class BoolEvent extends Event {		
		
		public function get flag() : Boolean {
			return _flag;	
		}
		
		public function BoolEvent (type : String, flag : Boolean, bubble : Boolean = false, cancelable : Boolean = false) {
			super(type, bubble, cancelable );
			_flag = flag;		}
		override public function clone() : Event {
			return new BoolEvent( type, _flag, bubbles, cancelable );
		}

		private var _flag : Boolean;
			}}