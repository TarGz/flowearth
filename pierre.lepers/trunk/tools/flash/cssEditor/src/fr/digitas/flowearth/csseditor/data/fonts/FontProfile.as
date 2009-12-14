package fr.digitas.flowearth.csseditor.data.fonts {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontProfile extends EventDispatcher {

		
		
		public function FontProfile( css : CSS ) {
			_css = css;
			_aFonts = [];
		}
		
		public function unload() : void {
			for each (var fs : FontSource in _aFonts) 
				fs.unload();
		}

		
		
		public function addFont( file : File ) : void {
			var fontSource : FontSource = new FontSource( file );
			_aFonts.push( fontSource );
			dispatchEvent( new FontEvent( FontEvent.FONT_ADDED ) );
		}
		
		public function export() : XML {
			var exp : XML = <fontProfile/>;
			
			var 
			fsItem : XML, 
			fsItemPath : XML,
			fsItemName : XML;
			
			for each (var fs : FontSource in _aFonts) {
				fsItem = <source/>;
				fsItemPath = <path/>;
				fsItemName = <name/>;
				fsItem.appendChild( fsItemName );
				fsItem.appendChild( fsItemPath );
				exp.appendChild( fsItem );
				fsItemPath.appendChild( getRelativePath( fs ) );
			}
			
			return exp;
		}
		
		private function getRelativePath( fSource : FontSource ) : String {
			return new File( _css.filepath ).getRelativePath(fSource.file , true );
		}

		private var _aFonts : Array;

		private var _css : CSS;
		
		public function get sources() : IIterator {
			return new Iterator( _aFonts );
		}
		
		public function parse( datas : XML ) : void {
			var fontFile : File;
			var _cssFile : File = new File( _css.filepath );
			for each (var sdata : XML in datas.source ) {
				fontFile = _cssFile.resolvePath( sdata.path );
				if( ! fontFile.exists )
					throw new Error( "Une font du profile est introuvable : "+ sdata.path );
				addFont( fontFile );
			}
		}
	}
}
