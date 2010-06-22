package fr.digitas.flowearth.shaders {
	import flash.display.Shader;
	import flash.utils.ByteArray;

	/**
	 * @author plepers
	 */
	public class ShaderHelper {
		
		public function ShaderHelper () {

		}
		
		public function get shader () : Shader {
			return _shader;
		}

		protected function _buildShader ( bytes : ByteArray ) : void {
			_shader = new Shader( bytes );
		}

		protected var _shader : Shader;
	}
}
