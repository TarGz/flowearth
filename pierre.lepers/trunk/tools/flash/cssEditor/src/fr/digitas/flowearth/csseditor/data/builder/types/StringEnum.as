package fr.digitas.flowearth.csseditor.data.builder.types {

	/**
	 * @author Pierre Lepers
	 */
	public class StringEnum extends PropertyType {

		
		
		
		public function StringEnum( enum : Array ) {
			_enum = enum;
			super( String );
		}
		
		private var _enum : Array;
		
	}
}
