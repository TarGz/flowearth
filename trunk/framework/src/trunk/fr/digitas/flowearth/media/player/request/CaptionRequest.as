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
	
	import fr.digitas.flowearth.media.player.request.MediaRequest;		

	
	/**
	 * Ajoute une url de soustitre a une <code>MediaRequest</code>
	 * 
	 * exple :
	 * <pre>
	 * 	var flvReq : FlvRequest = new FlvRequest( "maVideo.flv" );
	 * 	var req : MediaRequest = new CaptionRequest( flvRequest, "mesSoustitre.srt" );
	 * 	
	 * 	player.load( req );
	 * </pre>
	 * 
	 * @author Pierre Lepers
	 */
	public class CaptionRequest extends MediaRequest {

		

		
		public function CaptionRequest ( baseRequest : MediaRequest, captionUrl : * ) {
			this.baseRequest = baseRequest;
			super( baseRequest.urlRequest );
			loaderClass = baseRequest.loaderClass;
			
			if( captionUrl is URLRequest ) _captionReq = captionUrl as URLRequest;
			else _captionReq = new URLRequest( String( captionUrl ) );
		}
		

		public function get captionReq () : URLRequest {
			return _captionReq;
		}
		
		override public function get checkPolicyFile () : Boolean {
			return baseRequest.checkPolicyFile;
		}
		
		private var _captionReq : URLRequest;
		private var baseRequest : MediaRequest;
		
	}
}
