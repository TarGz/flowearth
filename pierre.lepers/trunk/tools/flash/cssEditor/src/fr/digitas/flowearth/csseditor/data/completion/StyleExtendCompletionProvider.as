package fr.digitas.flowearth.csseditor.data.completion {
	import fr.digitas.flowearth.ui.form.CompletionData;	
	import fr.digitas.flowearth.core.IIterator;	
	import fr.digitas.flowearth.csseditor.data.StyleData;	
	import fr.digitas.flowearth.csseditor.data.CSSData;	
	import fr.digitas.flowearth.ui.form.CompletionProvider;
	
	/**
	 * @author Pierre Lepers
	 */
	public class StyleExtendCompletionProvider  {
		
		public static function getCompletionProvider( style : StyleData ) : CompletionProvider {
			var res : CompletionProvider = new CompletionProvider();
			var iter : IIterator = style.cssData.getStyles();
			var item : StyleData;
			while( iter.hasNext() ) {
				item = iter.next() as StyleData;
				if( item != style ) 
					res.addItem( getCompletionData( item ) );
			}
			return res;
		}
		
		private static function getCompletionData(item : StyleData) : CompletionData {
			var res : CompletionData = new CompletionData();
			res.label = 
			res.completion = item.getName();
			res.refString = item.getName().toLowerCase();
			return res;
		}
	}
}
