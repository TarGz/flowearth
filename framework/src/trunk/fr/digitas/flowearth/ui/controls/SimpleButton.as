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

package fr.digitas.flowearth.ui.controls {	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;	

	/**
	 * @author Pierre Lepers
	 */
	public class SimpleButton extends MovieClip {				static protected const LABEL_OPEN 		: String = "open";		static protected const LABEL_OUT 		: String = "out";		static protected const LABEL_OVER 		: String = "over";		static protected const LABEL_PRESS 		: String = "press";		static protected const LABEL_CLICK 		: String = "click";		static protected const LABEL_SELECTED 	: String = "selected";		static protected const LABEL_UNSELECTED : String = "unselected";		static protected const LABEL_DISABLED 	: String = "disable";		static protected const LABEL_FOCUSED 	: String = "focused";		static protected const LABEL_UNFOCUSED 	: String = "unfocused";						protected var _selected : Boolean;		
		public function SimpleButton(){			super();			buttonMode = true;			mouseChildren = false;
			focusRect = false;						addEventListener( MouseEvent.CLICK, handleClick );			addEventListener( MouseEvent.ROLL_OVER, handleOver );			addEventListener( MouseEvent.ROLL_OUT, handleOut );			addEventListener( MouseEvent.MOUSE_DOWN, handleDown );					addEventListener( FocusEvent.FOCUS_IN, focusIn );					addEventListener( FocusEvent.FOCUS_OUT, focusOut );				}				public function select():void{
			if( _selected ) return;			_selected = true;			gotoAndPlay(LABEL_SELECTED);		}				public function unSelect():void{			if( ! _selected ) return;			_selected = false;			gotoAndPlay( LABEL_UNSELECTED );		}		public function set enable( flag : Boolean ):void{
			mouseEnabled  = flag;			mouseChildren = false; // flag			buttonMode    = flag;			tabChildren   = flag;			tabEnabled    = flag;			gotoAndPlay( flag ? LABEL_OPEN : LABEL_DISABLED );		}			public function get enable() : Boolean {			return mouseEnabled;		}				public function handleOver( e : MouseEvent = null ):void{			if (mouseEnabled == false) return;			if (_selected == true) return;			gotoAndPlay(LABEL_OVER);		}				public function handleOut( e : MouseEvent = null ):void{			if (mouseEnabled == false) return;			if (_selected == true) return;			gotoAndPlay(LABEL_OUT);		}				public function handleDown( e : MouseEvent = null ):void{			if (_selected == true) return;			gotoAndPlay(LABEL_PRESS);		}				public function handleClick( e : MouseEvent = null ):void{			if (_selected == true) return;			gotoAndPlay(LABEL_CLICK);		}		public function focusIn(event : FocusEvent) : void {			if (_selected == true) return;			gotoAndPlay( LABEL_FOCUSED );		}		public function focusOut(event : FocusEvent) : void {			if (_selected == true) return;			gotoAndPlay( LABEL_UNFOCUSED );		}					}}