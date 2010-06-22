package fr.digitas.flowearth.shaders {
	import flash.geom.Point;	
	
	/**
	 * @author plepers
	 */
	public class ColorPickerS extends ShaderHelper {
		
		[Embed(source="../../../../../../shaders/colorPickerS/ColorPickerS.pbj", mimeType="application/octet-stream")]
		private static const _colorPickerS : Class;


		public function ColorPickerS () {
			_buildShader( new _colorPickerS() );
		}
		
		
		/**
		 * saturation value of the generated map.
		 * valid values are between 0 and 1 ( default 1 )
		 * 
		 * - 1 mean a full color map
		 * - 0 mean B&W map
		 * 
		 */
		public function set saturation ( val : Number ) : void {
			_shader.data.saturation.value = [ val ]; 
		}

		/**
		 * size ( widrth, height ) of the map to drawn.
		 */
		public function set size ( val : Point ) : void {
			_shader.data.size.value = [ val.x, val.y ]; 
		}
		
		
	}
}
