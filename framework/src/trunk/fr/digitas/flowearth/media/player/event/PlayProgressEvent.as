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

	
	/**
	 * Dispatché par le MediaPlayer, lors de la progression d'un media
	 * @author Pierre Lepers
	 */
	public class PlayProgressEvent extends Event {
		
		
		public function get position() : Number {
			return _position;	
		}
		public function get duration() : Number {
			return _duration;	
		}
		
		
		public function PlayProgressEvent(type : String, position : Number, duration : Number) {
			super( type );
			_position = position;
			_duration = duration;
		}

		public override function clone() : Event {
			return new PlayProgressEvent( type, _position, _duration );
		}

		private var _position : Number;
		private var _duration : Number;
		
	}
}
