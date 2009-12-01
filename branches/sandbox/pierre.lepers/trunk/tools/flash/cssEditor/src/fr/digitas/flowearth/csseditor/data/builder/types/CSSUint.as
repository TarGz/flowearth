package fr.digitas.flowearth.csseditor.data.builder.types {

	/**
	 * @author Pierre Lepers
	 */
	public class CSSUint extends PropertyType {

		
		
		public function CSSUint( value : uint = 0) {
			this.value = value;
			super( CSSUint );
		}
		
		public var value : uint;
		
	}
}
