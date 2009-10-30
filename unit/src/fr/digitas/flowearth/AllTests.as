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


package fr.digitas.flowearth {
	import asunit.framework.TestSuite;
	
	import fr.digitas.flowearth.conf.AllTests;
	import fr.digitas.flowearth.command.AllTests;
	import fr.digitas.flowearth.core.AllTests;
	import fr.digitas.flowearth.event.AllTests;
	import fr.digitas.flowearth.mvc.address.struct.AllTests;
	import fr.digitas.flowearth.text.styles.AllTests;	
	import fr.digitas.flowearth.utils.AllTests;	

	public class AllTests extends TestSuite {

		public function AllTests() {
			addTest( new fr.digitas.flowearth.conf.AllTests());
			addTest( new fr.digitas.flowearth.command.AllTests());
			addTest( new fr.digitas.flowearth.core.AllTests());
			addTest( new fr.digitas.flowearth.event.AllTests());
			addTest( new fr.digitas.flowearth.utils.AllTests());
			addTest( new fr.digitas.flowearth.mvc.address.struct.AllTests());
			addTest( new fr.digitas.flowearth.text.styles.AllTests() );
		}
	}
}
