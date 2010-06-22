package fr.digitas.flowearth.shaders {

	/**
	 * @author plepers
	 */
	public class ShaderUtils {

		public static function vectorToColor ( pixelChannels : Array ) : uint {
			
			return (pixelChannels[3] * 0xff << 24) | (pixelChannels[0] * 0xff << 16) | (pixelChannels[1] * 0xff << 8) | pixelChannels[2] * 0xff;
		}

		public static function colorToVector ( color : uint ) : Vector.<Number> {
			var result : Vector.<Number> = new Vector.<Number>( 4, true );
	
			result[3] = ((color >> 24) & 0x000000ff) / 0xff;
			result[0] = ((color >> 16) & 0x000000ff) / 0xff;
			result[1] = ((color >> 8) & 0x000000ff) / 0xff;
			result[2] = (color & 0x000000ff) / 0xff;

			return result;
		}
	}
}
