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
		

		public var guizmo : ResizeGuizmo;
		public var bg : MovieClip;

		
		
		public function ResizableLayoutItem() {
			
			bg.doubleClickEnabled = true;
			bg.addEventListener( MouseEvent.DOUBLE_CLICK , onDoubleClick );
			guizmo.addEventListener( Event.RESIZE, onResize );
			
			var w : int = 50;
			var h : int = 25;
			guizmo.x = bg.width = w;
			guizmo.y = bg.height = h;
			
			cacheAsBitmap = true;
		}
		
		private function onResize(event : Event) : void {
			bg.width = guizmo.x;
			bg.height = guizmo.y;
			dispatchEvent( new Event( Event.RESIZE ) );
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

		

	}
}
