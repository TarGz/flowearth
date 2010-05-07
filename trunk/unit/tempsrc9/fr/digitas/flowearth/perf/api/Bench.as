package fr.digitas.flowearth.perf.api {
	import fr.digitas.flowearth.perf.Performances;
	
	import flash.utils.getTimer;	/**
	 * @author Pierre Lepers
	 */
	public class Bench {

		
		public function Bench( desc : String ) {
			this.desc = desc;
		}

		public function start() : void {
			startTime = getTimer();
		}

		public function stop() : void {
			duration = getTimer( ) - startTime;
			Performances.appendText( getResult() );
		}

		public function getResult() : String {
			return desc + " : " + duration+" ms";
		}

		
		
		private var desc : String;
		private var startTime : Number;
		private var duration : Number;
		
		
	}
}
