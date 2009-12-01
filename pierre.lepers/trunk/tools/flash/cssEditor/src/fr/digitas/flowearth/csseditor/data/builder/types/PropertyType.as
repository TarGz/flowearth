package fr.digitas.flowearth.csseditor.data.builder.types {

	/**
	 * @author Pierre Lepers
	 */
	public class PropertyType {

		
		public function getNativeType() : Class {
			return _nativeType;
		}
		
		public function PropertyType( nativeType : Class ) {
			_nativeType = nativeType;
		}

		private var _nativeType : Class;
		
	}
}
