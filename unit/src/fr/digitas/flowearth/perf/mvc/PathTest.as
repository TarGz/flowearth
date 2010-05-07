package fr.digitas.flowearth.perf.mvc {
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.perf.api.Bench;
	import fr.digitas.flowearth.perf.api.Perftest;	

	/**
	 * @author Pierre Lepers
	 */
	public class PathTest extends Perftest {
		
		public function PathTest() {
			super( [ contructorTest1 , contructorTest2, appendTest ] );
		}
		
		private function contructorTest1() : void {
			
			var pathStr : String = "device://partA/partX/partY/partJ/../partZ/partW?varA=valA";
			
			var b : Bench = startBench( "constructorTest 1" );

			for (var i : int = 0; i < 100; i++) {
				new Path( pathStr );
			}
			
			b.stop();
			
		}

		private function contructorTest2() : void {
			
			var pathStr : String = "../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC?varB=valB&varC=valC";
			
			var b : Bench = startBench( "constructorTest 2" );

			for (var i : int = 0; i < 100; i++) {
				new Path( pathStr );
			}
			
			b.stop();
			
		}

		private function appendTest() : void {
			
			var pathStr1 : String = "device://partA/partX/partY/partJ/../partZ/partW?varA=valA";
			var pathStr2 : String = "../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC?varB=valB&varC=valC";
			var x : IPath = new Path( pathStr1 );
			var y : IPath = new Path( pathStr2 );
			
			var b : Bench = startBench( "appendTest" );

			for ( var i : int = 0; i < 100; i++) {
				x.append( y );
			}
			
			b.stop();
			
		}

		
		
	
	}
}
