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
	import fr.digitas.flowearth.media.player.loader.FlvLoader;
	import fr.digitas.flowearth.media.player.request.MediaRequest;	

	
	/**
	 * requete a passer au <code>MediaPlayer</code> pour jouer un flv non streamé
	 * 
	 * @author Pierre Lepers
	 */
	public class FlvRequest extends MediaRequest {
		
		/**
		 * Construit une requete pour lire un flv sur MediaPlayer
		 * new FlvRequest(url : *, checkPolicyFile : Boolean );
		 * @param url : l'url du flv
		 * @param args : -1 - checkPolicyFile : Boolean
		 * @param args : -1 - checkPolicyFile : Boolean
		 */
		public function FlvRequest( url : *, ...args ) {
			super( url, args );
			loaderClass = FlvLoader;
			if( args ){
				var l : int = args.length;
				if( l > 0 ) checkPolicyFile = args[0]; 	
			}
		}
		
		
		
	}
}
