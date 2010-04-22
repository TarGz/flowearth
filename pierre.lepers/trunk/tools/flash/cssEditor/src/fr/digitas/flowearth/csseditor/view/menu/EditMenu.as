package fr.digitas.flowearth.csseditor.view.menu {
	import fr.digitas.flowearth.csseditor.undo.history;
	
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;		

	/**
	 * @author Pierre Lepers
	 */
	public class EditMenu extends NativeMenu {
		
		public function EditMenu(label : String = "" ) {
			super(  );
			_build( );
		}
		
		private function _build() : void {
			
			undoItem = new NativeMenuItem( "Undo" );
			redoItem = new NativeMenuItem( "Redo" );
			
			undoItem.keyEquivalent = "z";
			redoItem.keyEquivalent = "y";
//			redoItem.keyEquivalentModifiers = [ Keyboard .CONTROL ];
			
			
			var sep1 : NativeMenuItem = new NativeMenuItem( "sep1", true );
			
			addItem( undoItem );
			addItem( redoItem );
			addItem( sep1 );

			undoItem.addEventListener( Event.SELECT , onUndo );
			redoItem.addEventListener( Event.SELECT , onRedo);

			history.addEventListener( Event.CHANGE, onHistoryChange );
			onHistoryChange( null );
		}
		
		private function onHistoryChange(event : Event) : void {
			undoItem.enabled = history.hasUndo();
			redoItem.enabled = history.hasRedo();
		}


		private function onUndo(event : Event) : void {
			undoItem.enabled = history.undo();
		}

		private function onRedo(event : Event) : void {
			redoItem.enabled = history.redo();
		}

		private var undoItem : NativeMenuItem;
		private var redoItem : NativeMenuItem;
		
	}
}
