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

	final public class XmlEvent extends Event{
		public static const ON_DATA : String = "on_data";
		public static const ON_PROGRESS : String = "on_progress";

		private var _xml:XML;
		
		public function get xml() : XML {
			return _xml;
		}

		public function XmlEvent(type:String, datas:XML , bubble : Boolean = false, cancelable : Boolean = false) {
			super( type, bubble, cancelable );
			_xml = datas;
		}

		override public function clone() : Event {
			return new XmlEvent( type, _xml, bubbles, cancelable );
		}
	}
}