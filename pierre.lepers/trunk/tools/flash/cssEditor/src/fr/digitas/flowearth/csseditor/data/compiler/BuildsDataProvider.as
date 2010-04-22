package fr.digitas.flowearth.csseditor.data.compiler {
	import fr.digitas.flowearth.process.BuildHistory;
	
	import flash.events.EventDispatcher;		

	/**
	 * @author Pierre Lepers
	 */
	public class BuildsDataProvider extends EventDispatcher {
		
		public function BuildsDataProvider() {
			super( );
			_history = new BuildHistory();
		}
		
		public function getHistory() : BuildHistory {
			return _history;
		}
		
		private var _history : BuildHistory;
		
	}
}
