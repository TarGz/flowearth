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


package fr.digitas.flowearth.mvc.address.struct {	import asunit.framework.TestCase;
	
	import fr.digitas.flowearth.conf.Conf;
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.Node;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;	
	public class AbstractNodeTest extends TestCase {				private var instance:Node;		public function AbstractNodeTest(testMethod:String = null) {			super(testMethod);		}
		
		override public function run() : void {			var descDatas : XML = Conf.nodeDescriptorA.node[0];			var desc : INodeDescriptor = new BaseDescriptor( descDatas );						instance = new Node( desc );			nodeSystem.addDevice( instance );			
			super.run( );		}
		public function testInstantiated():void {			assertTrue("Node instantiated", instance is Node);		}		public function testIterChilds():void {			var childs : Array = instance.getChilds();			var item : INode;			var ids : Array = [];
						for (var i : int = 0; i < childs.length; i++) {
				item = childs[ i ];				ids.push( item.getId() );			}						assertEquals("testIterChilds lenght 3", 3, ids.length );			assertTrue("testIterChilds has A", ( ids.indexOf("A") > -1 ) );			assertTrue("testIterChilds has B", ( ids.indexOf("B") > -1 ) );			assertTrue("testIterChilds has B", ( ids.indexOf("C") > -1 ) );		}		public function testDefaultId():void {			assertEquals( "default child id", "C", instance.getDefaultId() );		}		public function testDefaultChild():void {			assertEquals( "default child id", instance.getChild( "C" ).getDefaultId(), instance.getChild( "C" ).getDefaultChild().getId() );		}		public function testGetChild():void {			var id : String;			id = "A";			assertEquals( "get child "+id, id, instance.getChild( id ).getId() );			id = "B";			assertEquals( "get child "+id, id, instance.getChild( id ).getId() );		}		public function testGetSubChild():void {			var id : String;			var sid : String;						id = "A";			sid = "AA";			assertEquals( "get child "+id+"/"+sid, sid, instance.getChild( id ).getChild( sid ).getId() );			sid = "AB";			assertEquals( "get child "+id+"/"+sid, sid, instance.getChild( id ).getChild( sid ).getId() );						id = "B";			sid = "BA";			assertEquals( "get child "+id+"/"+sid, sid, instance.getChild( id ).getChild( sid ).getId() );			sid = "BB";			assertEquals( "get child "+id+"/"+sid, sid, instance.getChild( id ).getChild( sid ).getId() );		}		public function testGetParent():void {			var id : String;			var sid : String;						assertEquals( "get parent ", null, instance.parent() );						id = "A";			assertEquals( "get parent "+id, instance.getId(), instance.getChild( id ).parent().getId() );			sid = "AA";			assertEquals( "get parent "+id+"/"+sid, id, instance.getChild( id ).getChild( sid ).parent().getId() );			sid = "AB";			assertEquals( "get parent "+id+"/"+sid, id, instance.getChild( id ).getChild( sid ).parent().getId() );						id = "B";			assertEquals( "get parent "+id, instance.getId(), instance.getChild( id ).parent().getId() );			sid = "BA";			assertEquals( "get parent "+id+"/"+sid, id, instance.getChild( id ).getChild( sid ).parent().getId() );			sid = "BB";			assertEquals( "get parent "+id+"/"+sid, id, instance.getChild( id ).getChild( sid ).parent().getId() );		}	}}