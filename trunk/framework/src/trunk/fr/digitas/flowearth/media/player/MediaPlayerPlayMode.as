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

package fr.digitas.flowearth.media.player 
{

	/**
	 * permet de definir le mode de lecture des MediaPlayers
	 * 
	 * @author Brice d'Annoville
	 */

	public class MediaPlayerPlayMode 
	{
		/**
		 * autoplay = false , autorewind = false , loop = false
		 */
		public static var NONE : String = "none";

		/**
		 * autoplay = true , autorewind = false , loop = false
		 */
		public static var AUTOPLAY : String = "autoplay";

		/**
		 * autoplay = false , autorewind = true , loop = false
		 */
		public static var LOOP : String = "loop";

		/**
		 * autoplay = true , autorewind = true , loop = false
		 */
		public static var AUTOPLAY_AUTOREWIND : String = "autoplay_autorewind";

		/**
		 * autoplay = true , autorewind = false , loop = true
		 */
		public static var AUTOPLAY_LOOP : String = "autoplay_loop";

		/**
		 * autoplay = false , autorewind = true , loop = false
		 */
		public static var AUTOREWIND : String = "autorewind";

		
	}
}
