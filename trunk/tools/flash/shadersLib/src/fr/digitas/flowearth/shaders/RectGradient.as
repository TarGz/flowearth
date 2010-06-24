package fr.digitas.flowearth.shaders {
	import fr.digitas.flowearth.shaders.ShaderHelper;
	
	/**
	 * @author Pierre Lepers
	 */
	public class RectGradient extends ShaderHelper {
		
		[Embed(source="../../../../../../shaders/rectGradientFill/RectGradientFill.pbj", mimeType="application/octet-stream")]
		private static const _rectGradientFill : Class;


		public function RectGradient () {
			_buildShader( new _rectGradientFill() );
		}

		public function set insetColor ( c : uint ) : void {
			_shader.data.insetColor.value = ShaderUtils.colorToVector32( c ); 
		}

		public function set outsetColor ( c : uint ) : void {
			_shader.data.outsetColor.value = ShaderUtils.colorToVector32( c ); 
		}

		public function setSize( w : Number, h : Number ) : void {
			_shader.data.size.value = [ w, h ]; 
		}

		public function set distance( val : Number ) : void {
			_shader.data.dist.value = [ val, val ]; 
		}
	}
}
