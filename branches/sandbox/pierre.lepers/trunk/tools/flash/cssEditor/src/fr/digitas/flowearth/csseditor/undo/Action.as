package fr.digitas.flowearth.csseditor.undo {

	/**
	 * @author Pierre Lepers
	 */
	public class Action {

		
		
		public function Action( undo : Function, redo : Function, scope : Object = null ) {
			_undoAction = undo;
			_redoAction = redo;
			_scope = scope;
		} 
		
		private var _undoAction : Function;

		private var _redoAction : Function;
		
		private var _scope : Object;
		
		internal function redo() : Function {
			return _redoAction.apply( _scope );
		}

		internal function undo() : Function {
			return _undoAction.apply( _scope );
		}
	}
}
