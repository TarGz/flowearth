/* ***** BEGIN LICENSE BLOCK *****
 * Copyright (C) 2007-2009 Digitas France
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * The Initial Developer of the Original Code is
 * Digitas France Flash Team
 *
 * Contributor(s):
 *   Digitas France Flash Team
 *
 * ***** END LICENSE BLOCK ***** */


package fr.digitas.flowearth.command {
	import asunit.framework.TestCase;			

	public class BatchTest extends TestCase {

		
		private var instance : Batch;

		public function BatchTest( ) {
			var methodes : Array = ["testInstantiated", 
										"testAddItem", 
										"testAddItemAt", 
										"testIterateFifo", 
										"testIterateLifo"];
										
			super( methodes.join( "," ) );
		}

		protected override function setUp() : void {
			instance = new Batch( );
		}

		protected override function tearDown() : void {
			instance = null;
		}

		public function testInstantiated() : void {
			assertTrue( "Batch instantiated", instance is Batch );
		}

		public function testAddItem() : void {
			instance.addItem( itemA );
			instance.addItem( itemB );
			instance.addItem( itemA );
			instance.removeItemAt( 0 );
			instance.addItem( itemA );
			// itemB
			// itemA

			assertEquals( "addItem", 2, instance.length );
			assertEquals( itemA, instance.getItemAt( 1 ) );
		}

		public function testAddItemAt() : void {
			instance.addItem( itemA );
			instance.addItem( itemB );
			instance.addItemAt( itemA, 0 );
			assertEquals( instance.length, 2 );
			assertEquals( "A", instance.getItemAt( 1 ), itemB );

			instance.addItemAt( itemC, 0 );
			// itemC
			// itemB
			// itemA
			assertEquals( instance.length, 3 );
			assertEquals( "B", instance.getItemAt( 0 ), itemC );
			assertEquals( "C", instance.getItemAt( 1 ), itemA );
			assertEquals( "C", instance.getItemAt( 2 ), itemB );
		}

		public function testIterateFifo() : void {
			instance.addItem( itemA );
			instance.addItem( itemB );
			instance.addItem( itemC );
			assertEquals( instance.next( ), itemA ); 
			assertEquals( instance.next( ), itemB ); 
			assertEquals( instance.next( ), itemC ); 
		}

		public function testIterateLifo() : void {
			instance.addItem( itemA );
			instance.addItem( itemB );
			instance.addItem( itemC );
			
			instance.type = Batch.LIFO;
			
			assertEquals( instance.next( ), itemC ); 
			assertEquals( instance.next( ), itemB ); 
			assertEquals( instance.next( ), itemA ); 
		}

		
		
		
		
		
		private var itemA : String = "itemA";
		private var itemB : String = "itemB";
		private var itemC : String = "itemC";
	}
}
