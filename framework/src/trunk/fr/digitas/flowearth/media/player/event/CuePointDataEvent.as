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

package fr.digitas.flowearth.media.player.event {
	import fr.digitas.flowearth.media.player.cuePoint.CuePointData;	
	
	import flash.events.Event;
	
	/**
	 * @author duquesneo
	 */
	public class CuePointDataEvent extends Event {
		
		public function get cuePoint() : CuePointData {
			return _cuePoint;	
		}
		
		
		public function CuePointDataEvent(type : String, cuepoint : CuePointData, cancelable : Boolean = false) {
			super(type, false, cancelable);
			_cuePoint = cuepoint;
		}
		public override function clone() : Event {
			return new CuePointDataEvent( type, _cuePoint, cancelable );
		}
		
		
		
		private var _cuePoint : CuePointData;
	}
}
