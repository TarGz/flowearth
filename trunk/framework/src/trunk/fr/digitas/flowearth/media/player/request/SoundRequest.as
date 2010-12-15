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

package fr.digitas.flowearth.media.player.request 
{
	import fr.digitas.flowearth.media.player.loader.SoundLoader;
	import fr.digitas.flowearth.media.player.request.MediaRequest;
	import flash.media.Sound;
	
	/**
	 * Request for play a sound in <code>MediaPlayer</code>
	 * @author Romain Prache
	 */
	public class SoundRequest extends MediaRequest
	{
		
		/* Sound Request */
		public function SoundRequest( url : String, ...args ) 
		{
			super( url, args);
			loaderClass = SoundLoader;
			if( args ){
				var l : int = args.length;
				if( l > 0 ) checkPolicyFile = args[0]; 	
			}
		}
		
	}

}