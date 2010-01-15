package fr.digitas.flowearth.csseditor.data.fonts {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.font.FontFileConfig;
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	
	import flash.events.EventDispatcher;
	import flash.filesystem.File;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontSource extends EventDispatcher {

		
		public function FontSource( file : File ) {
			_file = file;
			if( !builded() ) {
				_config = new FontFileConfig();
				_config.output = file;
				_file = null;
			}
		}
		
		public function get profile() : FontProfile {
			return _profile;
		}

		public function get file() : File {
			if( _config )
				return _config.output;
			return _file;
		}
		
		public function unload() : void {
			_loaded = false;
		}

		public function get loaded() : Boolean {
			return _loaded;
		}
		
		
		public function builded() : Boolean {
			return file.exists;
		}

		public function configurable() : Boolean {
			return ( _config != null );
		}

		public function getConfig() : FontFileConfig {
			return _config;
		}
		
		
		public function setFontProvider(_fontProvider : IFontsProvider) : void {
			_loaded = true;
			_afonts = _fontProvider.getFonts().concat();
			dispatchEvent( new FontEvent( FontEvent.FONT_LOADED ) );
		}
		
		public function addTrueType( ttf : File ) : void {
			if( !configurable() ) throw new Error( "FontSource - addTrueType to unconfigurable source" );
			_config.addTrueType( ttf );
		}

		public function get fonts() : IIterator {
			return new Iterator( _afonts ); 
		}
		
		public function selected() : Boolean {
			return _profile.selectedSource == this;
		}

		
		
		private var _afonts : Array;

		private var _loaded : Boolean;

		private var _file : File;
		
		private var _config : FontFileConfig;
		
		private var _profile : FontProfile;
		
		
		internal function _import(sdata : XML) : void {
			
			if( sdata.config.length() > 0 ) {
				if( ! _config )
					_config = new FontFileConfig( );
				_config._import( sdata.config[0] );
			}
		}
		
		internal function setProfile(profile : FontProfile) : void {
			_profile = profile;
		}
		
	}
}
