package {
	import fr.digitas.flowearth.debug.FPS;	
	
	import flash.events.MouseEvent;	
	import flash.display.Sprite;
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class RectGradientShapePerf extends Sprite {


		public function RectGradientShapePerf() {
			
			_buildRects();
			
			addChild( new FPS );
			
			addEventListener( Event.ENTER_FRAME	, _oef );
			stage.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		private var _renderMode : int = 0;
		
		private function onClick(event : MouseEvent) : void {
			_renderMode = (_renderMode == 0) ? 1 : 0;
			for (var i : int = 0; i < _rects.length; i++) {
				_rects[ i ].renderMode = _renderMode;
			}
		}

		private var _rects : Array;

		private function _buildRects() : void {
			_rects = [];
			var rect : ShadowedRect;
			for (var i : int = 0; i < 10 ; i++) {
				rect = new ShadowedRect( Math.random() * 100 + 300,  Math.random() * 80 + 220 );
				addChild( rect );
				rect.x = Math.random() * (stage.stageWidth - 40 ) + 20;
				rect.y = Math.random() * (stage.stageHeight - 40 ) + 20 ;
				_rects.push( rect );
			}
			
		}

		
		
		private function _oef(event : Event) : void {
			
			for (var i : int = 0; i < _rects.length; i++) {
				_rects[ i ].rotation +=1;
			}
			
		}

	}
}

import fr.digitas.flowearth.shaders.RectGradientShape;

import flash.display.Shape;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.geom.Rectangle;

class ShadowedRect extends Sprite {

	
	public static const FILL : int = 0;
	public static const FILTER : int = 1;
	
	public function get renderMode() : int {
		return _renderMode;
	}
	
	public function set renderMode(renderMode : int) : void {
		_renderMode = renderMode;
		_changeRenderMode( );
	}

	override public function get width() : Number {
		return _shape.width;
	}

	override public function set width(value : Number) : void {
		_shape.width = value;
		_shape.x = -width/2;
		if( _renderMode == FILL && _fx ) _updateFx();
	}

	override public function set rotation(value : Number) : void {
		super.rotation = value;
		if( _renderMode == FILL && _fx ) _updateFx();
		
	}

	override public function get height() : Number {
		return _shape.height;
	}

	override public function set height(value : Number) : void {
		_shape.height = value;
		_shape.y = -height/2;
		if( _renderMode == FILL && _fx ) _updateFx();
	}

	
	public function ShadowedRect( w : int, h : int ) {
		addChild( _shape = new Shape( ) );
		_shape.graphics.beginFill( 0xF4F4F4 );
		_shape.graphics.drawRect( 0, 0, 100, 100 );
		
		
		width = w;
		height = h;

		renderMode = FILL;
		
	}

	private function _changeRenderMode() : void {
		if( _renderMode == FILL ) {
			_shape.filters = [];
			_createFx();
			_updateFx();
		} else {
			_shape.filters = [ DSF ];
			_killFx();
		}
	}
	
	private function _updateFx() : void {
		_fx.bounds = new Rectangle( 0, 0, width, height );
		_fx.x = -width/2;
		_fx.y = -height/2;
		_fx.angle = ( -rotation / 180 * Math.PI ) + Math.PI/4;
	}

	private function _killFx() : void {
		if( _fx == null ) return;
		removeChild( _fx );
		_fx = null;
	}

	private function _createFx() : void {
		if( _fx != null ) return;
		_fx = new RectGradientShape();
		_fx.angle = Math.PI/4;
		_fx.distance = 12;
		_fx.blur = 18;
		_fx.insetColor = 0xA0000000;
		addChild( _fx );
	}

	
	
	private var _shape : Shape;
	private var _fx : RectGradientShape;
	
	private static const DSF : DropShadowFilter = new DropShadowFilter( 12, 45, 0, 0.38, 18 ,18 ,1 , 3 );

	
	
	private var _renderMode : int;
	
}
