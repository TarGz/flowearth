////////////////////////////////////////////////////////////////////////////////
//
//  DIGITAS FRANCE / VIVAKI COMMUNICATIONS
//  Copyright 2008-2009 Digitas France
//  All Rights Reserved.
//
//  NOTICE: Digitas permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


package fr.digitas.flowearth.mvc.address.struct {	import asunit.framework.TestCase;
	
	import fr.digitas.flowearth.conf.Conf;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.Node;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractNode;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;
	
	import flash.utils.getTimer;	
	public class NodeTest extends TestCase {				public function NodeTest(testMethod:String = null) {			super(testMethod);		}		override public function run() : void {			var descDatas : XML = Conf.nodeDescriptorB.node[0];			var desc : INodeDescriptor = new BaseDescriptor( descDatas );						var device : AbstractNode = new Node();						device.describe( desc );						nodeSystem.addDevice( device );			nodeSystem.setDefaultDevice( "ndB" );			nodeSystem.setDefaultNode( device.getChild( "A" ) );									device.describe( desc );											super.run( );		}				public function testAddExtension() : void {						var pathStr : String;			var path : Path;			var node : INode;						var paths : Array = [];			var nodes : Array = [];						pathStr = "./C/C/A";			path = new Path( pathStr );			node = path.toNode( );			paths.push( path );			nodes.push( node );						assertNull( node );			assertFalse( path.nodeExist() );			pathStr = "ndB:/A/C/C/A";			path = new Path( pathStr );			node = path.toNode( );			paths.push( path );			nodes.push( node );						assertNull( node );			assertFalse( path.nodeExist() );			pathStr = "ndB:/A/C/C/A/A/A";			path = new Path( pathStr );			node = path.toNode( );			paths.push( path );			nodes.push( node );						assertNull( node );			assertFalse( path.nodeExist() );						addExtension();						assertTrue( paths[0].nodeExist() );			assertTrue( paths[1].nodeExist() );			assertTrue( paths[2].nodeExist() );			assertNotNull( paths[0].toNode() );			assertNotNull( paths[1].toNode() );			assertNotNull( paths[2].toNode() );					}				private function generateDesc( Id : String, childPerNode : int = 3, recurtion : uint = 1 ) : INodeDescriptor {			if( childPerNode >= CHILDS_IDS.length ) childPerNode = CHILDS_IDS.length - 1;						recurtion--;			var d : BaseDescriptor = new BaseDescriptor( null );			d.setId( Id );			if( recurtion == 0 ) return d;			for (var i : int = 0; i < childPerNode ; i ++) {				d.getChildsArray().push( generateDesc( Id+"-"+CHILDS_IDS[ i ], childPerNode , recurtion )  );			}			return d;					}				private function getGenSize( rec : int = 1, num : int = 3 ) : int {			var res : int  = 1;			for (var i : int = 0; i < rec; i++) {				res += Math.pow( num , i );			}			return res;		}				private static const CHILDS_IDS : Array = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S" ];		private function addExtension() : void {
						var descDatas : XML = Conf.nodeDescriptorBExt.node[0];			var desc : INodeDescriptor = new BaseDescriptor( descDatas );						var node : INode = new Path( "./C/C" ).toNode();			node.describe( desc );		}		public function testPerf() : void {			var desc : INodeDescriptor;//			var genSize : int = getGenSize( 8, 3 );						var te : int;			var ts : int = getTimer();			desc = generateDesc("gen", 3, 8 );			te = getTimer() - ts;						 var n : INode;			ts = getTimer();			nodeSystem.addDevice( n = new Node( desc ) );			te = getTimer() - ts;			ts = getTimer();			n.describe( desc );			te = getTimer() - ts;			ts = getTimer();			n.describe( desc );			te = getTimer() - ts;											}	}}