package fr.digitas.flowearth.csseditor.io {
	import fr.digitas.flowearth.csseditor.view.console.Console;	
	import fr.digitas.flowearth.csseditor.io.IFileManager;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;		

	/**
	 * @author Pierre Lepers
	 */
	public class FileManager implements IFileManager {
		
		public function saveFile( url : String, content : ByteArray ) : void {
			var f : File = new File( url );
			var fs:FileStream = new FileStream();
			
			try {
				fs.open( f , FileMode.WRITE );
				fs.writeBytes( content );
			} catch( e : Error ) {
				Console.log( e.getStackTrace() );
			} finally {
				fs.close();
			}
			
		}

		public function getMetadataFileName( url : String ) : String {
			var f : File = new File( url );
			return f.parent.resolvePath( f.name+"_"+f.extension +".meta" ).nativePath;
		}
	}
}
