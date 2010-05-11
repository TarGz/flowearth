package fr.digitas.flowearth.text.styles {
	import flashx.textLayout.elements.IConfiguration;
	import flashx.textLayout.formats.ITextLayoutFormat;		

	/**
	 * Interface between TextLayoutFramework and flowearth styles api
	 * 
	 * This interface limit dependancy with tlf framework (only lightweight interface are typed)
	 * 
	 * @author Pierre Lepers
	 */
	public interface ITlfFactory {

		function hasSupport() : Boolean;

		function getConfiguration() : IConfiguration;


		function getTextLayoutFormat( initialValues : ITextLayoutFormat = null ) : ITextLayoutFormat;
		
		/**
		 * to many tlf dependancy to type ITextImporter
		 */
		function getHtmlTextImporter( config : IConfiguration ) : Object;

		/**
		 * to many tlf dependancy to type IFormatResolver
		 */
		function getFormatResolver( ) : Object;
		
	}
}
