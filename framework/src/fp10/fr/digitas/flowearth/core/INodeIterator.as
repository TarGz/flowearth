package fr.digitas.flowearth.core {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.mvc.address.structs.INode;		

	/**
	 * @author Pierre Lepers
	 */
	public class INodeIterator implements IIterator {
		
		public function INodeIterator( v : Vector.<INode> ) {
			_v = v;
			_c = 0;
		}
		
		public function next() : Object {
			return _v[_c ++];
		}
		
		public function hasNext() : Boolean {
			return _v.length > _c; 
		}
		
		private var _v : Vector.<INode>;
		private var _c : int;
		
	}
}
