package fr.digitas.flowearth.csseditor.fonts {
	import fr.digitas.flowearth.text.fonts.IFontsProvider;	
	import fr.digitas.flowearth.csseditor.data.fonts.FontSource;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontSourceLoader extends EventDispatcher {

		
		public function FontSourceLoader( source : FontSource ) {
			_source = source;
			super( );
		}
		
		public function get fontProvider() : IFontsProvider {
			return _fontProvider;
		}
		
		public function unload() : void {
			if( _loader ) 
				_loader.unload();
			
		}

		
		
		public function load() : void {
			if( _loader )
				throw new Error( "fr.digitas.flowearth.csseditor.fonts.FontSourceLoader - already loaded" );
		
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE , onComplete );
			var ctx : LoaderContext = new LoaderContext( false , new ApplicationDomain( ApplicationDomain.currentDomain ) );
			ctx.allowLoadBytesCodeExecution = true;
			_loader.loadBytes( getSourceBytes() , ctx );
		}
		
		private function onComplete(event : Event) : void {
			_fontProvider = _loader.content as IFontsProvider;
			if( ! _fontProvider ) 
				throw new Error( "Unexpected font file format: " + _source.file.nativePath );
			
			_source.setFontProvider( _fontProvider );
			dispatchEvent( new Event( Event.COMPLETE  ) );
		}

		private function getSourceBytes() : ByteArray {
			var fileStream:FileStream = new FileStream();
			fileStream.open(_source.file, FileMode.READ);
			var fileBytes : ByteArray = new ByteArray();
			fileStream.readBytes( fileBytes, 0, fileStream.bytesAvailable);
			fileStream.close();
			return fileBytes;
		}
		
		private var _fontProvider : IFontsProvider;

		private var _source : FontSource;
		
		private var _loader : Loader;
		
	}
}
