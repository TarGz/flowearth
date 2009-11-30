package fr.digitas.flowearth.csseditor.data.builder {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.CSSData;
	import fr.digitas.flowearth.csseditor.data.StyleData;
	import fr.digitas.flowearth.csseditor.data.StyleProperty;		

	/**
	 * @author Pierre Lepers
	 */
	public class CSSBuilder {
		
		public static function build( datas : CSSData ) : String {
			
			var res : String = "";
			
			var iter : IIterator = datas.getStyles();
			var item : StyleData;
			while( item = iter.next( ) as StyleData ) {
				res += getStyleString( item );
				
				res += "\n";
			}
			
			return res;
		}

		private static function getStyleString( sd : StyleData ) : String {
			var res : String = sd.getName();
			if( sd.superName ) 
				res += ">" + sd.superName;
			res += " {\n";
			
			var iter : IIterator = sd.getProps();
			var prop : StyleProperty;
			
			while( prop = iter.next() as StyleProperty ) 
				res += "	"+prop.name + ": " + ( prop.strValue || null ).toString()+";\n";
			
			res+= "}\n";
			return res;
		}
	}
}
