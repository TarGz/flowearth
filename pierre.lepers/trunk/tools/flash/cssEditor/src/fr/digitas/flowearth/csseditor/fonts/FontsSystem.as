package fr.digitas.flowearth.csseditor.fonts {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.data.fonts.FontProfile;
	import fr.digitas.flowearth.csseditor.data.fonts.FontSource;
	import fr.digitas.flowearth.csseditor.event.CSSEvent;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;
	import flash.utils.ByteArray;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontsSystem extends EventDispatcher {

		
		
		
		public function FontsSystem() {
			_build( );
			CSSProvider.instance.addEventListener( CSSEvent.CURRENT_CHANGE , onCurrentCssChange );
			onCurrentCssChange( null );
		}
		
		private function onCurrentCssChange(event : CSSEvent) : void {
			if( CSSProvider.instance.currentCss )
				registerProfile( CSSProvider.instance.currentCss.fontProfile );
		}

		
		public function getSandboxedTf() : TextField {
			if( ! _fontSandbox ) return null;
			return _fontSandbox.getTf( );
		}
		
		public function registerProfile( profile : FontProfile ) : void {
			
			_fontSandbox.cleanup();
			
			if( _currentProfile ) {
				_currentProfile.unload();
				_currentProfile.removeEventListener( FontEvent.FONT_ADDED , loadProfile );
			}
			_currentProfile = profile;
			_watchers = [];
			if( ! _currentProfile ) return;
			
			_currentProfile.addEventListener( FontEvent.FONT_ADDED , loadProfile );
			loadProfile();
		}
		
		private function loadProfile(event : FontEvent = null ) : void {
			var iter : IIterator = _currentProfile.sources;
			var source : FontSource;
			while( source	= iter.next() as FontSource ) {
				if( !source.loaded ) loadFonts( source );
			}
		}

		
		
		public function loadFonts( source : FontSource ) : void {
			var l : FontSourceLoader = _fontSandbox.loadFonts( source );
			l.addEventListener( Event.COMPLETE , onFontLoaded, false, -100 );
		}

		private var _currentProfile : FontProfile;
		
		private function onFontLoaded(event : Event) : void {
			dispatchEvent( new FontEvent( FontEvent.FONT_LOADED ) );
		}

		public function get fontSandbox() : Object {
			return _fontSandbox;
		}
		
		private function _build() : void {
			_fontSandbox = new FontSandbox();
			dispatchEvent( new FontEvent( FontEvent.SANDBOX_READY ) );
		}
		

		private var _fontSandbox : FontSandbox;

		private var _watchers : Array;
		
	}
}
