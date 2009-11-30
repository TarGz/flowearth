package fr.digitas.flowearth.csseditor.managers {
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.data.CSSProvider;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragActions;
	import flash.desktop.NativeDragManager;
	import flash.display.InteractiveObject;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;		

	/**
	 * @author Pierre Lepers
	 */
	public class FileDragManager {

		private var _do : InteractiveObject;
		
		public function init( _do : InteractiveObject ) : void {
			this._do = _do;
			_do.addEventListener( NativeDragEvent.NATIVE_DRAG_ENTER , dragEnterHandler );
			_do.addEventListener( NativeDragEvent.NATIVE_DRAG_DROP , dragDropHandler ); 
		}

		private function dragEnterHandler(evt : NativeDragEvent) : void {
			if(evt.clipboard.hasFormat( ClipboardFormats.FILE_LIST_FORMAT )) {
				NativeDragManager.acceptDragDrop( _do );
			}
		}

		private function dragDropHandler(evt : NativeDragEvent) : void {
			NativeDragManager.dropAction = NativeDragActions.COPY;
			var dropFiles : Array = evt.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			
			for each (var file : File in dropFiles) {
				handleDropFile( file );
			}
		}

		private function handleDropFile(file : File) : void {
			switch( file.extension ) {
				case "css" :
					handleCssFile( file );
					break;
				case "swf" :
					handleSwfFile( file );
					break;
				default :
					unhandledFileFormat();
					break;
			}
		}

		private function handleSwfFile(file : File) : void {
			
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
		
	}
}
