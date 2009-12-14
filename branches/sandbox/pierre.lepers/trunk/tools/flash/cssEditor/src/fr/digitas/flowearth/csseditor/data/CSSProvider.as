package fr.digitas.flowearth.csseditor.data {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.csseditor.App;
	import fr.digitas.flowearth.csseditor.event.CSSEvent;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class CSSProvider extends EventDispatcher {

		
		
		public function CSSProvider() {
			if( instance != null ) throw new Error( "fr.digitas.flowearth.csseditor.data.CSSProvider est deja instancié" );
			_dCss = new Dictionary( );
			_aCss = [];
			
			NativeApplication.nativeApplication.addEventListener( Event.EXITING, onExit );
			loadStore( );
		}
		

		
		public function addCss(css : CSS) : void {
			if( _dCss[ css.filepath ] != undefined ) {
				currentCss = _dCss[ css.filepath ];
				return;
			}
			_dCss[ css.filepath ] = css;
			_aCss.push( css );
			dispatchEvent( new CSSEvent( CSSEvent.ADDED, css ) );
			
			if( currentCss == null ) currentCss = css;
		}

		public function removeCss( css : CSS ) : void {
			Console.log( "fr.digitas.flowearth.csseditor.data.CSSProvider - removeCss -- "+css.filepath );
			if( _dCss[ css.filepath ] == undefined ) 
				 return;
				
			delete _dCss[ css.filepath ];
			_aCss.splice( _aCss.indexOf( css ) , 1 );
			dispatchEvent( new CSSEvent( CSSEvent.REMOVED, css ) );
			if( currentCss == css ) {
				if( _aCss.length>0 ) currentCss = _aCss[0];
				else currentCss = null;
			}
		}
		
		public function getAllCss() : IIterator {
			return new Iterator( _aCss );
		}

		
		
		//_____________________________________________________________________________
		//																		 currentCSS
		public function set currentCss ( css :  CSS ) : void {
			if( _currentCss ==css) return;
			_currentCss = css;
			dispatchEvent( new CSSEvent( CSSEvent.CURRENT_CHANGE , _currentCss ) );
		}
		
		public function get currentCss ( ) : CSS {
			return _currentCss;
		}
		
		
		private function loadStore() : void {
			var storeFile : File = new File( STORE );
			if( ! storeFile.exists ) return;
			var fileStream:FileStream = new FileStream();
			fileStream.open(storeFile, FileMode.READ);
			var fileBytes : ByteArray = new ByteArray();
			fileStream.readBytes( fileBytes, 0, fileStream.bytesAvailable);
			fileStream.close();
			fileBytes.position = 0;
			var storeDatas : XML = new XML( fileBytes.readUTFBytes( fileBytes.bytesAvailable ) );
			var cssString : String;
			var css : CSS;
			var cssFile : File;
			for each (var openFile : XML in storeDatas.openfiles.file ) {
				cssFile = new File( openFile.text() );
				if( ! cssFile.exists ) continue;
				fileStream = new FileStream();
				fileStream.open( cssFile , FileMode.READ);
				cssString = fileStream.readUTFBytes(fileStream.bytesAvailable);
			
				css = new CSS( cssFile.url );
				css.setPlainValue( cssString );
				css.fileSystemSync = true;
				addCss( css );
			}
		}
		
		private function onExit(event : Event) : void {
			var store : XML = <config/>;
			var openFiles : XML = <openfiles/>;
			var openFile : XML;
			store.appendChild( openFiles );
			var iter : IIterator = getAllCss();
			var css : CSS;
			while( iter.hasNext() ) {
				openFile = <file/>;
				css	= iter.next() as CSS;
				openFile.appendChild( css.filepath );
				openFiles.appendChild( openFile );
			}
			
			var storeBa : ByteArray = new ByteArray( );
			storeBa.writeUTFBytes( store.toXMLString() );
			App.getFileManager().saveFile( STORE , storeBa );
		}
				
		private var _currentCss : CSS;
				
		

		private var _dCss : Dictionary;
		private var _aCss : Array;
		
		
		public static var instance : CSSProvider;
		
		public static function start( ) : CSSProvider {
			if (instance == null)
				instance = new CSSProvider();
			return instance;
		}
		
		private static const STORE : String = "app-storage:/store.xml";
	}
}
