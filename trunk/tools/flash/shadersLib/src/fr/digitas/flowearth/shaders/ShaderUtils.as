package fr.digitas.flowearth.shaders {
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;	
	
	/**
	 * @author plepers
	 */
	public class ShaderUtils {

		public static function vectorToColor ( pixelChannels : Array ) : uint {
			
			return (pixelChannels[0] * 0xff << 16) | (pixelChannels[1] * 0xff << 8) | pixelChannels[2] * 0xff;
		}

		public static function vectorToColor32 ( pixelChannels : Array ) : uint {
			
			return (pixelChannels[3] * 0xff << 24) | (pixelChannels[0] * 0xff << 16) | (pixelChannels[1] * 0xff << 8) | pixelChannels[2] * 0xff;
		}
		/**
		 * return a color vector suited for a pixel bender float3 parameter
		 */
		public static function colorToVector ( color : uint ) : Array {
			var result : Array = new Array( );
	
			result[0] = ((color >> 16) & 0x000000ff) / 0xff;
			result[1] = ((color >> 8) & 0x000000ff) / 0xff;
			result[2] = (color & 0x000000ff) / 0xff;

			return result;
		}

		/**
		 * return a color vector suited for a pixel bender float4 parameter
		 */
		public static function colorToVector32 ( color : uint ) : Array {
			var result : Array = new Array( );
	
			result[3] = ((color >> 24) & 0x000000ff) / 0xff;
			result[0] = ((color >> 16) & 0x000000ff) / 0xff;
			result[1] = ((color >> 8) & 0x000000ff) / 0xff;
			result[2] = (color & 0x000000ff) / 0xff;

			return result;
		}
		
		/**
		 * return a full saturated color of the chromatic circle
		 * 
		 * @param a : angle in degrees of the color on the chromatic circle
		 * 
		 */
		public static function getTint( a : Number ) : uint {
			return getColorCycleMap().getPixel( ( a/360 ) * 1536, 0 );
		}

		
		
		//_____________________________________________________________________________
		//																COLOR CYCLE MAP
		
		/**
		 * return a 1536*1 bitmapdata filled with chromatic circle values
		 */
		public static function getColorCycleMap() : BitmapData {
			if( _colorCycleMap == null )
				_buildColorCycleMap( );
			return _colorCycleMap;
		}

		private static function _buildColorCycleMap() : void {
			var s : Shape = new Shape;
			var g : Graphics = s.graphics;
			var m : Matrix = new Matrix;
			var r : Array = [ 0, 0x80, 0xFF ];
			var a : Array = [ 1, 1, 1 ];
			
			m.createGradientBox( 512, 1, 0, 0, 0 );
			
			g.beginGradientFill( GradientType.LINEAR, [ 0xFF0000, 0xFFFF00, 0x00FF00 ], a, r, m );
			g.drawRect( 0, 0, 512, 1 );
			m.translate( 512, 0 );
			g.beginGradientFill( GradientType.LINEAR, [ 0x00FF00, 0x00FFFF, 0x0000FF ], a, r, m );
			g.drawRect( 512, 0, 512, 1 );
			m.translate( 512, 0 );
			g.beginGradientFill( GradientType.LINEAR, [ 0x0000FF, 0xFF00FF, 0xFF0000 ], a, r, m );
			g.drawRect( 1024, 0, 512, 1 );
			
			_colorCycleMap = new BitmapData( 1536, 1, false, 0 );
			_colorCycleMap.draw( s );
			_colorCycleMap.lock();
		}

		private static var _colorCycleMap : BitmapData;
	}
}
