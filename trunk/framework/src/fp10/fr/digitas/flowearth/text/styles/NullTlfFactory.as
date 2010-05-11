package fr.digitas.flowearth.text.styles {
	import flashx.textLayout.elements.IConfiguration;
	import flashx.textLayout.formats.ITextLayoutFormat;	
	
	/**
	 * Default ITlfFactory
	 * this class thow error on each method, 
	 * 
	 * @author Pierre Lepers
	 */
	public final class NullTlfFactory implements ITlfFactory {

		
		
		public function hasSupport() : Boolean {
			return false;
		}
		
		public function getConfiguration() : IConfiguration {
			_error();
			return null;
		}
		
		public function getTextLayoutFormat(initialValues : ITextLayoutFormat = null) : ITextLayoutFormat {
			_error();
			return null;
		}
		
		public function getHtmlTextImporter(config : IConfiguration) : Object {
			_error();
			return null;
		}
		
		public function getFormatResolver() : Object {
			_error();
			return null;
		}
	
		
		
		private function _error() : void {
			throw new Error( "TextLayoutFramework support is not initilized - use 'TlfSupport.init()' before call fr.digitas.styles.* API" );
		}
	}
}
