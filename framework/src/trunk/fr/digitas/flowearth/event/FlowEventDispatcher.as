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
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;	

	/**
	 * EventDispatch support dispatch in capture flow, using a prefix in eventTypes
	 * 
	 * @author Pierre Lepers
	 */
	public class FlowEventDispatcher extends EventDispatcher {

		public static const CAPTURE_PREFIX : String = "__ucf__";

		public function FlowEventDispatcher(target : IEventDispatcher = null) {
			super( target );
		}
		
		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			if( useCapture ) type = CAPTURE_PREFIX + type;
			super.addEventListener( type , listener , false , priority , useWeakReference );
		}

		override public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false ) : void {
			if( useCapture ) type = CAPTURE_PREFIX + type;
			super.removeEventListener( type , listener , false  );
		}

		override public function hasEventListener(type : String) : Boolean {
			return ( super.hasEventListener( type ) || super.hasEventListener( CAPTURE_PREFIX + type ) );
		}

		
	}
}
