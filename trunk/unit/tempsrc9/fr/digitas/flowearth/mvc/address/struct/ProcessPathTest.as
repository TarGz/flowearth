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
	
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.mvc.address.structs.Path;
	import fr.digitas.flowearth.mvc.address.structs.intern.ProcessPath;		

	public class ProcessPathTest extends TestCase {		public function ProcessPathTest(testMethod:String = null) {			super(testMethod);		}				public function testBase() : void {			var pstr : String = "ndB:/A/C";			var path : IPath = new Path( pstr );			var ppath : ProcessPath = new ProcessPath( path.toNode(),["C","A","A","A"] );			
			trace( "fr.digitas.flowearth.mvc.address.struct.ProcessPathTest - testBase -- ", ppath.nodes() );			assertEquals( 5, ppath.nodes().length );			assertEquals( "ndB:/A/C/C/A/A/A", ppath.toNode().path().toString() );////			pstr = "ndB:/A/C";//			path = new Path( pstr );//			ppath = new ProcessPath( path.toNode(), ["C","A","A","A"]);//			//			trace( "fr.digitas.flowearth.mvc.address.struct.ProcessPathTest - testBase -- ", ppath.nodes() );//			assertEquals( 7, ppath.nodes().length );//			assertEquals( "ndB:/A/C/C/A/A/A", ppath.toNode().path().toString() );//			pstr = "ndB://A/C/C/A/A/";//			path = new Path( pstr );//			ppath = new ProcessPath( path.toNode(), ["A"] );//			//			assertEquals( 7, ppath.nodes().length );//			assertEquals( "ndB:/A/C/C/A/A/A", ppath.toNode().path().toString() );			pstr = "ndB://A/C/C/A/A/";			path = new Path( pstr );			ppath = new ProcessPath( path.toNode(), ["A"]);						assertEquals( 2, ppath.nodes().length );			assertEquals( "ndB:/A/C/C/A/A/A", ppath.toNode().path().toString() );//			pstr = "ndB://A/C/C/A/A/";//			path = new Path( pstr );//			ppath = new ProcessPath( path.toNode(), "../../B/B" );//			//			assertEquals( 6, ppath.nodes().length );//			assertEquals( "ndB:/A/C/C/B/B", ppath.toNode().path().toString() );					}	}}