package fr.digitas.flowearth.csseditor.data.fonts {
	import fr.digitas.flowearth.font.FontFileInfo;	
	
	import flash.text.FontStyle;	
	
	import fr.digitas.flowearth.font.FontInfo;	
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.font.FontFileConfig;
	import fr.digitas.flowearth.text.fonts.IFontsProvider;
	
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.text.Font;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontSource extends EventDispatcher {

		
		public function FontSource( file : File ) {
			_file = file;
			if( !builded() ) {
				createConfig();
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
			dispatchEvent( new FontEvent( FontEvent.FONT_UNLOADED, this ) );
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

		public function getInfos() : FontFileInfo {
			return _info;
		}
		
		
		public function setFontProvider(_fontProvider : IFontsProvider) : void {
			_loaded = true;
			_afonts = _fontProvider.getFonts().concat();
			_buildFontInfos();
			dispatchEvent( new FontEvent( FontEvent.FONT_LOADED, this ) );
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
		
		public function dispose() : void {
			_profile = null;
		}

		
		
		
		private var _afonts : Array;

		private var _loaded : Boolean;

		private var _file : File;
		
		private var _config : FontFileConfig;

		private var _info : FontFileInfo;

		private var _profile : FontProfile;
		
		private function _buildFontInfos() : void {
			
			_info = new FontFileInfo( _file );
			_info.init( _afonts );
			
		}

		
		internal function _import(sdata : XML) : void {
			
			if( sdata.config.length() > 0 ) {
				if( ! _config )
					createConfig();
				_config._import( sdata.config[0] );
			}
		}
		
		internal function setProfile(profile : FontProfile) : void {
			_profile = profile;
		}
		
		private function createConfig() : void {
			if( _config ) {
				_config.removeEventListener( FontEvent.FILE_CHANGE , onConfigBuilded );
			}
			_config = new FontFileConfig( );
			_config.addEventListener( FontEvent.FILE_CHANGE , onConfigBuilded );
		}
		
		private function onConfigBuilded(event : FontEvent) : void {
			unload();
			dispatchEvent( new FontEvent( FontEvent.FILE_CHANGE, this ) );
		}
		
	}
	
}
