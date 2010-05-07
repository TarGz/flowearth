package fr.digitas.flowearth.perf.mvc {
	import fr.digitas.flowearth.mvc.address.structs.utils.Stringifyer;	
	import fr.digitas.flowearth.mvc.address.struct.BaseDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.Node;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;
	import fr.digitas.flowearth.perf.api.Bench;
	import fr.digitas.flowearth.perf.api.Perftest;

	import flash.utils.getTimer;	

	/**
	 * @author Pierre Lepers
	 */
	public class NodeTest extends Perftest {

		
		public function NodeTest() {
			desc = generateDesc( "gen" , 3 , 8 );
			mainNode = new Node( );
			super( [ nodeDescription, nodeRedescription, nodeActivation ] );
		}

		private var mainNode : INode;
		private var desc : INodeDescriptor;

		private function nodeDescription() : void {
			
			var b : Bench = startBench( "node description 1" );
			mainNode.describe( desc );
			b.stop( );

			nodeSystem.addDevice( mainNode );
		}

		
		private function nodeRedescription() : void {
			
			
			var b : Bench = startBench( "node description 2" );
			mainNode.describe( desc );
			b.stop( );
		}

		private function nodeActivation() : void {
			
			var loop : int = 100;
			var pstr1 : String = "gen://gen-A/gen-A-A/gen-A-A-A/gen-A-A-A-A/gen-A-A-A-A-A/gen-A-A-A-A-A-A/gen-A-A-A-A-A-A-A";
			var pstr2 : String = "gen://";
			var pstr3 : String = "gen://gen-C/gen-C-C/gen-C-C-C/gen-C-C-C-C/gen-C-C-C-C-C/gen-C-C-C-C-C-C/gen-C-C-C-C-C-C-C";
			var pstr4 : String = "gen://gen-C/gen-C-C/gen-C-C-C";
			
			//trace( Stringifyer.htmlString( mainNode ) );

			var n1 : INode = new Path( pstr1 ).toNode( );
			var n2 : INode = new Path( pstr2 ).toNode( );
			var n3 : INode = new Path( pstr3 ).toNode( );
			var n4 : INode = new Path( pstr4 ).toNode( );
			
			var b : Bench = startBench( (loop*5)+" activations" );
						
			for (var i : int = 0; i < loop ; i ++) {
				
				n1.activate( );
				n2.activate( );
				n1.activate( );
				n3.activate( );
				n4.activate( );
			}
			
			b.stop();
		}

		
		
		
		
		
		private function generateDesc( Id : String, childPerNode : int = 3, recurtion : uint = 1 ) : INodeDescriptor {
			if( childPerNode >= CHILDS_IDS.length ) childPerNode = CHILDS_IDS.length - 1;
			
			recurtion --;
			var d : BaseDescriptor = new BaseDescriptor( null );
			d.setId( Id );
			if( recurtion == 0 ) return d;
			for (var i : int = 0; i < childPerNode ; i ++) {
				d.getChildsArray( ).push( generateDesc( Id + "-" + CHILDS_IDS[ i ] , childPerNode , recurtion ) );
			}
			return d;
		}

		//		private function getGenSize( rec : int = 1, num : int = 3 ) : int {
		//			var res : int  = 1;
		//			for (var i : int = 0; i < rec; i++) {
		//				res += Math.pow( num , i );
		//			}
		//			return res;
		//		}

		private static const CHILDS_IDS : Array = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S" ];
	}
}
