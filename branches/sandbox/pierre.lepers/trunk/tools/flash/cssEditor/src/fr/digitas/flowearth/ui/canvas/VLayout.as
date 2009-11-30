package fr.digitas.flowearth.ui.canvas {
	import flash.events.MouseEvent;	
	
	import fr.digitas.flowearth.ui.canvas.CanvasLayout;
	import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;
	
	import flash.display.DisplayObject;	

	/**
	 * @author Pierre Lepers
	 */
	public class VLayout extends CanvasLayout {
		public function VLayout() {
			super( );
			_layout.renderer = new TopRenderer();
		}

		override protected function setSizeProp(_do : DisplayObject, val : Number) : void {
			_do.height = val;
		}
		
		override protected function getSizeProp(_do : DisplayObject) : Number {
			return _do.height;
		}

		override protected function setFixeSizeProp(_do : DisplayObject, val : Number) : void {
			_do.width = val;
		}

		override protected function getFixeSizeProp(_do : DisplayObject) : Number {
			return _do.width;
		}
		
		
		override protected function getSize() : Number {
			return _height;
		}
		override protected function getFixeSize() : Number {
			return _width;
		}

		override protected function getSeparator() : DisplayObject {
			var s : Separator = new Separator();
			s.height = 6;
			return s;
		}
		
		override protected function onSepDown(event : MouseEvent) : void {
			var sep : DisplayObject = event.currentTarget as DisplayObject;
			var index : int = _layout.itemList.indexOf( sep );
			new SlideSizeHandler( stage, sep, _layout.itemList[index - 1 ] as Canvas , _layout.itemList[index + 1 ] as Canvas, false );
		}
	}
}
