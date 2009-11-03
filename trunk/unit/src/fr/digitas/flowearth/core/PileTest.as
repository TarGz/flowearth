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


package fr.digitas.flowearth.core {
	import asunit.framework.TestCase;			

	public class PileTest extends TestCase {

		
		private var instance : Pile;

		public function PileTest() {
									
			super( );
		}

		protected override function setUp() : void {
			instance = new Pile( );
		}

		protected override function tearDown() : void {
			instance = null;
		}

		public function testInstantiated() : void {
			assertTrue( "Pile instantiated", instance is Pile );
		}

		public function testGetItemAt() : void {
			instance.addItem( item1 );
			instance.addItem( item2 );
			instance.addItem( item3 );

			assertEquals( "getItemAt", instance.getItemAt( 2 ), item3 );
			assertEquals( "getItemAt", 3, instance.length );
		}

		public function testAddItemAt() : void {
			instance.addItem( item1 );
			instance.addItem( item2 );
			instance.addItem( item3 );
			
			instance.addItemAt( item4, 1 );
			// item1
			// item4
			// item2
			// item3
			assertEquals( "addItemAt", item1, instance.getItemAt( 0 ) );
			assertEquals( "addItemAt", item4, instance.getItemAt( 1 ) );
			assertEquals( "addItemAt", item2, instance.getItemAt( 2 ) );
			assertEquals( "addItemAt", item3, instance.getItemAt( 3 ) );
			assertEquals( "addItemAt", 4, instance.length );
		}

		public function testRemoveItem() : void {
			instance.addItem( item1 );
			instance.addItem( item4 );
			instance.addItem( item2 );
			instance.addItem( item3 );
			instance.removeItem( item1 );
			// item4
			// item2
			// item3
			assertEquals( "removeItem", item4, instance.getItemAt( 0 ) );
			assertEquals( "removeItem", item2, instance.getItemAt( 1 ) );
			assertEquals( "removeItem", item3, instance.getItemAt( 2 ) );
			assertEquals( "removeItem", 3, instance.length );
		}

		public function testSetItemIndex() : void {
			instance.addItem( item4 );
			instance.addItem( item2 );
			instance.addItem( item3 );
			instance.addItemAt( item1, 1 );
			instance.setItemIndex( item1, 3 );
			// item4
			// item2
			// item3
			// item1
			assertEquals( "setItemIndex", item4, instance.getItemAt( 0 ) );
			assertEquals( "setItemIndex", item2, instance.getItemAt( 1 ) );
			assertEquals( "setItemIndex", item3, instance.getItemAt( 2 ) );
			assertEquals( "setItemIndex", item1, instance.getItemAt( 3 ) );
			assertEquals( "setItemIndex", 4, instance.length );
		}

		public function testSwapItems() : void {
			instance.addItem( item1 );
			instance.addItem( item2 );
			instance.addItem( item3 );
			instance.addItem( item4 );
			instance.swapItems( item1, item4 );
			// item4
			// item2
			// item3
			// item1
			assertEquals( "swapItems", item4, instance.getItemAt( 0 ) );
			assertEquals( "swapItems", item2, instance.getItemAt( 1 ) );
			assertEquals( "swapItems", item3, instance.getItemAt( 2 ) );
			assertEquals( "swapItems", item1, instance.getItemAt( 3 ) );
			assertEquals( "swapItems", 4, instance.length );
		}

		public function testSwapItemsAt() : void {
			instance.addItem( item1 );
			instance.addItem( item3 );
			instance.addItem( item2 );
			instance.addItem( item4 );
			instance.swapItemsAt( 1, 2 );
			// item4
			// item3
			// item2
			// item1
			assertEquals( "swapItemsAt", item1, instance.getItemAt( 0 ) );
			assertEquals( "swapItemsAt", item2, instance.getItemAt( 1 ) );
			assertEquals( "swapItemsAt", item3, instance.getItemAt( 2 ) );
			assertEquals( "swapItemsAt", item4, instance.getItemAt( 3 ) );
			assertEquals( "swapItemsAt", 4, instance.length );
		}

		public function testSetItemIndexUno() : void {
			
			instance.addItem( item1 );
			instance.setItemIndex( item1, 10 );
			// item1
			assertEquals( "setItemIndex lenght=1", item1, instance.getItemAt( 0 ) );
			assertEquals( "setItemIndex", 1, instance .length );
		}
		
		
		public function testReplaceItem() : void {
			instance.addItem( item1 );
			instance.addItem( item3 );
			instance.addItem( item2 );
			instance.addItem( item4 );
			
			var newItem : String = "coucou";
			
			instance.replaceItem( item2, newItem);
			
			assertEquals( "replaceItem", item1, instance.getItemAt( 0 ) );
			assertEquals( "replaceItem", item3, instance.getItemAt( 1 ) );
			assertEquals( "replaceItem", newItem, instance.getItemAt( 2 ) );
			assertEquals( "replaceItem", item4, instance.getItemAt( 3 ) );
		}

		
		
		private var item1 : String = "item1 ";
		private var item2 : String = "item2 ";
		private var item3 : String = "item3 ";
		private var item4 : String = "item4 ";
	}
}
