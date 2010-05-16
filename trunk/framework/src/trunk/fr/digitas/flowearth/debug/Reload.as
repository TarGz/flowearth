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
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;	

	/**
	 * 
	 * 
	 * @author Pierre Lepers
	 */
	public class Reload {

		public static function activate ( stage : Stage ) : void { 
			if( _stage ) return;
			_stage = stage;
			_stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDown );
		}

		public static function unactivate ( ) : void { 
			_stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyDown );
			_stage = null;
		}

		
		private static function keyDown(event : KeyboardEvent) : void {
			if( event.keyCode == Keyboard.F5 && ExternalInterface.available )
				ExternalInterface.call( _JSCode );
		}

		private static var _stage : Stage;
		
		private static const _JSCode : XML = <script><![CDATA[
												function __flowearth_debug_reload__(){
													function __flowearth_debug_reload_i__ (){ 
														location.reload( true );
													}; 
													__flowearth_debug_reload_i__(); 
												}
											]]></script>;
		

	}
}
