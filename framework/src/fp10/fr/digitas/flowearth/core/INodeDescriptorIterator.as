package fr.digitas.flowearth.core {
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;	
	import fr.digitas.flowearth.core.IIterator;

	/**
	 * @author Pierre Lepers
	 */
	public class INodeDescriptorIterator implements IIterator {

		public function INodeDescriptorIterator( v : Vector.<INodeDescriptor> ) {
			_v = v;
			_c = 0;
		}

		public function next() : Object {
			return _v[_c ++];
		}

		public function hasNext() : Boolean {
			return _v.length > _c; 
		}

		private var _v : Vector.<INodeDescriptor>;
		private var _c : int;
	}
}
