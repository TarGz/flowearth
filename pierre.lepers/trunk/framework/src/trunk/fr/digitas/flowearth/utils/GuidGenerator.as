package fr.digitas.flowearth.utils {

	/**
	 * @author Pierre Lepers
	 */
	public class GuidGenerator {

		public function GuidGenerator() {
			
		}

		public function getGuid() : String {
			var res : String = (_count++).toString();
			if( _store.indexOf( res ) > -1 ) 
				return getGuid();
			_addGuid( res );
			return res;
		}

		public function addGuid( guid : String ) : void {
			if( _store.indexOf( guid ) > -1 ) 
				return;
			_store.push( guid ); 
		}

		private function _addGuid( guid : String ) : void {
			_store.push( guid );
		}

		private var _count : int = 0;
		
		private var _store : Array;
	}
}
