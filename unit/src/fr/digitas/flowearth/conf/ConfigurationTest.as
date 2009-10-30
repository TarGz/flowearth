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


package fr.digitas.flowearth.conf {
	import flash.net.URLRequest;	
	
	import asunit.framework.AsynchronousTestCase;
	
	import flash.events.Event;						

	public class ConfigurationTest extends AsynchronousTestCase {
		
		/*FDT_IGNORE*/
		private static const CONF_FILE : String = UT_CONFIG::slTestConf;
		/*FDT_IGNORE*/
		
		private var instance : Configuration;

		public function ConfigurationTest( ) {
			
			var methodes : Array = ["testInstantiated" ,
									"testParseSimpleProp" ,
									"testLockSimpleProp" ,
									"testParsePropDyn" ,
									"testParseDynRetard" ,
									"testCreaAutoDep" ,
									"testRedefSimpleProp" ,
									"testRedefDynProp" ,
									"testDepPropDyn" ,
									"testDefDepDynRetard" ,
									"testComplexeInternalNode" ,
									"testComplexeExternalNode" ,
									"testExternalSimpleProp" ,
									"testExternalDynProp" ,
									"testExternalRedef" ,
									"testDeepReversedDependancie" ,
									"testDeepReversedDependancieRedefA" ,
									"testDTLComplexe" ,
									"testDTLConcatRewrite" ,
									"testDTLDynamic" ,
									"testDTLDynamicComplexe" ,
									"testProxyGetString" ,
									"testProxySetString" ,
									"testProxyGetXML" ,
									"testProxyGetNumber" ,
									"testOptim" ,
									"testProxyGetObject", 
									"testSolve", 
									"testDeleteNoRecursif",
									"testDeleteRecursif" ,
									
									// gestion des namespaces
									
									"testBaseNs",
									"testBaseNsProxy",
									"testNsDependancies",
									"testNsDtl"
									
									];
										
			super( methodes.join( "," ) );
		}

		override public function run() : void {
			Conf.addEventListener( Event.COMPLETE , onComplete );
			/*FDT_IGNORE*/
			Conf.loadXml( new URLRequest( CONF_FILE ) );
			/*FDT_IGNORE*/
		}
		
		private function onComplete(event : Event) : void {
			super.run();
		}

		protected override function setUp() : void {
			//Always copy() the XML data so that you don't corrupt subsequent tests.
			instance = Configuration.getInstance( );
		}

		protected override function tearDown() : void {
			instance = null;
		}

		public function testInstantiated() : void {
			assertTrue( "Configuration instantiated", instance is Configuration );
		}

		public function testhasProp() : void {
			assertTrue( "hasProperty true", Conf.hasProperty( "property1" ) );
			assertFalse( "hasProperty false", Conf.hasProperty( "fsgdfg" ) );
		}

		public function testParseSimpleProp() : void {
			assertEquals( "parse simple propriété",  "maProp1", Conf.getString( "property1" ) );
		}

		public function testLockSimpleProp() : void {
			assertEquals( "parse locked propriété",  "locked", Conf.getString( "lockedProp" ) );
		}

		public function testParsePropDyn() : void {
			assertEquals( "parse propriété dynamique", "maProp1 - maProp2 - maProp3", Conf.getString( "sum123" )  );
		}

		public function testParseDynRetard() : void {
			assertEquals( "parse dynamique retardé", "/definedAfter", Conf.getString( "definedAfter" ) );
		}

		public function testCreaAutoDep() : void {
			assertEquals( "creation auto dependance", "",  Conf.getString( "what" ) );

			assertEquals( "creation auto dependance cplx", <definedAfterCplx><c><c>/definedAfterCplx</c></c></definedAfterCplx>,  Conf.getDatas( "definedAfterCplx" ) );
			Conf.setProperty(  "whatCplx", "wcplx" );
			assertEquals( "creation auto dependance cplx", <definedAfterCplx><c><c>wcplx/definedAfterCplx</c></c></definedAfterCplx>,  Conf.getDatas( "definedAfterCplx" ) );
			assertEquals( "creation auto dependance cplx", "wcplx",  Conf.getString( "whatCplx" ) );
		}

		public function testRedefSimpleProp() : void {
			Conf.setProperty( "property1", "mod1" );
			assertEquals( "redefinition prop simple", "mod1", Conf.getString( "property1" ) );
		}

		public function testRedefDynProp() : void {
			Conf.setProperty( "property1", "${property2}/mod1" );
			assertEquals( "redefinition prop dynamique", "maProp2/mod1" , Conf.getString( "property1" ));
		}

		public function testDepPropDyn() : void {
			assertEquals( "dependances prop dynamique", "maProp2/mod1 - maProp2", Conf.getString( "sum12" ) );
		}

		public function testDefDepDynRetard() : void {
			Conf.setProperty( "what", "|${property1}|" );
			assertEquals( "definition dependances dynamique retardé", "|maProp2/mod1|/definedAfter",  Conf.getString( "definedAfter" ) );
		}

		public function testComplexeInternalNode() : void {
			var testXml2 : XML = Conf.getDatas( "testXml2" );
			assertEquals( "noeud complexe interne", "noscale", testXml2.child( "test1" ).scaleMode );
		}

		public function testComplexeExternalNode() : void {
			var testXml2 : XML = Conf.getDatas( "testXml2" );
			assertEquals( "noeud complexe externe", "noued align", testXml2.child( "test3" ).T );
		}

		public function testExternalSimpleProp() : void {
			assertEquals( "external simple propriété", "INITIALISATION", Conf.getString( "initialization" ) );
		}

		public function testExternalDynProp() : void {
			assertEquals( "external propriété dynamique", "maProp3/4", Conf.getString( "property4" ) );
		}

		public function testExternalRedef() : void {
			assertEquals( "external redefinition", "en/france" , Conf.getString( "country" ) );
		}

		public function testDeepReversedDependancie() : void {
			assertEquals( "deep reversed dependancie", "ABCDE" , Conf.getString( "depE" ) );
			assertEquals( "deep reversed external dependancie", "ABCDEFGHI" , Conf.getString( "depI" ) );
		}
		
		public function testDeepReversedDependancieRedefA() : void {
			Conf.setProperty( "depA", "z" );
			assertEquals( "deep reversed dependancie", "zBCDE" , Conf.getString( "depE" ) );
			assertEquals( "deep reversed dependancie", "zBCDEFGHI" , Conf.getString( "depI" ) );
		}

		public function testDTLComplexe() : void {
			var data1 : XML = Conf.getDatas( "data1" );
			assertEquals( "data to load complexe", "en", data1.root.dyn );
		}

		public function testDTLConcatRewrite() : void {
			var data1 : XML = Conf.getDatas( "data1" );
			assertEquals( "data to load concat si reectriture", "en2", data1.root.dyn2 );
		}

		public function testDTLDynamic() : void {
			var data2 : String = Conf.getDatas( "data2" );
			assertEquals( "data to load dynamique", "prop externe avec maProp3", data2  );
		}

		public function testDTLDynamicComplexe() : void {
			var data1 : XML = Conf.getDatas( "data1" );
			assertEquals( "data to load dynamique complexe", "cool", data1.root.arbo.noeud );
		}

		public function testProxyGetString() : void {
			assertEquals( "proxy get String", "en/france", Conf.country );
		}

		public function testProxySetString() : void {
			Conf.country = "setByProxy";
			assertEquals( "proxy set String", "setByProxy", Conf.country );
		}

		public function testProxyGetXML() : void {
			var prox_xml : XML = XML( "<root>xmlprop</root>" );
			Conf.prox_xml = prox_xml;
			assertEquals( "proxy get XML", "xmlprop", Conf.prox_xml.root );
		}

		public function testProxyGetNumber() : void {
			Conf.prox_number = 2435.4352;
			assertEquals( "proxy get Number", 2436.4352, Conf.prox_number + 1 );
		}
		
		public function testOptim() : void {
			
			
			var xml : XML = Conf.XML_GetForumAdvInfo;
			
			Conf.ForumAdvName = "var1";
			xml = Conf.XML_GetForumAdvInfo;
			assertTrue( "toutchy invalidate var1", xml.Loreal_Reference_IN_GetForumAdvInfo.ForumAdvName.text()[0] == "var1" );
			
			Conf.ForumAdvName = "var2";
			xml = Conf.XML_GetForumAdvInfo;
			assertTrue( "toutchy invalidate var2", xml.Loreal_Reference_IN_GetForumAdvInfo.ForumAdvName.text()[0] == "var2" );

			Conf.ForumAdvName = "var3";
			xml = Conf.XML_GetForumAdvInfo;
			assertTrue( "toutchy invalidate var3", xml.Loreal_Reference_IN_GetForumAdvInfo.ForumAdvName.text()[0] == "var3" );

			Conf.ForumAdvName = "var4";
			xml = Conf.XML_GetForumAdvInfo;
			assertTrue( "toutchy invalidate var4", xml.Loreal_Reference_IN_GetForumAdvInfo.ForumAdvName.text()[0] == "var4" );
		}

		public function testProxyGetObject() : void {
			var obj : Object = new Object( );
			obj.nom = "pierre";
			obj.age = "23";
			obj.family = { mom : "blandine", dad : "didier", siter1 : "lorene", sister2 : "clemence", nbr : 5 };
			
			Conf.prox_obj = obj;
			assertTrue( "proxy get Object", Conf.prox_obj == "[object Object]" );
			
			//Conf.logDependers();
		}


		public function testSolve() : void {
			
			var solve : String;
			
			solve = Conf.solve( "aa-${depI}-aa" );
			assertEquals( "proxy set String", "aa-zBCDEFGHI-aa", solve );
			
			Conf.setProperty( "depA", "x" );
			
			solve = Conf.solve( "aa-${depI}-${depB}-aa" );
			assertEquals( "proxy set String", "aa-xBCDEFGHI-xB-aa", solve );
			
			
			//Conf.logDependers();
		}

		public function testDeleteNoRecursif() : void {
			
			assertTrue( "testDeleteNoRecursifAv", Conf.hasProperty("depA") );

			Conf.deleteProperty( "depA" , false );
			
			assertTrue( 	"testDeleteNoRecursifAp", Conf.hasProperty("depB") );
			assertEquals( 	"removeDepWhenDelete", Conf.getString( "depB"  ), "xB" );
			assertFalse( 	"testDeleteNoRecursifAp", Conf.hasProperty("depA") );
			
			//Conf.logDependers();
		}

		public function testDeleteRecursif() : void {
			

			Conf.deleteProperty( "depB" , true );
			
			assertFalse( "testDeleteRecursifAp", Conf.hasProperty( "depB" ) );
			assertFalse( "testDeleteRecursifAp", Conf.hasProperty( "depC" ) );
			assertFalse( "testDeleteRecursifAp", Conf.hasProperty( "depD" ) );
			assertFalse( "testDeleteRecursifAp", Conf.hasProperty( "depE" ) );
			assertFalse( "testDeleteRecursifAp", Conf.hasProperty( "depF" ) );
			assertFalse( "testDeleteRecursifAp", Conf.hasProperty( "depG" ) );
			assertFalse( "testDeleteRecursifAp", Conf.hasProperty( "depH" ) );
			assertFalse( "testDeleteRecursifAp", Conf.hasProperty( "depI" ) );
			
			
			
			//Conf.logDependers();
		}

		public function testBaseNs () : void {
			
			assertEquals( 	"no ns prop", 				"prop1 no ns", 		Conf.getString( "nsProp1" )			 );
			assertEquals( 	"nsA namespace prop", 		"prop1 nsA" , 		Conf.getString( new QName(  nsA, "nsProp1" ) )	);
			assertEquals( 	"nsB namespace prop", 		"prop1 nsB", 		Conf.getString( new QName(  nsB, "nsProp1" ) ) 	 );
			
		}

		public function testBaseNsProxy () : void {
			
			assertEquals( 	"no ns prop", 				"prop1 no ns", 		Conf.nsProp1			 );
			assertEquals( 	"nsA namespace prop", 		"prop1 nsA", 		Conf.nsA::nsProp1 	 );
			assertEquals( 	"nsB namespace prop", 		"prop1 nsB" , 		Conf.nsB::nsProp1 	);
			
		}

		public function testNsDependancies () : void {
			
			assertEquals( 	"simpleDep 1", 				"prop1 nsBZZZ", 	Conf.nsB::nsProp2 	);
			assertEquals( 	"simpleDep 2", 				"prop1 nsBZZZ", 	Conf.nsA::nsProp2 	);
			assertEquals( 	"simpleDep 3", 				"prop1 nsBZZZ", 	Conf.nsProp2	 	);
			assertEquals( 	"simpleDep 4", 				"propNons-ZZZ", 		Conf.nsB::nsProp3	);
			
		}

		public function testNsDtl () : void {
			
			assertEquals( 	"complexeNsPropWithNsDtlInjection", 	
											<propWithNsDtl>
											  <node>prop</node>
											  <datasInNs>
											    <test>datasInNs</test>
											  </datasInNs>
											</propWithNsDtl>, 
											XML( Conf.defNs::propWithNsDtl ) 	);
			
		}
		
		private var defNs : Namespace = new Namespace( "http://www.digitas.fr.flash.conftest/ns/defaultNsDefConf" );
		
		private static const nsA : Namespace = new Namespace( "http://www.digitas.fr.flash.conftest/ns/nsA" );
		private static const nsB : Namespace = new Namespace( "http://www.digitas.fr.flash.conftest/ns/nsB" );
	}
}
