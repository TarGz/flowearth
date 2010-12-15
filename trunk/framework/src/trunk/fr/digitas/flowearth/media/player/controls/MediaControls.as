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
	import flash.display.MovieClip;
	import flash.events.TextEvent;
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.event.NumberEvent;
	
	import fr.digitas.flowearth.media.player.MediaPlayer;	

	
	/**
	 * Implementation de base de IMediaControls, ne gere pas les composant de control ( boutons et slider ) -> voir BasicControls 
	 * @see BasicControls
	 * @author Pierre Lepers
	 */
	public class MediaControls 	extends MovieClip implements IMediaControls {
		
		
		
		
		public function MediaControls() {
			
		}		
		
		public function playing( flag : Boolean ) : void {
			dispatchEvent( new BoolEvent( MediaPlayer.PLAY, flag ) );
		}
		
		public function seek(val : Number) : void {
			dispatchEvent( new NumberEvent( MediaPlayer.SEEK, val ) );
		}
		
		public function setVolume(val : Number) : void {
			dispatchEvent( new NumberEvent( MediaPlayer.VOLUME, val ) );
		}		
		
		public function registerPlayer(player : MediaPlayer) : void {
			//  controls abstrait , pas de vues a mettre a jours
		}
		
		public function stageChangeMode ( ) : void {
			dispatchEvent( new TextEvent( MediaPlayer.STAGE_MODE, false, false, stage.displayState) );
		}
	}
}
