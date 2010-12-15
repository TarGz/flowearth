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
	import flash.net.URLRequest;			

	
	/**
	 * Classe de base a des objets passés a MediaPlayer.load();
	 * 
	 * MediaPlayer peut lire plusieur type de media, a chaque type, sa MediaRequest specifique
	 * 
	 * @example
	 * <pre>
	 * var flvReq : FlvRequest = new FlvRequest( "flv/mavideo.flv" );
	 * mediaPlayer.load( flvReq );
	 * 
	 * var swfReq : SwfRequest = new SwfRequest( "swf/anim.swf" );
	 * mediaPlayer.load( swfReq );
	 * </pre>
	 * 
	 * @author Pierre Lepers
	 */
	public class MediaRequest {
		
		public var loaderClass : Class;
		
		/**
		 * requete generique pour le player
		 * @param url : String ou URLRequest.
		 */
		public function MediaRequest( url : *, ...args ) {
			if( url is URLRequest ) _urlRequest = url as URLRequest;
			else _urlRequest = new URLRequest( String( url ) );
		}
		
		/**
		 * request du media a jouer
		 */
		public function get urlRequest() : URLRequest {
			return _urlRequest;	
		}
		
		public function get checkPolicyFile () : Boolean {
			return _checkPolicyFile;
		}
		
		public function set checkPolicyFile (checkPolicyFile : Boolean) : void {
			_checkPolicyFile = checkPolicyFile;
		}

		public function toString() : String {
			return "[bi.media.player.request.MediaRequest] url :" + _urlRequest.url;
		}
		
		protected var _checkPolicyFile : Boolean = false;
		
		private var _urlRequest : URLRequest;
		
	}
}
