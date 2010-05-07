package fr.digitas.flowearth.perf.mvc {
	import fr.digitas.flowearth.perf.api.Bench;
	import fr.digitas.flowearth.perf.api.Perftest;		

	/**
	 * @author Pierre Lepers
	 */
	public class BasicVectorTest extends Perftest {
		
		public function BasicVectorTest() {
			super( [ fillArrayTest, splitTest , joinTest ] );
		}


		private function fillArrayTest() : void {
			
			var a : Array = [];
			
			var c : int = 1000000;
			
			
			var b : Bench = startBench( "fill array" );
			for (var i : int = 0; i < c; i++) {
				a[i] = "lkj";
			}
			
			b.stop();
			
		}
//
//		private function fillVectorTest() : void {
//			
//			var v : Vector.<String> = new Vector.<String>();
//			
//			var c : int = 1000000;
//			
//			
//			var b : Bench = startBench( "fill vector" );
//			for (var i : int = 0; i < c; i++) {
//				v.push( "lkj" );
//			}
//			
//			b.stop();
//			
//		}
//
//		private function fillFixedVectorTest() : void {
//			
//			var c : int = 1000000;
//			var v : Vector.<String> = new Vector.<String>( c, true );
//			
//			
//			
//			var b : Bench = startBench( "fill fixed vector" );
//			for (var i : int = 0; i < c; i++) {
//				v[i] = "lkj";
//			}
//			
//			b.stop();
//			
//		}

		private function splitTest() : void {
			
			var a : Vector.<String> ;
			var s : String = "kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/";
			
			
			
			var b : Bench = startBench( "split cast in vector" );
			for (var i : int = 0; i < 1000; i++) {
				a = Vector.<String>(s.split( SEP ));
			}
			b.stop();
			
		}

		private function joinTest() : void {
			
			var a : Vector.<String> ;
			var s : String = "kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/kjh/";
			a = Vector.<String>(s.split( SEP ));
			
			var b : Bench = startBench( "join" );
			for (var i : int = 0; i < 1000; i++) {
				a.join("/");
			}
			b.stop();
			
		}
		
		private static const SEP : String = "/";
		
	}
}
