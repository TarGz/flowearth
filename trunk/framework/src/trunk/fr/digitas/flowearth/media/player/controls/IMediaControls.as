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

package fr.digitas.flowearth.media.player.controls {
	import flash.events.IEventDispatcher;
	
	import fr.digitas.flowearth.media.player.MediaPlayer;	

	
	/**
	 * Interface a implementer pour tout objet passé a MediaPlayer.controls 
	 * @author Pierre Lepers
	 */
	public interface IMediaControls extends IEventDispatcher {
		
		
		function playing( flag : Boolean ) : void;
		
		function seek( val : Number ) : void;
		
		function setVolume( val : Number ) : void;
		
		/**
		 * permet au controls de connaitre le player est d'etre syncro avec lui
		 */
		function registerPlayer( player : MediaPlayer ) : void;
		
	}
}
