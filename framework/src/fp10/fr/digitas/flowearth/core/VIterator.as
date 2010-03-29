package fr.digitas.flowearth.core {

	/**
	 * @author Pierre Lepers
	 */
	public class VIterator implements IIterator {

		public function VIterator( v : Vector.<Object> ) {
			_v = v;
			_c = 0;
		}

		public function next() : Object {
			return _v[_c ++];
		}

		public function hasNext() : Boolean {
			return _v.length > _c;
		}

		private var _v : Vector.<Object>;
		private var _c : int;
	}
}
