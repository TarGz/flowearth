package fr.digitas.flowearth.csseditor.fonts {
	import flash.system.System;	
	
	import fr.digitas.flowearth.text.styles.styleManager;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontSandbox extends Sprite {
//	 implements IFontSandbox {

		public function FontSandbox() {
			trace( "SANDBOX Numero" , CONFIG::sandboxnum );
			trace( "SANDBOX fontSandbox" , Security.sandboxType );
			
			Security.allowDomain( "*" );
			_embeddedFonts = new Dictionary();
			//_updateEmbedded();
			registerMethod = Font.registerFont;
		}
		
		private var registerMethod : Function ;
		
		public function getStyledTf( styleName : Object, htmlText : String ) : TextField {
			var tf : TextField = new TextField();
			styleManager.apply(tf, styleName , htmlText );
			return tf;
		}
		
		public function loadFonts( fontFileUrl : String ) : Loader {
			var l : Loader = new Loader();
			l.contentLoaderInfo.addEventListener( Event.COMPLETE , onFontLoaded );
			
//			var req : URLRequest = new URLRequest( fontFileUrl );
			
			
			trace( fontFileUrl );
			
			var req : URLRequest = new URLRequest( fontFileUrl );
//			l.load( req, new LoaderContext( false , new ApplicationDomain(  ) ) );
			l.load( req, new LoaderContext( false , new ApplicationDomain( loaderInfo.applicationDomain ) ) );
//			l.load( req, new LoaderContext( false , loaderInfo.applicationDomain ) );
//			l.load( req, new LoaderContext( false , ApplicationDomain.currentDomain ) );
			return l;
		}
		
		public function getTf() : TextField {
			var tf : TextField = new TextField();
			tf.text = CONFIG::sandboxnum+"--";
			return tf;
		}

		private function onFontLoaded(event : Event) : void {
			var  l : Loader = event.currentTarget.loader as Loader;
			trace( "fr.digitas.flowearth.csseditor.data.fonts.FontsData - onFontLoaded -- "+ l );
//			Console.log( "fr.digitas.flowearth.csseditor.data.fonts.FontsData - onFontLoaded -- sandbox 44" + _fontSandbox );
			var list:Array = Font.enumerateFonts();
			var n:int = list.length;
			trace( CONFIG::sandboxnum, "BBBBBBBBBBOOOOOOOOOOOOOOOBBBBBBBBBBBBBB" );
			for (var i:Number = 0; i < n; i++) {
				trace( "-----------> "+(list[i] as Font).fontName );
			}
			trace( CONFIG::sandboxnum, "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB" );


			registerFonts( l.content, l.contentLoaderInfo.applicationDomain );
			
			
			list = Font.enumerateFonts();
			n = list.length;
			trace( CONFIG::sandboxnum, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" );
			for ( i = 0; i < n; i++) {
				trace( "-----------> "+(list[i] as Font).fontName );
			}
			trace( CONFIG::sandboxnum, "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" );
		}

		
		
		public function registerFonts( provider : Object , loadedDomain : ApplicationDomain) : void {
			var fonts : Array = provider.getFonts( );
			for each (var font : Class in fonts) {
				var f : Font = new font();
				trace( getQualifiedClassName( f )+"" );

				trace( ApplicationDomain.currentDomain.hasDefinition(getQualifiedClassName( f ) ) );
				trace( ApplicationDomain.currentDomain.hasDefinition(getQualifiedClassName( f ) ) );
				trace( loadedDomain.hasDefinition(getQualifiedClassName( f ) ) );
				
				trace( (f is Font).toString() );
//				registerMethod( font );
//				try {
//				} catch( e : Error ) {
//					Console.log( e.getStackTrace() );
//				}
			}
			_updateEmbedded();
		}
		
		
		private function _updateEmbedded() : void {
			var list:Array = Font.enumerateFonts();
			var n:int = list.length;
			trace( "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" );
			for (var i:Number = 0; i < n; i++) {
				_embeddedFonts[ (list[i] as Font).fontName ] = list[i];
				trace( "-----------> "+(list[i] as Font).fontName );
			}
			trace( "===========================================" );
			
		}

		private var _embeddedFonts : Dictionary;

	}
}
