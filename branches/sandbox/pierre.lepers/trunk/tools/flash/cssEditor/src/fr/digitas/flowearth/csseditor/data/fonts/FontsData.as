package fr.digitas.flowearth.csseditor.data.fonts {
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.Font;
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontsData extends EventDispatcher {

		
		
		
		public function FontsData() {
			_build( );
		}
		
		
		public function getSandboxedTf() : TextField {
			if( ! _fontSandbox ) return null;
			return _fontSandbox.getTf();
		}
		
		public function loadFonts( fontFileUrl : String ) : void {
			var l : Loader = _fontSandbox.loadFonts( fontFileUrl );
			l.contentLoaderInfo.addEventListener( Event.COMPLETE , onFontLoaded, false, -100 );
		}

		//		public function loadFonts( fontFileUrl : String ) : void {
//			var l : Loader = new Loader();
//			l.contentLoaderInfo.addEventListener( Event.COMPLETE , onFontLoaded );
//			
////			var req : URLRequest = new URLRequest( fontFileUrl );
//			Console.log( File.applicationStorageDirectory.nativePath );
//			
//			fontFileUrl = fontFileUrl.replace(File.applicationStorageDirectory.nativePath, "app-storage:/" );
//			fontFileUrl = fontFileUrl.replace(File.applicationDirectory.nativePath, "app:/" );
//			
//			Console.log( fontFileUrl );
//			
//			var req : URLRequest = new URLRequest( fontFileUrl );
//			l.load( req, new LoaderContext( false, _fontDomain ) );
//		}
//		
		private function onFontLoaded(event : Event) : void {
			
//			Preview.showPreview( _fontSandbox.getTf(), "FontA", "Salut Toto");
			dispatchEvent( new FontEvent( FontEvent.SANDBOX_READY ) );
			
			var list:Array = Font.enumerateFonts();
			var n:int = list.length;
			Console.log( "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT" );
			for (var i:Number = 0; i < n; i++) {
				Console.log( "-----------> "+(list[i] as Font).fontName );
			}
			Console.log( "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT" );
		}

		public function get fontDomain() : ApplicationDomain {
			return _fontDomain;
		}
		
		public function get fontSandbox() : Object {
			return _fontSandbox;
		}
		
		private function _build() : void {
			_fontDomain = new ApplicationDomain( );
//			_fontDomain = new ApplicationDomain( ApplicationDomain.currentDomain );
			_loadSandbox( );
		}
		
		private function _loadSandbox() : void {
			var l : Loader = new Loader();
			l.contentLoaderInfo.addEventListener( Event.COMPLETE , onSandboxLoaded );
			
			l.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR  , onerror );
			l.contentLoaderInfo.addEventListener( IOErrorEvent.DISK_ERROR , onerror );
			l.contentLoaderInfo.addEventListener( IOErrorEvent.NETWORK_ERROR , onerror );
			l.contentLoaderInfo.addEventListener( IOErrorEvent.VERIFY_ERROR , onerror );
			l.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR , onerror );
			
			
			Console.log( "app dir "+File.applicationDirectory.nativePath );
//			var req : URLRequest = new URLRequest( SANDBOX_SWF );
//			var req : URLRequest = new URLRequest( File.applicationDirectory.resolvePath( "deploy/fontSandbox.swf" ).nativePath );
//			var req : URLRequest = new URLRequest( File.applicationDirectory.resolvePath( "deploy/fontSandbox"+Count+".swf" ).nativePath );
			var req : URLRequest = new URLRequest( File.applicationStorageDirectory.resolvePath( "deploy/fontSandbox"+Count+".swf" ).nativePath );
			Console.log( req.url );
			Count++;
			l.load( req , new LoaderContext( false , _fontDomain ) );
//			l.loadBytes( getSandboxBytes(), new LoaderContext( false, _fontDomain ) );
		}
		
		private function onerror( event : ErrorEvent ) : void {
			Console.log( "fr.digitas.flowearth.csseditor.data.fonts.FontsData - onerror 1-- "+ event.text );
			
		}

		private function onSandboxLoaded(event : Event) : void {
			var  l : Loader = event.currentTarget.loader as Loader;
			Console.log( "fr.digitas.flowearth.csseditor.data.fonts.FontsData - onSandboxLoaded 1-- "+l.content );
			_fontSandbox = l.content;
			dispatchEvent( new FontEvent( FontEvent.SANDBOX_READY ) );
			Console.log( "fr.digitas.flowearth.csseditor.data.fonts.FontsData - onSandboxLoaded 2-- "+_fontSandbox );
		}

		private var _fontDomain : ApplicationDomain;

		private var _fontSandbox : Object;
		
		private static var Count : int = 0;
		
		private static const SANDBOX_SWF : String = "app:/deploy/fontSandbox.swf";
		
	}
}
