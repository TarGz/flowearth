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


package fr.digitas.flowearth.ui.scroller {
	import fr.digitas.flowearth.ui.controls.SimpleButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;	

	public class ScrollBar extends Sprite
	{
		
		public var ascenseur : 	Ascenseur;
		public var upBtn : 		SimpleButton;
		public var downBtn : 	SimpleButton;
		public var bg : 		Sprite;
		
		public static const UP : String = "UP";
		public static const DOWN : String = "DOWN";
		
		public function get ownPosition() : Number {
			return (ascenseur.y - upBtn.height) / (bg.height - ascenseur.height );
		}
		
		public function activate( flag : Boolean ) : void {
			if( flag == _activate ) return;
			
			if( flag ) 	addChild( ascenseur );
			else 		removeChild( ascenseur );
				
			upBtn.enable = downBtn.enable = flag;
			_activate = flag;
		}
		
		function ScrollBar() {
			ascenseur.addEventListener( MouseEvent.MOUSE_DOWN, onAscDown );
			bg.addEventListener( MouseEvent.MOUSE_DOWN, onBgDown );
			downBtn.addEventListener( MouseEvent.MOUSE_DOWN, onBtnDown );
			upBtn.addEventListener( MouseEvent.MOUSE_DOWN, onBtnUp );
		}
		
		
		
		public function update( pos : Number, contentHeight : Number, zoneHeight : Number ) : void {
			setHeight( zoneHeight );
			
			var ratio : Number = Math.min( 1, zoneHeight / contentHeight );
			
			ascenseur.setHeight( ratio * bg.height );
			
			ascenseur.y = pos * (bg.height - ascenseur.height ) + upBtn.height;
		}
		
		protected function setHeight( val : uint ) : void {
			_height = val;
			visible = ( _height > downBtn.height + upBtn.height + 8 ); 
			downBtn.y = val - downBtn.height;
			bg.height = val - downBtn.height - upBtn.height;
			
		}

		private function onBgDown( e : MouseEvent ) : void {
			if( mouseY > ascenseur.y ) ascenseur.y += ascenseur.realHeight;
			else ascenseur.y -= ascenseur.realHeight;
			dispatchEvent( new Event( Event.CHANGE) );
		}
		
		private function onBtnDown( e : MouseEvent ) : void {
			dispatchEvent( new Event( DOWN ) );
		}
		
		private function onBtnUp( e : MouseEvent ) : void {
			dispatchEvent( new Event( UP ) );
		}
		
		protected function onAscDown( e : MouseEvent ) : void {
			var br : Rectangle = new Rectangle( ascenseur.x, upBtn.height, 0, bg.height - ascenseur.height + 1 );
			ascenseur.startDrag( false, br );
			stage.addEventListener( MouseEvent.MOUSE_UP, stopScroll );
			stage.addEventListener( Event.ENTER_FRAME, moveScroll );
		}
		
		protected function moveScroll( e : Event ) : void {
			dispatchEvent( new Event( Event.CHANGE) );
		}
		
		protected function stopScroll( e : MouseEvent ) : void {
			stage.removeEventListener( Event.ENTER_FRAME, moveScroll );
			stage.removeEventListener( MouseEvent.MOUSE_UP, stopScroll );
			ascenseur.stopDrag();
			
		}
		
		
		private var _height : uint;
		private var _activate : Boolean = true;
		
	}
}