package fr.digitas.flowearth.csseditor.view.menu {
	import fr.digitas.flowearth.csseditor.data.CSS;	
	import fr.digitas.flowearth.csseditor.data.CSSProvider;	
	
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class FileMenu extends NativeMenu {
		
		public function FileMenu(label : String = "" ) {
			super(  );
			_build( );
		}
		
		private function _build() : void {
			
			newFileItem = new NativeMenuItem( "New" );
			openFileItem = new NativeMenuItem( "Open" );
			closeFileItem = new NativeMenuItem( "Close" );
			closeAllFileItem = new NativeMenuItem( "Close All" );
			saveFileItem = new NativeMenuItem( "Save" );
			saveAsFileItem = new NativeMenuItem( "Save As..." );
			exitItem = new NativeMenuItem( "Exit" );

			var sep1 : NativeMenuItem = new NativeMenuItem( "sep1", true );
			var sep2 : NativeMenuItem = new NativeMenuItem( "sep2", true );
			var sep3 : NativeMenuItem = new NativeMenuItem( "sep3", true );
			
			addItem( newFileItem );
			addItem( openFileItem );
			addItem( sep1 );
			addItem( closeFileItem );
			addItem( closeAllFileItem );
			addItem( sep2 );
			addItem( saveFileItem );
			addItem( saveAsFileItem );
			addItem( sep3 );
			addItem( exitItem );
			
			newFileItem.addEventListener( Event.SELECT , onNewFile );
			openFileItem.addEventListener( Event.SELECT , onOpenFile );
			closeFileItem.addEventListener( Event.SELECT , onCloseFile );
			closeAllFileItem.addEventListener( Event.SELECT , onCloseAllFile );
			saveFileItem.addEventListener( Event.SELECT , onSaveFile );
			saveAsFileItem.addEventListener( Event.SELECT , onSaveAs );
			exitItem.addEventListener( Event.SELECT , onExit );
		}
		
		private function onNewFile(event : Event) : void {
			CSSProvider.instance.addCss( new CSS() );
		}

		private function onOpenFile(event : Event) : void {
		}

		private function onCloseFile(event : Event) : void {
		}

		private function onCloseAllFile(event : Event) : void {
		}

		private function onSaveFile(event : Event) : void {
		}

		private function onSaveAs(event : Event) : void {
		}

		private function onExit(event : Event) : void {
		}

		private var newFileItem : NativeMenuItem;
		private var openFileItem : NativeMenuItem;
		private var closeFileItem : NativeMenuItem ;
		private var closeAllFileItem : NativeMenuItem ;
		private var saveFileItem : NativeMenuItem ;
		private var saveAsFileItem : NativeMenuItem;
		private var exitItem : NativeMenuItem;
		
	}
}
