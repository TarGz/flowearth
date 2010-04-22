package fr.digitas.flowearth.csseditor.managers {
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.InteractiveObject;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;		

	/**
	 * @author Pierre Lepers
	 */
	public class CssDragManager implements IFileDragManager {

		private var _do : InteractiveObject;
		
		public function init( _do : InteractiveObject ) : void {
			this._do = _do;
			_do.addEventListener( NativeDragEvent.NATIVE_DRAG_ENTER , dragEnterHandler );
			_do.addEventListener( NativeDragEvent.NATIVE_DRAG_DROP , dragDropHandler ); 
		}

		private function dragEnterHandler(evt : NativeDragEvent) : void {
			var dropFiles : Array = evt.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			if(evt.clipboard.hasFormat( ClipboardFormats.FILE_LIST_FORMAT )
				&&
				containHandledFile( dropFiles )
					) {
				NativeDragManager.acceptDragDrop( _do );
			}
		}

		private function dragDropHandler(evt : NativeDragEvent) : void {
//			NativeDragManager.dropAction = NativeDragActions.COPY;
			var dropFiles : Array = evt.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			
			for each (var file : File in dropFiles) {
				handleDropFile( file );
			}
		}

		private function handleDropFile(file : File) : void {
			switch( file.extension.toLowerCase() ) {
				case "css" :
					handleCssFile( file );
					break;
//				case "swf" :
//					handleSwfFile( file );
//					break;
//				case "ttf" :
//					handleTrueTypeFile( file );
//					break;
//				case "otf" :
//					handleTrueTypeFile( file );
//					break;
				default :
					unhandledFileFormat();
					break;
			}
		}
		
		private function handleTrueTypeFile(file : File) : void {
			var css : CSS = CSSProvider.instance.currentCss;
			if( ! css ) {
				// TODO handle no css open ,with message
				return;
			}
			
			css.fontProfile.addTrueType( file );
			
		}

		private function handleSwfFile(file : File) : void {
			var css : CSS = CSSProvider.instance.currentCss;
			if( ! css ) {
				// TODO handle no css open ,with message
				return;
			}
			Console.log( "fr.digitas.flowearth.csseditor.managers.FileDragManager - handleSwfFile -- "+file.nativePath  );
			css.fontProfile.addFont( file );
				
		}

		private function handleCssFile( file : File ) : void {
			var cssString : String = getFileContent( file );
			var css : CSS = new CSS( file.url );
			css.setPlainValue( cssString );
			css.fileSystemSync = true;
			CSSProvider.instance.addCss( css );
		}

		private function unhandledFileFormat() : void {
			
		}
		
		private function getFileContent(_file:File):String{
			var fileStream:FileStream = new FileStream();
			fileStream.open(_file, FileMode.READ);
			var fileContent:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
			fileStream.close();
			return fileContent;
		} 

		private function getFileBytes(_file : File) : ByteArray {
			var fileStream:FileStream = new FileStream();
			fileStream.open(_file, FileMode.READ);
			var fileBytes : ByteArray = new ByteArray();
			fileStream.readBytes( fileBytes, 0, fileStream.bytesAvailable);
			fileStream.close();
			return fileBytes;
		}
		
		
		
		public static function containHandledFile( fileList : Array) : Boolean {
			
			for each (var file : File in fileList) {
				if( isFontFile( file ) ) return true;
			}
			
			return false;
		}

		public static function isFontFile( file : File ) : Boolean {
			return _formats.indexOf( String( file.name.split( "." ).pop()).toLowerCase() ) > - 1;
		}

		
		
		private static const _formats : Array = [ "css" ];
		
	}
}
