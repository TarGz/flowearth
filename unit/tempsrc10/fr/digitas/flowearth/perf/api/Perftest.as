package fr.digitas.flowearth.perf.api {
	import flash.utils.Dictionary;	
	import flash.events.Event;
	import flash.events.EventDispatcher;import flash.utils.setTimeout;		

	/**
	 * @author Pierre Lepers
	 */
	public class Perftest extends EventDispatcher {

		
		
		
		
		public function Perftest( methods : Array ) {
			_methods = methods;
			_benches = [];
		}

		public function run() : void {
			
			if( _methods.length == 0 ) _complete();
			else {
				setTimeout( _runNextTest, 2000 );
			}
		}
		
		public function startBench( desc : String ) : Bench {
			var b : Bench = new Bench( desc );
			_benches.push( b );
			b.start();
			return b;
		}
		
		

		
		
		private function _complete() : void {
			dispatchEvent( new Event ( Event.COMPLETE ) );
		}

		
		private function _runNextTest() : void {
			
			var m : Function = _methods.shift();
			m();
			run();
		}

		private var _methods : Array;
		
		private var _benches : Array;
	}
}


