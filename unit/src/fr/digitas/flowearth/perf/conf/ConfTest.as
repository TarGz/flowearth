package fr.digitas.flowearth.perf.conf {
	import fr.digitas.flowearth.perf.api.Bench;	
	import fr.digitas.flowearth.perf.api.Perftest;
	import fr.digitas.flowearth.conf.Conf;	

	/**
	 * @author Pierre Lepers
	 */
	public class ConfTest extends Perftest {

		
		
		public function ConfTest() {
			BIG1;
			super( [ 
			
			parseTest, solveChainTest,
			
			
			 ] );
			
		}
		
		private function parseTest() : void {
			
			var b : Bench = startBench( "parse 20000 prop conf ref 529" );
			Conf.parseXml( BIG1 );
			b.stop( );
			
		}

		private function solveChainTest() : void {
			
			var b : Bench = startBench( "conf prop solving 20000 ref 370" );
			for (var i : int = 200; i < 20000; i+=200) 
				Conf.getString( "p"+i );
			
			b.stop( );

			trace( Conf.getString("p200") );
		}
		
		
		
		
		private static const BIG1 : XML = buildBig1();

		private static function buildBig1() : XML {
			
			var str : String = "<conf>";
			
			str += "<p0>0</p0>";
			for (var i : int = 1; i < 20000; i++) {
				str += "<p"+i+">${p"+(i-1)+"}."+i+"</p"+i+">";
			}
			
			str += "</conf>";
			
			return XML( str );
		}
	}
}
