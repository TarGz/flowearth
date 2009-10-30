package fr.digitas.tutorial.nodes {
	import fl.controls.Button;
	
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.Node;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.system.NodeSystemClass;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.getTimer;	

	/**
	 * @author Pierre Lepers
	 */
	public class PerfTest extends Sprite {
		
		

		public var descButton 		: Button;
		public var addDeviceBtn 	: Button;
		public var redefBtn 		: Button;
		public var activationBtn 	: Button;
		public var clearBtn 		: Button;
		public var logTf 			: TextField;

		
		
		
		public function PerfTest() {
			
			
			descButton.addEventListener( MouseEvent.CLICK , testDescription );
			addDeviceBtn.addEventListener( MouseEvent.CLICK , testAddDevice );
			redefBtn.addEventListener( MouseEvent.CLICK , testRedef );
			activationBtn.addEventListener( MouseEvent.CLICK , testActivation );
			clearBtn.addEventListener( MouseEvent.CLICK , clear );
			genSize = getGenSize( 8, 3 );
			clear( null );
		}

		private function clear(event : MouseEvent) : void {
			rootNode = null;
			Path.GLOBAL_SYSTEM = _nodeSystem = new NodeSystemClass();

		}

		
		
		public function testDescription( e : Event ) : void {
			
			var te : int;
			var ts : int = getTimer();
			desc = generateDesc("ndB", 3, 8 );
			te = getTimer() - ts;
			log( "bi.mvc.address.struct.NodeTest - testPerf -- generate descriptor of "+genSize+" elements in "+te+"ms" );
		}

		public function testAddDevice( e : Event ) : void {
			var te : int;
			var ts : int = getTimer();
			_nodeSystem.addDevice( rootNode = new Node( desc ) );
			te = getTimer() - ts;
			log( "bi.mvc.address.struct.NodeTest - testPerf -- generate node tree of "+genSize+" elements in "+te+"ms" );

		}

		public function testRedef( e : Event ) : void {
			
			var te : int;
			var ts : int = getTimer();
			rootNode.describe( desc );
			te = getTimer() - ts;
			log( "bi.mvc.address.struct.NodeTest - testPerf -- redefine node tree of "+genSize+" elements in "+te+"ms" );
		}
		
		private function log ( str : String ) : void {
			logTf.appendText( str+"\n" );
		}

		
		
		public function testActivation(e : Event) : void {
			
			var loop : int = 500;
			var pstr1 : String = "ndB://A/A/A";
			var pstr2 : String = "ndB://A/C/C/C/C/C";
			var pstr3 : String = "ndB://C/C/C";
			var pstr4 : String = "/";

			var n1 : INode = new Path( pstr1 ).toNode();
			var n2 : INode = new Path( pstr2 ).toNode();
			var n3 : INode = new Path( pstr3 ).toNode();
			var n4 : INode = new Path( pstr4 ).toNode();
			
			var st : int = getTimer();
			
			for (var i : int = 0; i < loop; i++) {
				n1.activate( );
				n4.activate( );
				n3.activate( );
				n2.activate( );
			}
			
			var et : int = getTimer() - st;
			
			log( "bi.mvc.address.struct.NodeActivationTest - testPerf -- 4 path activate "+loop +" time"+ et);
		}
		
		
			
		
		//_____________________________________________________________________________
		//																		 GENERATION
		
		private function generateDesc( Id : String, childPerNode : int = 3, recurtion : uint = 1 ) : INodeDescriptor {
			if( childPerNode >= CHILDS_IDS.length ) childPerNode = CHILDS_IDS.length - 1;
			
			recurtion--;
			var d : BaseDescriptor = new BaseDescriptor( null );
			d.setId( Id );
			if( recurtion == 0 ) return d;
			for (var i : int = 0; i < childPerNode ; i ++) {
				d.getChildsArray().push( generateDesc( CHILDS_IDS[ i ], childPerNode , recurtion )  );
			}
			return d;
			
		}
		
		private function getGenSize( rec : int = 1, num : int = 3 ) : int {
			var res : int  = 1;
			for (var i : int = 0; i < rec; i++) {
				res += Math.pow( num , i );
			}
			return res;
		}
		
		private var genSize : int;
		private var desc : INodeDescriptor;
		private var rootNode : INode;
		
		private static const CHILDS_IDS : Array = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S" ];
		
		private var _nodeSystem : NodeSystemClass;
	}
}
