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
	import flash.events.Event;
	
	import fr.digitas.flowearth.media.player.metadata.Metadata;	

	
	/**
	 * @author Pierre Lepers
	 */
	public class MetaDataEvent extends Event {
		
		public function get metadata() : Metadata {
			return _metadata;	
		}
		
		public function MetaDataEvent(type : String, metaData : Metadata, cancelable : Boolean = false ) {
			super( type , false, cancelable );
			_metadata = metaData;
		}

		public override function clone() : Event {
			return new MetaDataEvent( type, _metadata, cancelable );
		}

		private var _metadata : Metadata;
	}
}
