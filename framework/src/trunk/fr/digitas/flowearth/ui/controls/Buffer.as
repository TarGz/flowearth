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

package fr.digitas.flowearth.ui.controls {
	import flash.display.MovieClip;		

	
	/**
	 * Classe Buffer pour la <code>SeekBar</code>
	 * 
	 * @author Pierre Lepers
	 */
	public class Buffer extends MovieClip {
		
		
		
		public function Buffer() {}
		
		
		public function show() : void {
			gotoAndPlay( SHOW_LBL );
		}

		public function hide() : void {
			gotoAndPlay( HIDE_LBL );
		}
		
		//_____________________________________________________________________________
		//																	   PRIVATES


		private static const SHOW_LBL : String = "show";
		private static const HIDE_LBL : String = "hide";
	}
}
