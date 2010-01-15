package fr.digitas.flowearth.csseditor.io {
	import flash.utils.ByteArray;		

	/**
	 * @author Pierre Lepers
	 */
	public interface IFileManager {

		function saveFile( url : String, content : ByteArray ) : void;

		function loadTextFile( url : String ) : String;
		
		function getMetadataFileName( url : String ) : String;
		
	}
}
