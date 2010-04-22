package fr.digitas.flowearth.ui.canvas {
	import flash.events.MouseEvent;	
	
	import fr.digitas.flowearth.ui.layout.Layout;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class CanvasLayout extends Canvas {
		
		
		
		public function CanvasLayout( ) {
			super();
			_ratios = new Dictionary( );
			_layout = new Layout();
			addChild( _layout );
		}

		
		public function addCanvas( canvas : Canvas ) : void {
			var spSize : int = _layout.width;
			if( _layout.numChildren > 0 ) {
				spSize = getSizeProp( _layout.getChildAt( _layout.numChildren - 1 ) );
				setSizeProp( _layout.getChildAt( _layout.numChildren - 1 ), Math.floor( spSize/2 ) );
				var s : DisplayObject = getSeparator();
				s.addEventListener( MouseEvent.MOUSE_DOWN , onSepDown );
				_layout.addChild( s );
			}
			setSizeProp( canvas, Math.ceil(spSize/2) );
			_layout.addChild( canvas );
			_layout.indexMap.setItemIndex( canvas, _layout.indexMap.length-1 );
			
			if( _percentedChild == null ) _percentedChild = canvas;
		}
		

		override public function set width(value : Number) : void {
			_layout.width = _width = value;
			update();
		}

		override public function set height(value : Number) : void {
			_layout.height = _height = value;
			update();
		}

		public function update() : void {
			_preUpdate();
			_layout.update();
		}
		
		protected function getSeparator() : DisplayObject {
			return null;
		}
		
		protected function _preUpdate() : void {
			var _do : DisplayObject;
			var canvas : Canvas;
			var percentTotal : Number = getSize();
			for (var i : int = 0; i < _layout.numChildren ; i++) {
				_do = _layout.getChildAt( i );
				setFixeSizeProp( _do, getFixeSize() );
				canvas = _do as Canvas;
				if( canvas ) {
					if( canvas != _percentedChild ) {
						percentTotal -= getSizeProp( canvas );
						
//						throw new Error( "fr.digitas.flowearth.ui.canvas.CanvasLayout - _preUpdate : "+getSizeProp( canvas ) );
					}
					
				}
			}
			if( _percentedChild )
				setSizeProp( _percentedChild , percentTotal );
			
		}
		
		protected function setSizeProp( _do : DisplayObject, val : Number ) : void {
		}
		
		protected function getSizeProp( _do : DisplayObject ) : Number {
			return 20;
		}
		
		protected function setFixeSizeProp( _do : DisplayObject, val : Number ) : void {
		}

		protected function getFixeSizeProp( _do : DisplayObject ) : Number {
			return 0;
		}
		
		protected function getSize() : Number {
			return 0;
		}
		protected function getFixeSize() : Number {
			return 0;
		}
		
		
		protected function onSepDown(event : MouseEvent) : void {
			
		}
		
		
		
		

		
		
		protected var _ratios : Dictionary;
		
		protected var _percentedChild : Canvas;
		
		protected var _layout : Layout;
	}
}
