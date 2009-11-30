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
	import fr.digitas.flowearth.mvc.address.structs.INode;
	
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class NodeEvent extends FlowEvent {
		
		public static const PATH_CHANGE 	: String = "_pathChange";

		public static const CHANGE 			: String = "_nodeChange";

		public static const PARAM_CHANGE 	: String = "_nodeParamChange";

		public static const ADDED 			: String = "_nodeAdded";

		public static const CHILD_CHANGE 	: String = "_child_nodeChange";

		public static const CHILD_ADDED 	: String = "_child_nodeAdded";

		public static const DEFAULT_CHANGE 	: String = "_defaultChange";


		override public function get target() : Object {
			return _ntarget;
		}

		public function get nodeTarget() : INode {
			return _ntarget;
		}

		public function get nodeCurrentTarget() : INode {
			return currentTarget as INode;
		}

		public function NodeEvent( type : String, target : INode, capureFlow : Boolean = false ) {
			_ntarget = target;
			super( type , false, false, capureFlow );
		}

		override public function clone() : Event {
			var c : NodeEvent = new NodeEvent( _nativeType, _ntarget, _capureFlow );
			return c;
		}

		private var _ntarget : INode;
		
	}
}
