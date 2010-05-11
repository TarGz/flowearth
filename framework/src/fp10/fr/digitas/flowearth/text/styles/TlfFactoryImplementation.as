package fr.digitas.flowearth.text.styles {
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.Configuration;
	import flashx.textLayout.elements.IConfiguration;
	import flashx.textLayout.formats.ITextLayoutFormat;
	import flashx.textLayout.formats.TextLayoutFormat;	

	/**
	 * @author Pierre Lepers
	 */
	internal final class TlfFactoryImplementation implements ITlfFactory {
		
				
		public function hasSupport() : Boolean {
			return true;
		}
		
		public function getConfiguration() : IConfiguration {
			return new Configuration;
		}

		public function getTextLayoutFormat( initialValues : ITextLayoutFormat = null ) : ITextLayoutFormat {
			return new TextLayoutFormat( initialValues );
		}

		public function getHtmlTextImporter( config : IConfiguration ) : Object {
			return TextConverter.getImporter( TextConverter.TEXT_FIELD_HTML_FORMAT, config );
		}
		
		public function getFormatResolver() : Object {
			return new FormatResolver( );
		}
		
	}
}
