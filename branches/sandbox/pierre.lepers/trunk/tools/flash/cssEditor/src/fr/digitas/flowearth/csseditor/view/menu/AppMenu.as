package fr.digitas.flowearth.csseditor.view.menu {
	import flash.display.NativeMenuItem;	
	import flash.display.NativeMenu;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class AppMenu extends NativeMenu {

		
		
		public function AppMenu() {
			_build( );
		}
		
		private function _build() : void {
			
			addItem( getFileMenu() );
			addItem( getEditMenu() );
			
		}

		private function getFileMenu() : NativeMenuItem {
			var item : NativeMenuItem = new NativeMenuItem( "File" );
			item.submenu = new FileMenu( );
			return item;
		}

		private function getEditMenu() : NativeMenuItem {
			var item : NativeMenuItem = new NativeMenuItem( "Edit" );
			item.submenu = new EditMenu( );
			return item;
		}
	}
}
