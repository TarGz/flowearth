package fr.digitas.flowearth.ui.form {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;		

	/**
	 * @author Pierre Lepers
	 */
	public class CompletionProvider {

		
		
		public function CompletionProvider() {
			_aItems = [];
		}
		
		public function addItem( cdata : CompletionData ) : void {
			_aItems.push( cdata );
		}
		
		public function getItems() : IIterator {
			return new Iterator( _aItems );
		}
		
		public function getFilteredItems( str : String ) : Array {
			_tempFilterString = str.toLowerCase();
			return _aItems.filter( _filter );
		}

		private function _filter( element : CompletionData, index :int, arr:Array) : Boolean {
			return( element.refString.indexOf( _tempFilterString ) == 0 );
		}
		

		private var _aItems : Array;
		
		private var _tempFilterString : String;
		
	}
}
