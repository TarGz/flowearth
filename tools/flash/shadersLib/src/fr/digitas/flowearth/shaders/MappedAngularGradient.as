package fr.digitas.flowearth.shaders {
	import flash.display.BitmapData;

	/**
	 * @author plepers
	 */
	public class MappedAngularGradient extends ShaderHelper {
		
		[Embed(source="../../../../../../shaders/mappedAngularGradientFill/MappedAngularGradientFill.pbj", mimeType="application/octet-stream")]
		private static const _angularGFillData : Class;
		
		public function MappedAngularGradient () {
			super( );
			_buildShader( new _angularGFillData() );
		}

		public function set map ( map : BitmapData ) : void {
			_shader.data.map.input = map;
			shader.data.mapsize.value = [ map.width ];
		}
	}
}
