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


package fr.digitas.flowearth.mvc.address.struct {
	import asunit.framework.TestSuite;						

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest( new AbstractPathTest( ) );
			addTest( new AbstractNodeTest( ) );
			addTest( new NodeTest( ) );
			addTest( new PathTest( ) );
			addTest( new ProcessPathTest( ) );
			addTest( new NodeActivationTest( ) );
		}
	}
}
