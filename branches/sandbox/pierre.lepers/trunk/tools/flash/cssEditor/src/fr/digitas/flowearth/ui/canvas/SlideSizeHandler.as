package fr.digitas.flowearth.ui.canvas {
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;		

	/**
	 * @author Pierre Lepers
	 */
	public class SlideSizeHandler {

		
		
		private var stage : Stage;
		private var _sep : DisplayObject;
		private var _ca : Canvas;
		private var _cb : Canvas;
		private var h : Boolean;

		public function SlideSizeHandler( stage : Stage, sep : DisplayObject, ca : Canvas, cb : Canvas, h : Boolean = true ) {
			
			this.h = h;
			_cb = cb;
			_ca = ca;
			_sep = sep;
			this.stage = stage;
			_init();
			stage.addEventListener( MouseEvent.MOUSE_MOVE , onMouseMove );
			stage.addEventListener( MouseEvent.MOUSE_UP ,  onMouseUp );
		}
		

		private function _init() : void {
			basePos = h ? stage.mouseX : stage.mouseY;
			aSize =  h ? _ca.width : _ca.height;
			bSize =  h ? _cb.width : _cb.height;
		}

		private function onMouseMove(event : MouseEvent) : void {
			var dh : int = h ? ( stage.mouseX - basePos ): ( stage.mouseY - basePos );
			if( h ) {
				_ca.width = aSize + dh;
				_cb.width = bSize - dh;
			}
			else {
				_ca.height = aSize + dh;
				_cb.height = bSize - dh;
			}
			
			_sep.dispatchEvent( new Event( Event.RESIZE  ) );
		}
		
		private function onMouseUp(event : MouseEvent) : void {
			dispose();
		}

		public function dispose() : void {
			stage.removeEventListener( MouseEvent.MOUSE_UP ,  onMouseUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE , onMouseMove );
			_ca = _cb = null;
			_sep = null;
			stage = null;
		}
		
		private var basePos : int;
		private var aSize : int;
		private var bSize : int;
	}
}
