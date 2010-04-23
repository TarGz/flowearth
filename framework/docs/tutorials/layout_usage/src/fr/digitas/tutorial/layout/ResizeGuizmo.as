package fr.digitas.tutorial.layout {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;	

	/**
	 * @author Pierre Lepers
	 */
	public class ResizeGuizmo extends Sprite {
		
		public function ResizeGuizmo() {
			mouseChildren = false;
			useHandCursor = buttonMode = true;
			addEventListener( MouseEvent.MOUSE_DOWN , mouseDown );
		}
		
		
		private function mouseDown(event : MouseEvent) : void {
			stage.addEventListener( MouseEvent.MOUSE_UP , mouseUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE , mouseMove );
			_dpoint = new Point( stage.mouseX, stage.mouseY );
			_dsize = new Point( x, y );
		}

		private function mouseUp(event : MouseEvent) : void {
			stage.removeEventListener( MouseEvent.MOUSE_UP , mouseUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE , mouseMove );
		}
		
		private function mouseMove(event : MouseEvent) : void {
			var w : int = Math.max( 15, _dsize.x + stage.mouseX - _dpoint.x );
			var h : int = Math.max( 15, _dsize.y + stage.mouseY - _dpoint.y );
			x = w;
			y = h;
			dispatchEvent( new Event( Event.RESIZE ) );
		}
		
		
		private var _dpoint : Point;
		private var _dsize : Point;
		
	}
}
