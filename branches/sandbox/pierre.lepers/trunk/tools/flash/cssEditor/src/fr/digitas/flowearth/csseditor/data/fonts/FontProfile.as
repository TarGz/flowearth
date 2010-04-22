package fr.digitas.flowearth.csseditor.data.fonts {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	
	import flash.events.EventDispatcher;
	import flash.filesystem.File;	

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
				fs.unload( );
		}

		
		
		public function addFont( file : File ) : FontSource {
			var fontSource : FontSource = new FontSource( file );
			addFontSource( fontSource );
			return fontSource;
		}
		
		public function removeSource( fontSource : FontSource ) : Boolean {
			var index : int = _aFonts.indexOf( fontSource  );
			if( index == -1 ) return false;
			fontSource.unload();
			fontSource.removeEventListener( FontEvent.FILE_CHANGE , onSourceFileChange );
			_aFonts.splice( index, 1 );
			dispatchEvent( new FontEvent( FontEvent.FONT_REMOVED , fontSource ) );
			return true;
			
		}

		
		
		private function addFontSource( fontSource : FontSource ) : void {
			fontSource.setProfile( this );
			_aFonts.push( fontSource );
			fontSource.addEventListener( FontEvent.FILE_CHANGE , onSourceFileChange );
			dispatchEvent( new FontEvent( FontEvent.FONT_ADDED , fontSource ) );
		}
		
		private function onSourceFileChange(event : FontEvent) : void {
			dispatchEvent( event );
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
				if( fs.configurable( ) )
					fsItem.appendChild( fs.getConfig( ).export( ) );
				exp.appendChild( fsItem );
				fsItemPath.appendChild( getRelativePath( fs ) );
			}
			
			return exp;
		}

		private function getRelativePath( fSource : FontSource ) : String {
			return new File( _css.filepath ).getRelativePath( fSource.file , true );
		}

		private var _aFonts : Array;

		private var _css : CSS;

		public function get sources() : IIterator {
			return new Iterator( _aFonts );
		}

		public function parse( datas : XML ) : void {
			var fontFile : File;
			var _cssFile : File = new File( _css.filepath );
			var fs : FontSource;
			for each (var sdata : XML in datas.source ) {
				fontFile = _cssFile.resolvePath( sdata.path );
				fs = new FontSource( fontFile );
				fs._import( sdata );
				addFontSource( fs );
			}
		}

		public function hasFontFile(f : File) : Boolean {
			for each (var fs : FontSource in _aFonts) {
				if( fs.file.nativePath == f.nativePath ) return true;
			}
			return false;
		}

		public function addNewFont( prefix : String = "untitled" ) : FontSource {
			var fdir : File = new File( _css.filepath ).parent;
			var f : File;
			var c : int = -1;
			var cstr : String = "";
			while( true ) {
				f = fdir.resolvePath( prefix + c + ".swf" );
				if( ! f.exists && ! hasFontFile( f ) ) break;
				c ++;
				cstr = c.toString();
			}
			
			var fs : FontSource = addFont( f );
			fs.getConfig().className = "com.digitas.csseditor.default.UntitledFont"+c;
			return fs;
		}
		
		public function addTrueType( ttf : File ) : void {
			var fs : FontSource = addNewFont( ttf.name.split( "." )[0] );
			fs.addTrueType( ttf );
		}
		
		public function rebuildAll() : void {
			for each (var fs : FontSource in _aFonts) { 
				if( !fs.configurable() ) continue;
				fs.unload( );
				fs.getConfig().build();
			}
		}
		
		
		
		public function set selectedSource ( source : FontSource ) : void {
			if( _selectedSource == source) return;
			_selectedSource = source;
			dispatchEvent( new FontEvent( FontEvent.SELECTION_CHANGE , source ) );
		}
		public function get selectedSource ( ) :  FontSource {
			return _selectedSource;
		}
				
		private var _selectedSource :  FontSource;
		
		
	}
}
