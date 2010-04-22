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


package fr.digitas.flowearth.debug {
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;	

	/**
	 * affiche le fps et la memoire en haut a gauche de l'ecran
	 * @example
	 * 	addChild( new FPS() );
	 */
	public class FPS extends Sprite {

		
		private var fs: int;
		private var ms: int;
		
		public function FPS()
		{
			
			ms = getTimer();
			fs = 0;
			
			addEventListener( Event.ADDED_TO_STAGE, onAdded );	
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
			
			addFramrate();
			addMemory( );
			
			blendMode = BlendMode.DIFFERENCE;
		}

		
		private function addFramrate() : void {
			fpsTf = new TextField();

			var format: TextFormat = new TextFormat();
			
			format.color = 0xFFffff;
			format.bold = true;
			format.size = 10;
			format.font = 'Arial';
			
			fpsTf.textColor = 0xcecece;
			fpsTf.autoSize = "left";
			fpsTf.defaultTextFormat = format;
			fpsTf.selectable = false;
			
			addChild( fpsTf  );
		}
		private function addMemory() : void {
			memTf = new TextField();

			var format: TextFormat = new TextFormat();
			
			format.color = 0xFFffff;
			format.size = 10;
			format.font = 'Arial';
			
			memTf.textColor = 0xcecece;
			memTf.autoSize = "left";
			memTf.defaultTextFormat = format;
			memTf.selectable = false;
			memTf.y = 16;
			
			addChild( memTf );
		}

		private function onAdded( event: Event ): void
		{
			stage.addEventListener( Event.ENTER_FRAME, oef );
		}
		
		private function onRemoved( event: Event ): void
		{
			stage.removeEventListener( Event.ENTER_FRAME, oef );
		}
		
		private function oef( event: Event ): void {
			memTf.text = String( Math.round( System.totalMemory/1000 ))+" Ko";
			if( getTimer() - 1000 > ms )
			{
				ms = getTimer();
				fpsTf.text = fs.toString();
				fs = 0;
			}
			else
			{
				++fs;
			}
		}
		
		private var fpsTf : TextField;
		private var memTf : TextField;
	}
}