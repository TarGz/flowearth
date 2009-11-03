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


package fr.digitas.flowearth.ui.scroller {	import flash.display.Sprite;
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class ScrollerContent extends Sprite {						public function ScrollerContent() {			super();			_lh = _lw = 0;//			addEventListener( Event.ADDED_TO_STAGE, onAdded );			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}				
		internal function notifyResize( flag : Boolean) : void {			if( flag )	addEventListener( Event.ENTER_FRAME, enterFrame );			else 		removeEventListener( Event.ENTER_FRAME, enterFrame );		}		private function onRemoved( e : Event ) : void {			removeEventListener( Event.ENTER_FRAME, enterFrame );		}		//		private function onAdded( e : Event ) : void {//			addEventListener( Event.ENTER_FRAME, enterFrame );//		}		private function enterFrame( e : Event ) : void {			if( _lh != height || _lw != width ) dispatchEvent( new Event( Event.RESIZE ) );						_lh = height;			_lw = width;		}		//		override public function set height(value : Number) : void {//			trace( "lkjmkjmljk" );//		}						private var _lw : Number;
		private var _lh : Number;	}}