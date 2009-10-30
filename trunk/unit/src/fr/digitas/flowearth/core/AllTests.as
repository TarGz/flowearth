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


package fr.digitas.flowearth.core {
	import asunit.framework.TestSuite;
	
	import fr.digitas.flowearth.core.PileTest;	

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new fr.digitas.flowearth.core.PileTest());
		}
	}
}
