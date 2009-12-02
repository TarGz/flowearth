package fr.digitas.flowearth.csseditor.data.fonts {
	import fr.digitas.flowearth.text.fonts.IFontsProvider;	
	import fr.digitas.flowearth.csseditor.fonts.IFontSandbox;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontsData {

		
		
		
		public function FontsData() {
			_build( );
		}

		public function loadFonts( fontFileUrl : String ) : void {
			var l : Loader = new Loader();
			l.contentLoaderInfo.addEventListener( Event.COMPLETE , onFontLoaded );
			
			var req : URLRequest = new URLRequest( fontFileUrl );
			l.load( req, new LoaderContext( false, ApplicationDomain.currentDomain ) );
		}
		
		private function onFontLoaded(event : Event) : void {
			var  l : Loader = event.currentTarget.loader as Loader;
			Console.log( "fr.digitas.flowearth.csseditor.data.fonts.FontsData - onFontLoaded -- "+ l );
			Console.log( "fr.digitas.flowearth.csseditor.data.fonts.FontsData - onFontLoaded -- sandbox 44" + _fontSandbox );
			_fontSandbox.registerFonts( l.content as IFontsProvider );
		}

		public function get fontDomain() : ApplicationDomain {
			return _fontDomain;
		}
		
		public function get fontSandbox() : IFontSandbox {
			return _fontSandbox;
		}
		
		private function _build() : void {
			_fontDomain = ApplicationDomain.currentDomain;
//			_fontDomain = new ApplicationDomain( ApplicationDomain.currentDomain );
			_loadSandbox( );
		}
		
		private function _loadSandbox() : void {
			var l : Loader = new Loader();
			l.contentLoaderInfo.addEventListener( Event.COMPLETE , onSandboxLoaded );
			
			var req : URLRequest = new URLRequest( File.applicationStorageDirectory.resolvePath( SANDBOX_SWF ).nativePath );
			l.load( req, new LoaderContext( false, ApplicationDomain.currentDomain ) );
//			l.loadBytes( getSandboxBytes(), new LoaderContext( false, _fontDomain ) );
		}

		private function onSandboxLoaded(event : Event) : void {
			var  l : Loader = event.currentTarget.loader as Loader;
			_fontSandbox = IFontSandbox( l.content );
			Console.log( "fr.digitas.flowearth.csseditor.data.fonts.FontsData - onSandboxLoaded -- "+_fontSandbox );
		}

		private var _fontDomain : ApplicationDomain;

		private var _fontSandbox : IFontSandbox;

		
		private static function getSandboxBytes() : ByteArray {
			if( ! _sandboxBytes ) {
				_sandboxBytes = new ByteArray();
				var file : File = File.applicationStorageDirectory.resolvePath( SANDBOX_SWF );
				Console.log( "sandboxFile : "+ file.nativePath );
				var fileStream:FileStream = new FileStream();
				fileStream.open( file, FileMode.READ);
				fileStream.readBytes( _sandboxBytes, 0, fileStream.bytesAvailable);
				fileStream.close();
			}
			return _sandboxBytes;
		}
		
		private static var _sandboxBytes : ByteArray;

		private static const SANDBOX_SWF : String = "fontSandbox.swf";
		
	}
}
