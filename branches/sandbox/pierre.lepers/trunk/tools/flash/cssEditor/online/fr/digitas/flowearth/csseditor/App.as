package fr.digitas.flowearth.csseditor {
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.fonts.FontsSystem;
	import fr.digitas.flowearth.csseditor.io.FileManager;
	import fr.digitas.flowearth.csseditor.io.IFileManager;	

	/**
	 * @author Pierre Lepers
	 */
	public class App {

		public static function run( ) : void {
			
			CSSProvider.start();
			
//			new FileDragManager().init( main );
		}

		public static function getFileManager() : IFileManager {
			return new FileManager();
		}
		
		public static function getFontSystem() : FontsSystem {
			return null;
		}
	}
}
