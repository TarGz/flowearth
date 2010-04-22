package fr.digitas.flowearth.csseditor.view.fontprofile {
	import fr.digitas.flowearth.csseditor.data.fonts.FontFormats;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragActions;
	import flash.desktop.NativeDragManager;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;	

	/**
	 * @author Pierre Lepers
	 */
	public class FSDragManager {

		
		
		public function FSDragManager( ) {
			
		}

		public function init( fsi : FontSourceItem ) : void {
			_fsi = fsi;
			_fsi.addEventListener( NativeDragEvent.NATIVE_DRAG_ENTER , dragEnterHandler, false, 100 );
			_fsi.addEventListener( NativeDragEvent.NATIVE_DRAG_DROP , dragDropHandler, false, 100 ); 
			_fsi.addEventListener( NativeDragEvent.NATIVE_DRAG_EXIT , dragExitHandler, false, 100 );
		}
		
		public function dispose() : void {
			_fsi.removeEventListener( NativeDragEvent.NATIVE_DRAG_ENTER , dragEnterHandler );
			_fsi.removeEventListener( NativeDragEvent.NATIVE_DRAG_DROP , dragDropHandler ); 
			_fsi.removeEventListener( NativeDragEvent.NATIVE_DRAG_EXIT , dragExitHandler );
			_fsi = null;
		}
		
		private function dragExitHandler(event : NativeDragEvent) : void {
			trace( "dragExitHandler" );
			_fsi.dropIn( false );
		}

		private function dragEnterHandler(evt : NativeDragEvent) : void {
			if(evt.clipboard.hasFormat( ClipboardFormats.FILE_LIST_FORMAT )) {
				if( FontFormats.containFontFiles( evt.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array ) ) {
					trace( "dragEnterHandler" );
					NativeDragManager.acceptDragDrop( _fsi );
					_fsi.dropIn( true );
					evt.stopImmediatePropagation();
				}
			}
		}

		private function dragDropHandler(evt : NativeDragEvent) : void {
			trace( "dragDropHandler" );
			var dropFiles : Array = evt.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			
			for each (var file : File in dropFiles) {
				if( FontFormats.isFontFile( file ) )
					_fsi.source.getConfig().addTrueType( file );
			}
			_fsi.dropIn( false );
			evt.stopImmediatePropagation();
		}
		
		
		

		private var _fsi : FontSourceItem;
	}
}
