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
	import flash.events.EventPhase;	

	/**
	 * @author Pierre Lepers
	 */
	public class FlowEvent extends Event {

		
		public function get nativeType() : String {
			return _nativeType;
		}
		
		public function get capureFlow() : Boolean {
			return _capureFlow;
		}

		override public function get eventPhase() : uint {
			return _capureFlow ? EventPhase.CAPTURING_PHASE : ( target == currentTarget ? EventPhase.AT_TARGET : EventPhase.BUBBLING_PHASE);
		}

		public function FlowEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false, capureFlow : Boolean = false ) {
			_nativeType = type;
			if( capureFlow ) type = FlowEventDispatcher.CAPTURE_PREFIX + _nativeType;
			_capureFlow = capureFlow;
			super( type , bubbles , cancelable );
		}

		override public function clone() : Event {
			var c : FlowEvent = new FlowEvent( type, bubbles, cancelable );
			return c;
		}
		
		protected var _nativeType : String;

		protected var _capureFlow : Boolean;
	}
}
