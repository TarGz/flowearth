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


package fr.digitas.flowearth.utils {	import asunit.framework.TestCase;
	
	import flash.net.URLVariables;	

	public class VariablesToolsTest extends TestCase {		public function VariablesToolsTest(testMethod:String = null) {			super(testMethod);		}
		
		public function testEqualsSimple() : void {						var vars1 : URLVariables = new URLVariables();			vars1.var1 = "val1";			vars1.intId = 12;			vars1.numId = 12.54;			var vars2 : URLVariables = new URLVariables();			vars2.numId = 12.54;			vars2.intId = 12;			vars2.var1 = "val1";			var vars3 : URLVariables = new URLVariables();			vars3.numId = 12.54;			vars3.intId = 12;			vars3.var1 = "valDiff";						assertTrue( "test simple equality" , VariablesTools.equals( vars1 , vars2 ) );			assertFalse( "test simple equality" , VariablesTools.equals( vars1 , vars3 ) );					}		public function testEqualsDiffConstruct() : void {						var vars1 : URLVariables = new URLVariables();			vars1.var1 = "val1";			vars1.intId = 12;			vars1.numId = 12.54;			var varsString : String = "var1=val1&intId=12&numId=12.54";			var vars2 : URLVariables = new URLVariables( varsString );			var varsString3 : String = "var1=val1&intId=12&numId=12.543";			var vars3 : URLVariables = new URLVariables( varsString3 );									assertTrue( "testEqualsDiffConstruct" , VariablesTools.equals( vars1 , vars2 ) );			assertFalse( "testEqualsDiffConstruct" , VariablesTools.equals( vars1 , vars3 ) );					}	}}