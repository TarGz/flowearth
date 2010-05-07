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
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractPath;
	import fr.digitas.flowearth.utils.VariablesTools;
	
	import flash.net.URLVariables;
	import flash.utils.getTimer;	

	public class AbstractPathTest extends TestCase {
		public function AbstractPathTest(testMethod : String = null) {			super( testMethod );		}
		public function testParseSimplePath() : void {						var pathStr : String;			var path : Path;						pathStr = "partA/partB/partC";			testBasicSegments( new Path( pathStr ) );			pathStr = "//partA/partB/partC//";			testBasicSegments( new Path( pathStr ) );			pathStr = "partA/partB/partC//";			testBasicSegments( new Path( pathStr ) );						pathStr = "//partA/partB/partC";			testBasicSegments( new Path( pathStr ) );			pathStr = "//partA/./partB/partC";			testBasicSegments( new Path( pathStr ) );			pathStr = "//partA/./partB/./partC";			testBasicSegments( new Path( pathStr ) );			pathStr = "//partA/partB/./partC";			testBasicSegments( new Path( pathStr ) );			pathStr = "device:/partA/./partB/./partC";			testBasicSegments( new Path( pathStr ) );			pathStr = "device:/partA/partB/./partC";			testBasicSegments( new Path( pathStr ) );						pathStr = "device://./partA/partB/partC";			testBasicSegments( new Path( pathStr ) );						pathStr = "device:./partA/partB/partC";			testBasicSegments( new Path( pathStr ) );						pathStr = "device:/./partA/partB/partC";			testBasicSegments( new Path( pathStr ) );		}
		public function testSimpleDevice() : void {					var pathStr : String;			var path : Path;						pathStr = "device://partA/partB/partC";			path = new Path( pathStr );			testBasicSegments( path );			assertEquals( "device" , path.getDevice( ) );			pathStr = "device:////partA/partB/partC///";			path = new Path( pathStr );			testBasicSegments( path );			assertEquals( "device" , path.getDevice( ) );			pathStr = "device://";			path = new Path( pathStr );			assertEquals( 0 , path.segments( ).length );			assertEquals( "device" , path.getDevice( ) );		} 
		public function testDoubleDot() : void {					var pathStr : String;			pathStr = "device://partA/partX/../partB/partC";			testBasicSegments(  new Path( pathStr ) );						pathStr = "device://partA/partX/partY/../../partB/partC";			testBasicSegments(  new Path( pathStr ) );			pathStr = "device:////partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			testBasicSegments(  new Path( pathStr ) );			pathStr = "device:partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			testBasicSegments(  new Path( pathStr ) );						pathStr = "../../../../partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			testBasicSegments(  new Path( pathStr ) );			pathStr = "./../../../../partA/partX/./partY/partJ/../partZ/./partW/../../.././../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			testBasicSegments(  new Path( pathStr ) );			pathStr = "partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			testBasicSegments(  new Path( pathStr ) );		}				public function testDevice() : void {					var pathStr : String;						pathStr = "device://partA/partX/../partB/partC";			assertEquals( "device" , new Path( pathStr ).getDevice( ) );						pathStr = "device://partA/partX/partY/../../partB/partC";			assertEquals( "device" , new Path( pathStr ).getDevice( ) );			pathStr = "device:////partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			assertEquals( "device" , new Path( pathStr ).getDevice( ) );			pathStr = "device:partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			assertEquals( "device" , new Path( pathStr ).getDevice( ) );						pathStr = "../../../../partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			assertNull( new Path( pathStr ).getDevice( ) );			pathStr = "./../../../../partA/partX/./partY/partJ/../partZ/./partW/../../.././../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			assertNull( new Path( pathStr ).getDevice( ) );			pathStr = "partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			assertNull( new Path( pathStr ).getDevice( ) );		}						public function testIsAbsolute() : void {					var pathStr : String;			var path : Path;						pathStr = "partA/partX/../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", path.isAbsolute() );						pathStr = "./partA/partX/partY/../../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", ! path.isAbsolute() );			pathStr = "././partA/./partX/partY/../../partB/./partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", ! path.isAbsolute() );			pathStr = "partA/../../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", ! path.isAbsolute() );						pathStr = "device://partA/partX/../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", path.isAbsolute() );						pathStr = "device://partA/partX/partY/../../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", path.isAbsolute() );			pathStr = "device:////partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", path.isAbsolute() );			pathStr = "device:partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", path.isAbsolute() );						pathStr = "../../../../partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", ! path.isAbsolute() );			pathStr = "./../../../../partA/partX/./partY/partJ/../partZ/./partW/../../.././../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", ! path.isAbsolute() );			pathStr = "partA/partX/partY/partJ/../partZ/partW/../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			path = new Path( pathStr );			assertTrue( "absolut/relative", path.isAbsolute() );		}				public function testParamsValue() : void {						var pathStr : String;			var path : Path;						var vars : URLVariables = new URLVariables( "var1=val1&var2=val2" );						pathStr = "device://partA/partX/../partB/partC?var1=val1&var2=val2";			path = new Path( pathStr );			assertTrue( VariablesTools.equals( path.getParams(), vars ) );			pathStr = "device://partA/partX/../partB/partC";			path = new Path( pathStr, vars );			assertTrue( VariablesTools.equals( path.getParams(), vars ) );								}				public function testParamsNull() : void {						var pathStr : String;			var path : Path;						pathStr = "device://partA/partX/../partB/partC";			path = new Path( pathStr );			assertNull( path.getParams() );		}		public function testPathEquality() : void {						var pathStr1 : String, pathStr2 : String;						pathStr1 = "partA/partB/partC";			pathStr2 = "partA/partB/partC";			assertTrue( "simple path equals",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "partA/partB/partC///";			pathStr2 = "//partA/partB/partC";			assertTrue( "less simple path equals",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "partA/partX/../partB/partC";			pathStr2 = "partA/partB/partC";			assertTrue( "Ddotted path equals",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "device://partA/partB/partC";			pathStr2 = "device://partA/partB/partC";			assertTrue( "deviced path equals",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "device:partA/partB/partC//";			pathStr2 = "device:///partA/partB/partC";			assertTrue( "deviced path equals 2",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "device://partA/partX/../partB/partC";			pathStr2 = "device://partA/partX/partY/../../partB/partC";			assertTrue( "Ddotted deviced path equals",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "partA/partX/../partB/partC";			pathStr2 = "device://partA/partX/partY/../../partB/partC";			assertFalse( "Ddotted deviced/abs path different",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "partA/partB/partC";			pathStr2 = "./partA/partB/partC";			assertFalse( "Simple rel/abs path different",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "partA/partX/../partB/partC";			pathStr2 = "./partA/partX/partY/../../partB/partC";			assertFalse( "Ddotted rel/abs path different",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "./partA/partX/../partB/partC";			pathStr2 = "./partA/partX/partY/../../partB/partC";			assertTrue( "Ddotted relative path equals",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "../partA/partB/partC";			pathStr2 = "./partA/partB/partC";			assertFalse( "front Ddotted relative path diff",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "../partA/partB/partC";			pathStr2 = "../partA/partB/partC";			assertTrue( "front Ddotted path equals",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );			pathStr1 = "../../partA/partB/partC";			pathStr2 = "../partA/partB/partC";			assertFalse( "front Ddotted path diff",  new Path( pathStr1 ).equals( new Path( pathStr2 ) ) );		}
		
		public function testClone() : void {			var pathStr1 : String;						pathStr1 = "partA/partB/partC";			assertTrue( "simple path equals",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "partA/partB/partC///";			assertTrue( "less simple path equals",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "partA/partX/../partB/partC";			assertTrue( "Ddotted path equals",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "device://partA/partB/partC";			assertTrue( "deviced path equals",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "device:partA/partB/partC//";			assertTrue( "deviced path equals 2",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "device://partA/partX/../partB/partC";			assertTrue( "Ddotted deviced path equals",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "partA/partB/partC";			assertTrue( "Simple rel/abs path different",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "partA/partX/../partB/partC";			assertTrue( "Ddotted rel/abs path different",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "./partA/partX/../partB/partC";			assertTrue( "Ddotted relative path equals",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "../partA/partB/partC";			assertTrue( "front Ddotted relative path diff",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "../partA/partB/partC";			assertTrue( "front Ddotted path equals",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );			pathStr1 = "../../partA/partB/partC";			assertTrue( "front Ddotted path diff",  new Path( pathStr1 ).equals( new Path( pathStr1 ).clone() ) );		}
		
		public function testInvalidPath() : void {						var pathStr : String;			var path : Path;						var thrown : Boolean = false;			thrown = false;			pathStr = "device://partA/../../partB/partC";						try {	path = new Path( pathStr );			} catch ( e : Error ) {	thrown = true;}			assertTrue( "testInvalidPath" , thrown );		}
		
		public function testAppend() : void {						var pathStr1 : String, pathStr2 : String, resStr : String;			var append : IPath;						pathStr1 = "partA/partB";			pathStr2 = "partC";			resStr   = "partA/partB/partC";			append = new Path( pathStr1 ).append( new Path( pathStr2 ) );			testBasicSegments( append );			assertTrue( new Path( resStr ).equals( append ) );			pathStr1 = "//partA/partB//";			pathStr2 = "//partC//";			resStr   = "partA/partB/partC";			append = new Path( pathStr1 ).append( new Path( pathStr2 ) );			testBasicSegments( append );			assertTrue( append is Path );			assertTrue( new Path( resStr ).equals( append ) );			pathStr1 = "./partA/partB//";			pathStr2 = "./partC//";			resStr   = "./partA/partB/partC";			append = new Path( pathStr1 ).append( new Path( pathStr2 ) );			testBasicSegments( append );			assertTrue( append is Path );			assertTrue( new Path( resStr ).equals( append ) );			pathStr1 = "../../partA/partB//";			pathStr2 = "./partC//";			resStr   = "../../partA/partB/partC";			append = new Path( pathStr1 ).append( new Path( pathStr2 ) );			testBasicSegments( append );			assertTrue( append is Path );			assertTrue( new Path( resStr ).equals( append ) );			pathStr1 = "../../partA/partX/partY/partJ/../partZ/partW";			pathStr2 = "../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC";			resStr   = "../../partA/partB/partC";			append = new Path( pathStr1 ).append( new Path( pathStr2 ) );			testBasicSegments( append );			assertTrue( append is Path );			assertTrue( new Path( resStr ).equals( append ) );			pathStr1 = "device://partA/partX/partY/partJ/../partZ/partW?varA=valA";			pathStr2 = "../../../../partX/partY/partJ/../partZ/partW/../../../../partB/partC?varB=valB&varC=valC";			resStr   = "device:partA/partB/partC?varA=valA&varB=valB&varC=valC";			append = new Path( pathStr1 ).append( new Path( pathStr2 ) );			testBasicSegments( append );			assertTrue( append is Path );			assertTrue( new Path( resStr ).equals( append ) );						pathStr1 = "./partA/partB//";			pathStr2 = "device://partC//";			resStr   = "./partA/partB/partC";			append = new Path( pathStr1 ).append( new Path( pathStr2 ) );			testBasicSegments( append );			assertTrue( append is Path );			assertTrue( new Path( resStr ).equals( append ) );			pathStr1 = "device://partA//";			pathStr2 = "./partB/partC/";			resStr   = "device:/partA/partB/partC";			append = new Path( pathStr1 ).append( new Path( pathStr2 ) );			testBasicSegments( append );			assertTrue( append is Path );			assertTrue( new Path( resStr ).equals( append ) );			pathStr1 = "device:/";			pathStr2 = "./partA/partB/partC/";			resStr   = "device:/partA/partB/partC";			append = new Path( pathStr1 ).append( new Path( pathStr2 ) );			testBasicSegments( append );			assertTrue( append is Path );			assertTrue( new Path( resStr ).equals( append ) );		}
		
		public function testMakeAbsolute() : void {						var pathStr : String;			var parentStr : String;			pathStr = "../../partB/partC";			parentStr = "partA/partX/partY";			testBasicSegments( new Path( pathStr ).makeAbsolute( new Path( parentStr ) ) );						pathStr = "../../partB/partZ/partW/../../partC";			parentStr = "partA/partX/partX/partY/partJ/../partZ/partW/../../../../partY";			testBasicSegments( new Path( pathStr ).makeAbsolute( new Path( parentStr ) ) );						pathStr = "partA/partX/partY";			assertTrue( new Path( pathStr ).makeAbsolute( new Path( parentStr ) ).equals( new Path( pathStr ) ) );					}		public function testMakeRelative() : void {						var pathStr : String;			var parentStr : String;			var result : String;			parentStr = "c:/a/b/c";			pathStr = "c:/a/b/c/d/e/f";			result = "./d/e/f";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );

			parentStr = "c:/a/b/x/y";			pathStr = "c:/a/b/c/d";			result = "../../c/d";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "x/y/y";			pathStr = "a/b/c/d";			result = "../../../a/b/c/d";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "a/b/c/d";			pathStr = "a/b/c/d";			result = "./";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "";			pathStr = "a/b/c/d";			result = "./a/b/c/d";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "a/b";			pathStr = "a/b/c/d";			result = "./c/d";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "a/b/c/d";			pathStr = "a/b/";			result = "../../";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "a/b/c/d";			pathStr = "";			result = "../../../../";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "c:/i/b/x/y";			pathStr = "c:/j/b/c/d";			result = "../../../../j/b/c/d";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "c:/i/b/c/d";			pathStr = "c:/j/b/c/d";			result = "../../../../j/b/c/d";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "c:/a/x/c/d";			pathStr = "c:/a/y/c/d";			result = "../../../y/c/d";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "c:/a/x/XXX/../c/d";			pathStr = "c:/a/y/c/TTTT/../d";			result = "../../../y/c/d";			assertTrue( new Path( pathStr ).makeRelative( new Path( parentStr ) ).equals( new Path( result ) ) );			parentStr = "c:/i/b/c/d";			pathStr = "d:/j/b/c/d";			assertNull( new Path( pathStr ).makeRelative( new Path( parentStr ) ) );					}		
		
		
		private function testBasicSegments( path : IPath ) : void {						assertEquals( 3 , path.segments( ).length );			assertEquals( "partA" , path.segments( )[0] );			assertEquals( "partB" , path.segments( )[1] );			assertEquals( "partC" , path.segments( )[2] );		}	}}