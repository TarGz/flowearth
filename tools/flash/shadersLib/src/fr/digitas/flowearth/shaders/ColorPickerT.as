package fr.digitas.flowearth.shaders {
	import flash.geom.Point;	
	
	/**
	 * @author plepers
	 */
	public class ColorPickerT extends ShaderHelper {
		
		[Embed(source="../../../../../../shaders/colorPickerT/ColorPickerT.pbj", mimeType="application/octet-stream")]
		private static const _colorPickerT : Class;


		public function ColorPickerT () {
			_buildShader( new _colorPickerT() );
		}
		
		
		/**
		 * tint of the generated map in degrees ( use color property to directly define a color )
		 */
		public function set tint ( a : Number ) : void {
			_shader.data.color.value = ShaderUtils.colorToVector( ShaderUtils.getTint( a ) ); 
		}
		
		/**
		 * base color of the generated map.
		 */
		public function set color ( c : Number ) : void {
			_shader.data.color.value = ShaderUtils.colorToVector( c ); 
		}

		/**
		 * size ( widrth, height ) of the map to drawn.
		 */
		public function set size ( val : Point ) : void {
			_shader.data.size.value = [ val.x, val.y ]; 
		}
		
		
	}
}
