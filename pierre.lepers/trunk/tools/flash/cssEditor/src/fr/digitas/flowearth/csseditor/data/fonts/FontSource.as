package fr.digitas.flowearth.csseditor.data.fonts {
	import fr.digitas.flowearth.csseditor.event.FontEvent;	
	
	import flash.events.EventDispatcher;	
	
	import fr.digitas.flowearth.core.Iterator;	
	import fr.digitas.flowearth.core.IIterator;	
	import fr.digitas.flowearth.text.fonts.IFontsProvider;	
	
	import flash.filesystem.File;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class FontSource extends EventDispatcher {

		
		public function FontSource( file : File ) {
			_file = file;
		}
		
		public function get file() : File {
			return _file;
		}
		
		public function unload() : void {
			_loaded = false;
		}

		public function get loaded() : Boolean {
			return _loaded;
		}


		public function setFontProvider(_fontProvider : IFontsProvider) : void {
			_loaded = true;
			_afonts = _fontProvider.getFonts().concat();
			dispatchEvent( new FontEvent( FontEvent.FONT_LOADED ) );
		}

		private var _afonts : Array;

		private var _loaded : Boolean;

		private var _file : File;
		
		public function get fonts() : IIterator {
			return new Iterator( _afonts ); 
		}
	}
}
