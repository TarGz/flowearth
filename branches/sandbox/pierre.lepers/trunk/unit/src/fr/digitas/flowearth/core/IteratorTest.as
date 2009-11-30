package fr.digitas.flowearth.core {
	import asunit.framework.TestCase;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class IteratorTest extends TestCase {

		private var testArray : Array = [ "a", "b", "c" ];

		public function IteratorTest() {
			super( );
		}

		override protected function setUp() : void {
			super.setUp( );
		}

		
		public function testInstantiated() : void {
			var iter : IIterator = new Iterator( testArray );
			assertTrue( "Pile instantiated", iter is Iterator );
		}

		public function testHasNext() : void {
			var iter : IIterator = new Iterator( testArray );
			assertTrue( "Pile firstHasNext", iter.hasNext() );
		}

		public function testNext() : void {
			var iter : IIterator = new Iterator( testArray );
			assertEquals( "Pile firstNext", "a", iter.next() );
		}

		public function testLoopStyleA() : void {
			var iter : IIterator = new Iterator( testArray );
			
			var res : String = "";
			
			while( iter.hasNext() ) {
				res += iter.next() as String;
				
			}
			assertEquals( "Pile firstNext", "abc", res );
		}

		public function testLoopStyleB() : void {
			var iter : IIterator = new Iterator( testArray );
			
			var res : String = "";
			var item : String;
			while( item = iter.next() as String ) {
				res += item;
			}
			assertEquals( "Pile firstNext", "abc", res );
		}

		public function testReverseIterator() : void {
			var iter : IIterator = new IteratorR( testArray );
			
			var res : String = "";
			var item : String;
			while( item = iter.next() as String ) {
				res += item;
			}
			assertEquals( "Pile firstNext", "cba", res );
		}
		
		

	}
}
