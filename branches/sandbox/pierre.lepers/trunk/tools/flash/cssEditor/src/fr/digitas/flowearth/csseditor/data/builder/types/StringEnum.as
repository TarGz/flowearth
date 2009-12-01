package fr.digitas.flowearth.csseditor.data.builder.types {
	import fr.digitas.flowearth.core.Iterator;	
	import fr.digitas.flowearth.core.IIterator;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class StringEnum extends PropertyType {

		
		
		
		public function get values() : IIterator {
			return new Iterator( _enum );
		}
		
		public function StringEnum( enum : Array ) {
			_enum = enum;
			super( String );
		}
		
		private var _enum : Array;
	}
}
