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

package fr.digitas.flowearth.media.player.cuePoint {

	/**
	 * @author duquesneo
	 */
	public class CuePointData {
		
		public var name : String;
		public var parameters : Array;
		public var time : Number;
		
		
		public function CuePointData( infoObject : Object ) {
			name = infoObject.name;
			parameters = infoObject.parameters;
			time = infoObject.time;
		}
		
		public function toString() : String {
			var res : String = "";
			res += "name --> " 			+ name 			+ "\n";
			res += "parameters --> "	+ parameters	+ "\n";
			res += "time --> " 			+ time 			+ "\n";
			return res;
		}
		
	}
}
