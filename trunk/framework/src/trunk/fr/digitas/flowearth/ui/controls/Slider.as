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
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fr.digitas.flowearth.event.NumberEvent;


	/**
	 * <p>dispatch un NumberEvent lorsque la valeur du slider est modifié</p>
	 * @see Event#CHANGE
	 */[Event(name="change", type="fr.digitas.flowearth.event.NumberEvent")]

	/**
	 * <p>dispatché quand on commence a dragger le slider</p>
	 * @see Slider#START_SLIDE
	 */[Event(name="startSlide", type="flash.events.Event")]
	
	/**
	 * <p>dispatché quand on arrete de dragger le slider</p>
	 * @see Slider#STOP_SLIDE
	 */[Event(name="stopSlide", type="flash.events.Event")]
	
	
	/**
	 * @author Pierre Lepers
	 */
	public class Slider extends Sprite {
		
		
		public static const START_SLIDE : String  = "startSlide";
		public static const STOP_SLIDE : String  = "stopSlide";
		
		
		//_____________________________________________________________________________
		//																	   ELEMENTS
		/** @private */
		public var track 		: Sprite;
		/** @private */
		public var background 	: Sprite;
		/** @private */
		public var progress 	: Sprite;
		/** @private */
		public var cursor 		: Sprite;
		
		
		//_____________________________________________________________________________
		//																	 PARAMETRES
		
		/**
		 * valeur actuelle du slider, comprise entre min et max
		 */
		public function get value ( ) : Number {
			return _value;
		}
		/** @private */
		public function set value ( val :  Number ) : void {
			if( _value == val ) return;
			_value = val;
			dispatchEvent( new NumberEvent( Event.CHANGE, _value ) );
		}
		
		/**
		 * valeur minimum du slider, valeur quand le curseur est a fond a gauche
		 * @default 0
		 */
		public var min : Number = 0;
		/**
		 * valeur maximum du slider, valeur quand le curseur est a fond a droite
		 * @default 1
		 */
		public var max : Number = 1;
				
		
		//_____________________________________________________________________________
		//																   CONSTRUCTEUR
		
		public function Slider() {
			activate( true );
			addEventListener( Event.CHANGE, update );
			_value = min;
			update( null );
		}		
		
		
		
		
		//_____________________________________________________________________________
		//																		 PUBLIC
		
		public function activate( flag : Boolean ) : void {
			if( flag ) 	track.addEventListener( MouseEvent.MOUSE_DOWN, trackDown );
			else 		track.removeEventListener( MouseEvent.MOUSE_DOWN, trackDown );
		}		
		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		protected function trackDown( e : MouseEvent ) : void {
			_stage = stage;
			_stage.addEventListener( MouseEvent.MOUSE_MOVE, mouseMove );
			_stage.addEventListener( MouseEvent.MOUSE_UP, stageUp );
			dispatchEvent( new Event( START_SLIDE ) );
			change();
		}		
		
		protected function stageUp( e : MouseEvent ) : void {
			_stage.removeEventListener( MouseEvent.MOUSE_MOVE, mouseMove );
			_stage.removeEventListener( MouseEvent.MOUSE_UP, stageUp );
			_stage = null;
			dispatchEvent( new Event( STOP_SLIDE ) );
		}
		
		protected function mouseMove( e : MouseEvent ) : void {
			change();
		}
		
		protected function change() : void {
			var pcent:Number = ( mouseX - track.x ) / track.width;
			pcent = Math.min( 1, Math.max( 0, pcent ) );
			value = pcent * ( max - min ) + min;
		}
		
		
		protected function update( e : NumberEvent ) : void {
			var pcent : Number = (value - min) / ( max - min );
			if( progress ) progress.width = track.width * pcent;
			if( cursor ) cursor.x = track.x + ( track.width * pcent );
		}
		
		
		protected var _value : Number;
		
		private var _stage 	: Stage;
		
	}
}
