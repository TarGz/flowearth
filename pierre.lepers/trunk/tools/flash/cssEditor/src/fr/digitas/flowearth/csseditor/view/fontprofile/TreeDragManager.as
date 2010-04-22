package fr.digitas.flowearth.csseditor.view.fontprofile {
	import fr.digitas.flowearth.csseditor.data.CSSProvider;	
	
	import flash.display.InteractiveObject;	
	
	import fr.digitas.flowearth.csseditor.data.fonts.FontFormats;
	
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragActions;
	import flash.desktop.NativeDragManager;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;	

	/**
	 * @author Pierre Lepers
	 */
	public class TreeDragManager {

		
		
		public function TreeDragManager( ) {
			
		}

		public function init( object : InteractiveObject ) : void {
			_object = object;
			_object.addEventListener( NativeDragEvent.NATIVE_DRAG_ENTER , dragEnterHandler, false, 100 );
			_object.addEventListener( NativeDragEvent.NATIVE_DRAG_DROP , dragDropHandler, false, 100 ); 
			_object.addEventListener( NativeDragEvent.NATIVE_DRAG_EXIT , dragExitHandler, false, 100 );
		}
		
		public function dispose() : void {
			_object.removeEventListener( NativeDragEvent.NATIVE_DRAG_ENTER , dragEnterHandler );
			_object.removeEventListener( NativeDragEvent.NATIVE_DRAG_DROP , dragDropHandler ); 
			_object.removeEventListener( NativeDragEvent.NATIVE_DRAG_EXIT , dragExitHandler );
			_object = null;
		}
		
		private function dragExitHandler(event : NativeDragEvent) : void {
//			trace( "dragExitHandler" );
//			_object.dropIn( false );
		}

		private function dragEnterHandler(evt : NativeDragEvent) : void {
			
			if( CSSProvider.instance.currentCss == null ) return;
			
			if(evt.clipboard.hasFormat( ClipboardFormats.FILE_LIST_FORMAT )) {
				if( FontFormats.containFontFiles( evt.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array ) ) {
					trace( "dragEnterHandler" );
					NativeDragManager.acceptDragDrop( _object );
					evt.stopImmediatePropagation();
				}
			}
		}

		private function dragDropHandler(evt : NativeDragEvent) : void {
			trace( "dragDropHandler" );
			var dropFiles : Array = evt.clipboard.getData( ClipboardFormats.FILE_LIST_FORMAT ) as Array;
			
			for each (var file : File in dropFiles) {
				if( FontFormats.isFontFile( file ) )
					CSSProvider.instance.currentCss.fontProfile.addTrueType( file );
			}
			//_object.dropIn( false );
			evt.stopImmediatePropagation();
		}
		
		
		

		private var _object : InteractiveObject;
	}
}
