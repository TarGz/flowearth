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


package fr.digitas.flowearth.command {
	import asunit.framework.TestSuite;
	
	import fr.digitas.flowearth.command.BatchTest;
	import fr.digitas.flowearth.command.BatcherAdvancedTest;
	import fr.digitas.flowearth.command.BatcherTest;	

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest(new fr.digitas.flowearth.command.BatcherTest());
			addTest(new fr.digitas.flowearth.command.BatchTest());
			addTest(new fr.digitas.flowearth.command.BatcherAdvancedTest());
		}
	}
}
