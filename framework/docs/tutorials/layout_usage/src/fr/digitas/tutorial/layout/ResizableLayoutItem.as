package fr.digitas.tutorial.layout {
	import flash.events.Event;	
	import flash.geom.Point;	
	import flash.events.MouseEvent;	
	
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;	

	/**
	 * @author Pierre Lepers
	 */
	public class ResizableLayoutItem extends Sprite implements ILayoutItem {
		

		public var guizmo : MovieClip;
		public var bg : MovieClip;

		
		
		public function ResizableLayoutItem() {
			guizmo.mouseChildren = false;
			guizmo.useHandCursor = guizmo.buttonMode = true;
			guizmo.addEventListener( MouseEvent.MOUSE_DOWN , mouseDown );
			
			
			bg.doubleClickEnabled = true;
			bg.addEventListener( MouseEvent.DOUBLE_CLICK , onDoubleClick );
		}
		
		private function onDoubleClick(event : MouseEvent) : void {
			
			var w : int = 128;
			var h : int = 46;
			guizmo.x = bg.width = w;
			guizmo.y = bg.height = h;
			dispatchEvent( new Event( Event.RESIZE ) );
		}

		public function getWidth() : Number {
			return bg.width;
		}
		
		public function getHeight() : Number {
			return bg.height;
		}
		
		public function getDisplay() : DisplayObject {
			return this;
		}

		
		private function mouseDown(event : MouseEvent) : void {
			stage.addEventListener( MouseEvent.MOUSE_UP , mouseUp );
			stage.addEventListener( MouseEvent.MOUSE_MOVE , mouseMove );
			_dpoint = new Point( mouseX, mouseY );
			_dsize = new Point( bg.width, bg.height );
		}

		private function mouseUp(event : MouseEvent) : void {
			stage.removeEventListener( MouseEvent.MOUSE_UP , mouseUp );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE , mouseMove );
		}
		
		private function mouseMove(event : MouseEvent) : void {
			var w : int = Math.max( 15, _dsize.x + mouseX - _dpoint.x );
			var h : int = Math.max( 15, _dsize.y + mouseY - _dpoint.y );
			guizmo.x = bg.width = w;
			guizmo.y = bg.height = h;
			dispatchEvent( new Event( Event.RESIZE ) );
		}

		private var _dpoint : Point;
		private var _dsize : Point;
	}
}
