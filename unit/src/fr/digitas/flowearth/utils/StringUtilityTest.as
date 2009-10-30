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


package fr.digitas.flowearth.utils {
	import asunit.framework.TestCase;				

	public class StringUtilityTest extends TestCase {

		
		public function StringUtilityTest(testMethod : String = null) {
			super( testMethod );
		}

		
		public function testMultiplyA() : void {
			var s : String = StringUtility.multiply("&é'", 4);
			assertEquals( "testMultiplyA", "&é'&é'&é'&é'", s );
		}

		public function testMultiplyB() : void {
			var s : String = StringUtility.multiply("", 10);
			assertEquals( "testMultiplyB", "", s );
		}

		public function testMultiplyC() : void {
			var s : String = StringUtility.multiply("dfsdf", 0);
			assertEquals( "testMultiplyC", "", s );
		}

		public function testMultiplyD() : void {
			var s : String = StringUtility.multiply("65qsd4f32qs1df64wx32v1wxc", 1);
			assertEquals( "testMultiplyD", "65qsd4f32qs1df64wx32v1wxc", s );
		}
		
		public function testMultiplyE() : void {
			var s : String = StringUtility.multiply("65qsd4f32qs1df64wx32v1wxc", 2);
			assertEquals( "testMultiplyE", "65qsd4f32qs1df64wx32v1wxc65qsd4f32qs1df64wx32v1wxc", s );
		}

		public function testUpperFirstLetterA() : void {
			var s : String = "SALUT";
			var s2 : String = StringUtility.upperFirstLetter(s);
			assertEquals( "testUpperFirstLetterA", s, s2 );
		}

		public function testUpperFirstLetterB() : void {
			var s : String = "sALUT";
			var s2 : String = StringUtility.upperFirstLetter(s);
			assertEquals( "testUpperFirstLetterB", "SALUT", s2 );
		}

		public function testUpperFirstLetterC() : void {
			var s : String = "s";
			var s2 : String = StringUtility.upperFirstLetter(s);
			assertEquals( "testUpperFirstLetterC", "S", s2 );
		}

		public function testUpperFirstLetterD() : void {
			var s : String = "";
			var s2 : String = StringUtility.upperFirstLetter(s);
			assertEquals( "testUpperFirstLetterD", "", s2 );
		}
		
		
	}
}
