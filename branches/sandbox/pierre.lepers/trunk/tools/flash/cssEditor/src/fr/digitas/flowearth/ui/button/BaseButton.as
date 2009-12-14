package fr.digitas.flowearth.ui.button {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;		

	/**
	 * @author Pierre Lepers
	 */
	public class BaseButton extends MovieClip {

		
		public function BaseButton() {
			_init( );
		}
		
		protected function _init() : void {
			addEventListener( MouseEvent.ROLL_OVER , over );
			addEventListener( MouseEvent.ROLL_OUT , out );
			addEventListener( MouseEvent.MOUSE_DOWN , down );
			addEventListener( MouseEvent.MOUSE_UP , over );
		}
		
		private function over(event : MouseEvent) : void {
			gotoAndPlay( "over" );
		}

		private function out(event : MouseEvent) : void {
			gotoAndPlay( "out" );
		}

		private function down(event : MouseEvent) : void {
			gotoAndPlay( "down" );
		}
	}
}
