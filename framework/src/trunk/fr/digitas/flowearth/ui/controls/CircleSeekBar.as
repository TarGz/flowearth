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
	import flash.events.ProgressEvent;
	import fr.digitas.flowearth.event.NumberEvent;
	

	
	/**
	 * @author Pierre Lepers
	 * 
	 * TODO implementer un cursor pour CircleSeekBar
	 */
	public class CircleSeekBar extends SeekBar {

		
		public function CircleSeekBar() {
			super( );
			if( loading ) {
				if( loading is CircleLoadbar ) circleLoading = loading as CircleLoadbar;
				else throw new Error( "bi.ui.CircleSeekBar -  le clip 'loading' doit etendre CircleLoadbar" );
			}
			if( progress ) {
				if( progress is CircleLoadbar ) circleProgress = progress as CircleLoadbar;
				else throw new Error( "bi.ui.CircleSeekBar -  le clip 'progress' doit etendre CircleLoadbar" );
			}
		}

		override protected function update( e : NumberEvent ) : void {
			Logger.log( "bi.ui.CircleSeekBar - update -- " );
			var pcent : Number = (value - min) / ( max - min );
			if( circleProgress ) {
				Logger.log( "bi.ui.CircleSeekBar - update -- " );
				circleProgress.handleProgress( new ProgressEvent("", false, false, Math.round(pcent * 1000) , 1000) );
			
			}
		}
		
		override protected function updateLoad() : void {
			if( circleLoading ) 
				circleLoading.handleProgress( new ProgressEvent("", false, false, Math.round(_loadProgress * 1000) , 1000) );
		}
		
		override protected function change() : void {
			var a : Number = Math.atan2( -mouseX , mouseY ) + Math.PI;
			var pcent:Number = a / (Math.PI * 2 );
			pcent = Math.min( 1, Math.max( 0, pcent ) );
			value = pcent * ( max - min ) + min;
		}

		private var circleProgress 	: CircleLoadbar;
		private var circleLoading 	: CircleLoadbar;
		
		
	}
}
