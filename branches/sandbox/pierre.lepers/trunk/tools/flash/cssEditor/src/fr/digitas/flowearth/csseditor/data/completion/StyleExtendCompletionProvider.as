package fr.digitas.flowearth.csseditor.data.completion {
	import fr.digitas.flowearth.ui.form.CompletionData;	
	import fr.digitas.flowearth.core.IIterator;	
	import fr.digitas.flowearth.csseditor.data.StyleData;	
	import fr.digitas.flowearth.csseditor.data.CSSData;	
	import fr.digitas.flowearth.ui.form.CompletionProvider;
	
	/**
	 * @author Pierre Lepers
	 */
	public class StyleExtendCompletionProvider extends CompletionProvider {

		
		
		public function StyleExtendCompletionProvider( style : StyleData ) {
			this.style = style;
			super();
		}
		

		override public function getItems() : IIterator {
			if( !_lazyBuilded ) _lazyBuild();
			return super.getItems( );
		}

		override public function getFilteredItems(str : String) : Array {
			if( !_lazyBuilded ) _lazyBuild();
			return super.getFilteredItems( str );
		}
		
		private function _lazyBuild() : void {
			_lazyBuilded = true;
			
			var iter : IIterator = style.cssData.getStyles();
			var item : StyleData;
			while( iter.hasNext() ) {
				item = iter.next() as StyleData;
				if( item != style ) 
					addItem( getCompletionData( item ) );
			}
		}

		private var _lazyBuilded : Boolean = false;

		private var style : StyleData;

		
		private static function getCompletionData(item : StyleData) : CompletionData {
			var res : CompletionData = new CompletionData();
			res.label = 
			res.completion = item.getName();
			res.refString = item.getName().toLowerCase();
			return res;
		}
	}
}
