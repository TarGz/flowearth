package fr.digitas.flowearth.shaders {

	/**
	 * @author plepers
	 */
	public class AngularGradient extends ShaderHelper {
		
		[Embed(source="../../../../../../shaders/angularGradientFill/AngularGradientFill.pbj", mimeType="application/octet-stream")]
		private static const _angularGFillData : Class;


		public function AngularGradient () {
			_buildShader( new _angularGFillData() );
		}

		public function set beginColor ( c : uint ) : void {
			_shader.data.color1.value = ShaderUtils.colorToVector( c ); 
		}

		public function set endColor ( c : uint ) : void {
			_shader.data.color2.value = ShaderUtils.colorToVector( c ); 
		}
		
	}
}
