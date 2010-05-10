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
	
	import fr.digitas.flowearth.mvc.address.struct.testtools.ActivationTraverser;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.system.nodeSystem;
	
	import flash.utils.getTimer;	
	public class NodeActivationTest extends TestCase {		public function NodeActivationTest(testMethod:String = null) {			super(testMethod);		}
		public function testDirectActivation() : void {						var pstr : String;			var traverser : ActivationTraverser;						pstr = "/";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB" , traverser.activeString );
			//assertEquals( "", nodeSystem.getDevice( "ndB" ).activePath.getPath() );			pstr = "ndB://A/A/A/";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB/A/A/A" , traverser.activeString );			assertEquals( "A/A/A", nodeSystem.getDevice( "ndB" ).activePath.getPath() );						pstr = "ndB://C/C/C";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB/C/C/C" , traverser.activeString );			assertEquals( "C/C/C", nodeSystem.getDevice( "ndB" ).activePath.getPath() );															// default path : ndB:/A			pstr = "./A";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB/A/A" , traverser.activeString );			assertEquals( "A/A", nodeSystem.getDevice( "ndB" ).activePath.getPath() );					}		public function testTruncateActivation() : void {						var pstr : String;			var traverser : ActivationTraverser;						pstr = "ndB://A/C/C/C/C/C";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB/A/C/C/C/C/C" , traverser.activeString );						pstr = "ndB://A/C/C/C/C";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB/A/C/C/C/C" , traverser.activeString );			pstr = "ndB://A/C/C/C";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB/A/C/C/C" , traverser.activeString );			pstr = "ndB://A/";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB/A" , traverser.activeString );			pstr = "ndB://";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB" , traverser.activeString );			pstr = "";			new Path( pstr ).toNode().activate( );			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );			assertEquals( "/ndB" , traverser.activeString );														}//		public function testPathActivation() : void {//			//			var pstr : String;//			var rstr : String;//			var traverser : ActivationTraverser;//			//			pstr = "ndB://A/";//			rstr = "./A/A";//			new Path( pstr ).toNode().activate( new Path( rstr ) );//			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );//			assertEquals( "/ndB/A/A/A" , traverser.activeString );////			pstr = "/";//			rstr = "./A/A/A";//			new Path( pstr ).toNode().activate( new Path( rstr ) );//			nodeSystem.getDevice( "ndB" ).scan(traverser = new ActivationTraverser() );//			assertEquals( "/ndB/A/A/A" , traverser.activeString );//			//			//			//		}		public function testDefaultActivation() : void {						var pstr : String;			var rstr : String;			var traverser : ActivationTraverser;						pstr = "ndA:";			new Path( pstr ).toNode().activate( );						nodeSystem.getDevice( "ndA" ).scan(traverser = new ActivationTraverser() );			assertEquals( "CBAA" , new Path( "ndA://C/CB/CBA" ).toNode().getDefaultChild().getId() );			assertEquals( "/ndA/C/CB/CBA/CBAA/CBAAA" , traverser.activeString );													}				public function testPerf() : void {					var loop : int = 500;			var pstr1 : String = "ndB://A/A/A";			var pstr2 : String = "ndB://A/C/C/C/C/C";			var pstr3 : String = "ndB://C/C/C";			var pstr4 : String = "/";			var n1 : INode = new Path( pstr1 ).toNode();			var n2 : INode = new Path( pstr2 ).toNode();			var n3 : INode = new Path( pstr3 ).toNode();			var n4 : INode = new Path( pstr4 ).toNode();						var st : int = getTimer();						for (var i : int = 0; i < loop; i++) {								n1.activate( );				n2.activate( );				n3.activate( );				n4.activate( );							}						var et : int = getTimer() - st;
			
			trace( "fr.digitas.flowearth.mvc.address.struct.NodeActivationTest - testPerf -- ", et );					}	}}