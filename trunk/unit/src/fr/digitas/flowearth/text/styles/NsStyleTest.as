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


package fr.digitas.flowearth.text.styles {	import asunit.framework.TestCase;
	
	import fr.digitas.flowearth.conf.Conf;	
	public class NsStyleTest extends TestCase {		public function NsStyleTest(testMethod : String = null) {						super( testMethod );		}		override public function run() : void {			var cssText : String = Conf.getString( "css_basic" );			styleManager.addCss( cssText , ns.uri );			super.run( );
		}		private const ns : Namespace = new Namespace( "http://www.digitas.fr/ns/unitTest/styleSpaceA" );
				public function testBasicNativValues() : void {						var sname : String;			var qname : QName;			var s : AdvancedFormat;									sname = "basicStyleA";			qname = new QName( ns , sname );			s = styleManager.getStyle( qname );			//			fontSize: 8;			//		    color: 0xFFFFFF;			//			autoSize: "left";			assertEquals( "test " + sname + " values 1" , s.getObject( ).fontSize , 8 );			assertTrue( "test " + sname + " type 1" , ( s.getObject( ).fontSize is String ) );			assertEquals( "test " + sname + " values 2" , s.getObject( ).color , 0xFFFFFF );			assertTrue( "test " + sname + " type 2" , ( s.getObject( ).color is String ) );			assertEquals( "test " + sname + " values 3" , s.getObject( ).autoSize , '"left"' );			assertTrue( "test " + sname + " type 3" , ( s.getObject( ).autoSize is String ) );			sname = ".basicStyleB";			qname = new QName( ns , sname );			s = styleManager.getStyle( qname );			//			fontSize :10;			//		    color : #FFFFFF;			//			autoSize:left;			assertEquals( "test " + sname + " values 1" , s.getObject( ).fontSize , 10 );			assertTrue( "test " + sname + " type 1" , ( s.getObject( ).fontSize is String ) );			assertEquals( "test " + sname + " values 2" , s.getObject( ).color , "#FFFFFF" );			assertTrue( "test " + sname + " type 2" , ( s.getObject( ).color is String ) );			assertEquals( "test " + sname + " values 3" , s.getObject( ).autoSize , "left" );			assertTrue( "test " + sname + " type 3" , ( s.getObject( ).autoSize is String ) );		}	}}