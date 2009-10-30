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
	
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.intern.ProcessPath;	

	public class ProcessPathTest extends TestCase {		public function ProcessPathTest(testMethod:String = null) {			super(testMethod);		}				public function testBase() : void {			var pstr : String = "ndB:/A/C";			var path : IPath = new Path( pstr );			var ppath : ProcessPath = new ProcessPath( path.toNode(),"/C/A/A/A" );						assertEquals( 5, ppath.nodes().length );			assertEquals( "ndB:/A/C/C/A/A/A", ppath.toNode().path().toString() );			pstr = "ndB:/A/C";			path = new Path( pstr );			ppath = new ProcessPath( path.toNode(), "./C/A/A/A");						assertEquals( 7, ppath.nodes().length );			assertEquals( "ndB:/A/C/C/A/A/A", ppath.toNode().path().toString() );			pstr = "ndB://A/C/C/A/A/";			path = new Path( pstr );			ppath = new ProcessPath( path.toNode(), "./A" );						assertEquals( 7, ppath.nodes().length );			assertEquals( "ndB:/A/C/C/A/A/A", ppath.toNode().path().toString() );			pstr = "ndB://A/C/C/A/A/";			path = new Path( pstr );			ppath = new ProcessPath( path.toNode(), "A" );						assertEquals( 2, ppath.nodes().length );			assertEquals( "ndB:/A/C/C/A/A/A", ppath.toNode().path().toString() );			pstr = "ndB://A/C/C/A/A/";			path = new Path( pstr );			ppath = new ProcessPath( path.toNode(), "../../B/B" );						assertEquals( 6, ppath.nodes().length );			assertEquals( "ndB:/A/C/C/B/B", ppath.toNode().path().toString() );					}	}}