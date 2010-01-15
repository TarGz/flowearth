package fr.digitas.flowearth.csseditor.io {
	import fr.digitas.flowearth.csseditor.io.IFileManager;
	
	import flash.utils.ByteArray;		

	/**
	 * @author Pierre Lepers
	 */
	public class FileManager implements IFileManager {
		
		public function saveFile( url : String, content : ByteArray ) : void {
		}
		
		public function getMetadataFileName(url : String) : String {
			return null;
		}
		
		public function loadTextFile(url : String) : String {
			return null;
		}
	}
}
