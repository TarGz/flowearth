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
	import fr.digitas.flowearth.event.BoolEvent;
	
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;	

	/**
	 * dispatché au changement d'etat du bouton
	 * @see ToggleButton#TOGGLE
	 */
	[Event(name="onToggle", type="fr.digitas.flowearth.event.BoolEvent")]

	
	/**
	 * @author Pierre Lepers
	 */
	public class ToggleButton extends SimpleButton {
		
		public static const TOGGLE : String = "onToggle";
		public static const TOGGLED : String = "onToggled";
		
		
		public var symbol : MovieClip;
		
		
		public function ToggleButton(){
			_toggled = true;
			symbol.gotoAndPlay( LABEL_TOGGLED );
			addEventListener( MouseEvent.CLICK, handleClick );
			addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		}
		

		public function set toggled( value : Boolean ) : void {
			if( value == _toggled ) return;
	 		if( ! dispatchEvent( new BoolEvent( TOGGLE, value , false, true ) ) ) return;
			if(!value)	symbol.gotoAndPlay( LABEL_UNTOGGLED );
			else		symbol.gotoAndPlay( LABEL_TOGGLED );
	 		_toggled = value;
	 		dispatchEvent( new BoolEvent( TOGGLED, value , false ) );
		}
		
		public function get toggled() : Boolean {
			return _toggled;
		}
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		override public function handleClick( e : MouseEvent = null ) : void{
		 	toggled = !toggled;
		}

		public override function focusIn(event : FocusEvent) : void {
			super.focusIn( event );
		}

		public override function focusOut(event : FocusEvent) : void {
			super.focusOut( event );
		}
		
		private function onKeyDown(event : KeyboardEvent) : void {
			if( event.keyCode == Keyboard.SPACE ) toggled = ! toggled;
		}
		
		
		private const LABEL_TOGGLED		: String = "toggled";
		private const LABEL_UNTOGGLED	: String = "untoggled";
		
		protected var _toggled : Boolean;
	}
}
