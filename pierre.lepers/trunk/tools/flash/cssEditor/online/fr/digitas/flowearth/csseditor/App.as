package fr.digitas.flowearth.csseditor {
	import fr.digitas.flowearth.csseditor.io.FileManager;	
	import fr.digitas.flowearth.csseditor.io.IFileManager;	
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.managers.FileDragManager;		

	/**
	 * @author Pierre Lepers
	 */
	public class App {

		public static function run( main : Main ) : void {
			
			CSSProvider.start();
			
			new FileDragManager().init( main );
		}

		public static function getFileManager() : IFileManager {
			return new FileManager();
		}
	}
}
