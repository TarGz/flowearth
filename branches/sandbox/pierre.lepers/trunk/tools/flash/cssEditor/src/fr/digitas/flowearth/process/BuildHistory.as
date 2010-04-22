package fr.digitas.flowearth.process {
	import flash.events.EventDispatcher;		

	/**
	 * @author Pierre Lepers
	 */
	public class BuildHistory extends EventDispatcher {
		
		
		public function BuildHistory() {
			_stack = new Vector.<BuildInfos>( );
		}
		
		public function clear( terminatedOnly : Boolean = true ) : void {
			var i : BuildInfos;
			
			while( _stack.length > 0 ) {
				if( terminatedOnly && !i.isComplete() ) continue;
				i = _stack.pop();
				dispatchEvent( new BuildInfosEvent( BuildInfosEvent.BUILD_REMOVED, i ) );
			}
		}

		public function removeBuild( infos : BuildInfos , dispose : Boolean = true ) : Boolean {
			var index : int = _stack.indexOf( infos );
			if( index == -1 ) return false;
			if( dispose ) infos.dispose( );
			_stack.splice( index, 1 );
			dispatchEvent( new BuildInfosEvent( BuildInfosEvent.BUILD_REMOVED, infos ) );
			return true;
		}

		public function addBuild( infos : BuildInfos) : void {
			_stack.push( infos );
			dispatchEvent( new BuildInfosEvent( BuildInfosEvent.BUILD_ADDED, infos ) );
		}
		
		public function getBuilds() : Vector.<BuildInfos> {
			return _stack;
		}
		
		private var _stack : Vector.<BuildInfos>;
		
	}
}
