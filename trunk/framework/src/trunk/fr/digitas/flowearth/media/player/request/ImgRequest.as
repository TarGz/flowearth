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

package fr.digitas.flowearth.media.player.request {
	import fr.digitas.flowearth.media.player.loader.ImgLoader;
	import fr.digitas.flowearth.media.player.request.MediaRequest;	

	
	/**
	 * @author Pierre Lepers
	 */
	public class ImgRequest extends MediaRequest {
		
		/**
		 * Construit une requete pour lire un flv sur MediaPlayer
		 * new FlvRequest(url : *, checkPolicyFile : Boolean );
		 * @param url : l'url du flv
		 * @param args : -1 - checkPolicyFile : Boolean
		 * @param args : -2 - smooth : Boolean default true
		 */
		public function ImgRequest(url : *, ...args) {
			super( url, args );
			loaderClass = ImgLoader;
			if( args ){
				var l : int = args.length;
				if( l > 0 ) checkPolicyFile = args[0]; 	
				if( l > 1 ) smooth = args[1]; 	
			}
		}
		
		public var smooth : Boolean = true;
		
	}
}
