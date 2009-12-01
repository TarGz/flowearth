package fr.digitas.flowearth.csseditor.data {
	import fr.digitas.flowearth.csseditor.App;
	import fr.digitas.flowearth.csseditor.data.builder.CSSBuilder;
	import fr.digitas.flowearth.csseditor.data.builder.CSSParser;
	import fr.digitas.flowearth.csseditor.event.CSSEvent;
	import fr.digitas.flowearth.csseditor.io.IFileManager;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	import fr.digitas.flowearth.text.styles.styleManager;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;	

	/**
	 * @author Pierre Lepers
	 */
	public class CSS extends EventDispatcher {

		
		
		
		public function CSS( filepath : String = null ) {
			if( ! filepath )
				_filepath = getTempFilePath();
			else
				_filepath = filepath;
			
			_datas = new CSSData( );
			_datas.addEventListener( Event.CHANGE , onDatasChange );
//			_file = file;
		}
		
		
		public function get fileSystemSync() : Boolean {
			return _fileSystemSync;
		}
		
		public function set fileSystemSync(fileSystemSync : Boolean) : void {
			if( _fileSystemSync == fileSystemSync ) return;
			_fileSystemSync = fileSystemSync;
			dispatchEvent( new CSSEvent( CSSEvent.FILE_SYNC, this ) );
		}
		
		
		public function get filepath() : String {
			return _filepath;
		}
		
		public function set filepath(filepath : String) : void {
			if( _filepath == filepath ) return;
			unregister();
			_filepath = filepath;
			dispatchEvent( new CSSEvent( CSSEvent.PATH_CHANGE, this ) );
		}
		
		public function invalidate() : void {
			_plainValue = null;
			dispatchEvent( new CSSEvent( CSSEvent.INVALIDATE , this ) );
		}
		
		public function getPlainValue() : String {
			if( ! _plainValue ) 
				_plainValue = CSSBuilder.build( _datas );
			return _plainValue;
		}

		public function setPlainValue( val : String) : void {
			CSSParser.parse( val, _datas );
			
		}
		
		public function get datas() : CSSData {
			return _datas;
		}
		
		public function save() : void {
			var fm : IFileManager = App.getFileManager();
			var cssBa : ByteArray = new ByteArray( );
			cssBa.writeUTFBytes( getPlainValue() );
			fm.saveFile( filepath , cssBa );
			fileSystemSync = true;
		}
		
		public function close( force : Boolean = false ) : void {
			if( ! force && ! _fileSystemSync ) {
				// TODO alert JS
				Console.log( "JS popup for closing "+filepath );
				return;
			}
			CSSProvider.instance.removeCss( this );
			dispatchEvent( new Event( Event.CLOSE ) );
		}

		private function onDatasChange(event : Event) : void {
			invalidate();
			fileSystemSync = false;
		}
		
		private function getTempFilePath() : String {
			return "Untitled-"+getUnique();
		}

		
		private function register() : void {
			unregister( );
			styleManager.addCss( getPlainValue() , _filepath , _filepath );
		}

		private function unregister() : void {
			styleManager.deleteCss( _filepath );
		}

		private var _plainValue : String;

		private var _filepath : String;
		
		private var _datas : CSSData;

		private var _fileSystemSync : Boolean = false;

		
		
		//_____________________________________________________________________________
		//																		 UNIQUE
		private static var UNIQUE : int = 0;

		private static function getUnique() : int {
			return UNIQUE++;
		}
		
	}
}
