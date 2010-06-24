package fr.digitas.flowearth.shaders {
	import flash.geom.Matrix;	
	import flash.display.GraphicsPath;
	import flash.display.GraphicsShaderFill;
	import flash.display.IGraphicsData;
	import flash.display.Shape;
	import flash.geom.Rectangle;		

	/**
	 * @author Pierre Lepers
	 */
	public class RectGradientShape extends Shape {
		
		
		public function get bounds() : Rectangle {
			return _bounds;
		}
		
		public function set bounds(bounds : Rectangle) : void {
			_bounds = bounds;
			_invalidate();
		}
		
		public function get blur() : Number {
			return _blur;
		}
		
		public function set blur(blur : Number) : void {
			_blur = blur;
			_invalidate();
		}
		
		public function get distance() : Number {
			return _distance;
		}
		
		public function set distance(distance : Number) : void {
			_distance = distance;
			_invalidate();
		}
		
		public function get angle() : Number {
			return _angle;
		}
		
		
		public function set angle(angle : Number) : void {
			_angle = angle;
			_invalidate( );
		}
		
		public function get insetColor() : uint {
			return _insetColor;
		}
		
		public function set insetColor(insetColor : uint) : void {
			_insetColor = insetColor;
			_invalidate();
		}
		
		public function get outsetColor() : uint {
			return _outsetColor;
		}
		
		public function set outsetColor(outsetColor : uint) : void {
			_outsetColor = outsetColor;
			_invalidate();
		}
		
		
		/**
		 * @param angle in radian
		 */
		public function RectGradientShape( bounds : Rectangle = null, blur : Number = 12, distance : Number = 5, angle : Number = 0.785398 ) {
			
			_angle = angle;
			_distance = distance; 
			_blur = blur;
			_bounds = bounds || new Rectangle( 0, 0 , 100, 100 );
			
			_helper = new RectGradient();
			_helper.setSize( _bounds.width, _bounds.height );
			_helper.distance =  blur;
			
			_path = new GraphicsPath( );
			_path.data = new Vector.<Number>( 22, true );
			_path.commands = new Vector.<int>( 11, true );
			
			_fill = new GraphicsShaderFill( _helper.shader, new Matrix() );
			
			_gdata = new Vector.<IGraphicsData>( 2, true );
			_gdata[ 0 ] = _fill;
			_gdata[ 1 ] = _path;
		}

		private function _invalidate() : void {
			// TODO implement lock/unlock system
			_redraw();
		}
		
		private function _redraw() : void {
			_computePath();
			
			_helper.setSize( _bounds.width -  _blur * 2, _bounds.height - _blur * 2 );
			_helper.distance =  _blur * 2;
			_helper.insetColor = _insetColor;
			_helper.outsetColor = _outsetColor;
			
			graphics.clear();
			graphics.drawGraphicsData( _gdata );
		}

		
		
		private function _computePath() : void {
			
			var _oBound : Rectangle = _bounds.clone();
			_oBound.inflate( _blur, _blur );
			_oBound.offset( _distance*Math.cos( _angle ), _distance*Math.sin( _angle ) );
			
			_fill.matrix.tx = _oBound.x + _blur * 2;
			_fill.matrix.ty = _oBound.y + _blur * 2;

			
			if( _oBound.containsRect( bounds ) )
				_insetPath( _oBound );
			else if( _oBound.intersects( bounds ) )
				_intersectPath( _oBound );
		}
		

		/**
		 * in case of _oBound completely contain _bounds 
		 */
		private function _insetPath( b : Rectangle ) : void {
			
			
			var v : Vector.<Number> = _path.data;
			var c : Vector.<int> = _path.commands;
			var r : Rectangle = _bounds;
			
			v[0] = b.x;			v[1] = b.y;			c[0] = 1;
			v[2] = b.right;		v[3] = b.y;			c[1] = 2;
			v[4] = b.right;		v[5] = b.bottom;	c[2] = 2;
			v[6] = b.x;			v[7] = b.bottom;	c[3] = 2;
			v[8] = b.x;			v[9] = b.y;			c[4] = 2;
			
			v[10] = r.x;		v[11] = r.y;		c[5] = 2;
			v[12] = r.x;		v[13] = r.bottom;	c[6] = 2;
			v[14] = r.right;	v[15] = r.bottom;	c[7] = 2;
			v[16] = r.right;	v[17] = r.y;		c[8] = 2;
			v[18] = r.y;		v[19] = r.y;		c[9] = 2;
			
			v[20] = b.x;		v[21] = b.y;		c[10] = 2;
			
		}

		private function _intersectPath( b : Rectangle ) : void {
			
			var v : Vector.<Number> = _path.data;
			var c : Vector.<int> = _path.commands;
			
			var r : Rectangle = b.intersection( _bounds );
			
			v[0] = b.x;			v[1] = b.y;			c[0] = 1;
			v[2] = b.right;		v[3] = b.y;			c[1] = 2;
			v[4] = b.right;		v[5] = b.bottom;	c[2] = 2;
			v[6] = b.x;			v[7] = b.bottom;	c[3] = 2;
			v[8] = b.x;			v[9] = b.y;			c[4] = 2;
			
			v[10] = r.x;		v[11] = r.y;		c[5] = 1;
			v[12] = r.x;		v[13] = r.bottom;	c[6] = 2;
			v[14] = r.right;	v[15] = r.bottom;	c[7] = 2;
			v[16] = r.right;	v[17] = r.y;		c[8] = 2;
			v[18] = r.y;		v[19] = r.y;		c[9] = 2;
			
			v[20] = 0;			v[21] = 0;			c[10] = 0;
			
		}

		
		
		private var _bounds : Rectangle;
		private var _blur : Number;
		private var _distance : Number;
		private var _angle : Number;
		private var _insetColor : uint = 0xff000000;
		private var _outsetColor : uint = 0x0;

		
		private var _path : GraphicsPath;
		private var _fill : GraphicsShaderFill;
		private var _gdata : Vector.<IGraphicsData>;

		private var _helper : RectGradient;
		
	}
}
