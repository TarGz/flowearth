package fr.digitas.flowearth.csseditor.undo {
	import flash.events.Event;	
	import flash.events.EventDispatcher;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class HistoryClass extends EventDispatcher {

		
		public function HistoryClass() {
			_undoStack = new Vector.<Action>( );
			_redoStack = new Vector.<Action>( );
		}
		
		public function hasUndo() : Boolean {
			return _undoStack.length > 0;
		}

		public function hasRedo() : Boolean {
			return _redoStack.length > 0;
		}

		
		
		public function undo() : Boolean {
			var action : Action = _undoStack.pop( );
			action.undo( );
			_redoStack.push( action );
			change( );
			return _undoStack.length > 0;
		}

		public function redo() : Boolean {
			var action : Action = _redoStack.pop( );
			action.redo( );
			_undoStack.push( action );
			change( );
			return _redoStack.length > 0;
		}

		public function addAction( undo : Action ) : void {
			_redoStack = new Vector.<Action>( );
			_undoStack.push( undo );
			change( );
		}
		
		private function change() : void {
			dispatchEvent( new Event( Event.CHANGE ) );
		}

		private var _undoStack : Vector.<Action>;
		
		private var _redoStack : Vector.<Action>;
		
	}
}
