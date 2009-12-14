package fr.digitas.flowearth.csseditor.fonts {
	import fr.digitas.flowearth.csseditor.data.fonts.FontSource;	
	import fr.digitas.flowearth.text.styles.styleManager;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontSandbox extends Sprite {

		public function FontSandbox() {
			_loaders = [];
		}
		
		private var registerMethod : Function ;

		public function getStyledTf( styleName : Object, htmlText : String ) : TextField {
			var tf : TextField = new TextField();
			styleManager.apply(tf, styleName , htmlText );
			return tf;
		}
		
	
		public function loadFonts( fSource : FontSource ) : FontSourceLoader {
			var l : FontSourceLoader = new FontSourceLoader( fSource );
			l.addEventListener( Event.COMPLETE , onFontLoaded );
			_loaders.push( l );
			l.load();
			return l;
		}

		
		
		
		
		public function getTf() : TextField {
			var tf : TextField = new TextField();
			listFonts( "grab textField" );
			tf.text = "--";
			return tf;
		}
		
		
		public function cleanup() : void {
			while( _loaders.length > 0 ) 
				(_loaders.pop( ) as FontSourceLoader ).unload();
			
		}

		private function onFontLoaded(event : Event) : void {
			var  l : FontSourceLoader = event.currentTarget as FontSourceLoader;
			var ind : int = _loaders.indexOf( l );
			_loaders.splice( ind, 1 );
			
			registerFonts( l.fontProvider );
			
		}
		
		private function listFonts( msg : String ) : void {
			var list:Array = Font.enumerateFonts();
			var n:int = list.length;
			trace( msg );
			for ( var i : int = 0; i < n; i++) {
				trace( "-----------> "+(list[i] as Font).fontName );
			}
			
		}

		
		
		public function registerFonts( provider : Object ) : void {
			var fonts : Array = provider.getFonts( );
			for each (var font : Class in fonts) 
				Font.registerFont( font );
			
		}
		

		private var _loaders : Array;
		
	}
}
