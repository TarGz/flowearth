package fr.digitas.flowearth.csseditor {
	import fr.digitas.flowearth.csseditor.view.menu.AppMenu;	
	import fr.digitas.flowearth.csseditor.view.fontprofile.FontDetailsManager;	
	import fr.digitas.flowearth.csseditor.view.console.Console;	
	import fr.digitas.flowearth.csseditor.fonts.FontsSystem;
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.io.FileManager;
	import fr.digitas.flowearth.csseditor.io.IFileManager;
	import fr.digitas.flowearth.csseditor.managers.FileDragManager;	

	/**
	 * @author Pierre Lepers
	 */
	public class App {

		public static function run( main : Main ) : void {
			
			CSSProvider.start();
			
			new Console( );
			new FileDragManager().init( main );
			FontDetailsManager.start();
			
			main.stage.nativeWindow.menu = new AppMenu();
			
		}

		
		public static function getFileManager() : IFileManager {
			if( ! _fileManager )
				_fileManager = new FileManager();
			return _fileManager;
		}
		
		public static function getFontSystem() : FontsSystem {
			if( ! _fontSystem ) 
				_fontSystem = new FontsSystem( );
			return _fontSystem;
		}
		
		private static var _fontSystem : FontsSystem;
		
		private static var _fileManager : IFileManager;
	}
}
