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


package fr.digitas.flowearth.text.styles {	import asunit.framework.TestCase;
	
	import fr.digitas.flowearth.conf.Conf;
	
	import flash.text.TextField;	

	public class StyleExtendsTest extends TestCase {		public function StyleExtendsTest(testMethod : String = null) {			super( testMethod );		}		override public function run() : void {			styleManager.autoEmbed = false;			var cssText : String = Conf.getString( "css_extends" );			styleManager.addCss( cssText );			styleManager.autoEmbed = true;						super.run( );		}		public function testSimpleExtends() : void {						var sname : String;			var s : AdvancedFormat;			var pcount : int;			var pp : String;			pp;						// A			pcount = 0;			sname = "extA";			s = styleManager.getStyle( sname );						assertNotNull( sname + " not null" , s );			assertEquals( "0xFF0000" , s.getObject( ).color );			assertEquals( "10" , s.getObject( ).size );									for( pp in s.getObject( ) )				pcount ++;						assertEquals( "num props " + sname , 2 , pcount );						// B>A			pcount = 0;			sname = "extB";			s = styleManager.getStyle( sname );						assertNotNull( sname + " not null" , s );			assertEquals( "0xFF0000" , s.getObject( ).color );			assertEquals( "true" , s.getObject( ).background );			assertEquals( "8" , s.getObject( ).size );			for( pp in s.getObject( ) ) 				pcount ++;						assertEquals( "num props " + sname , 3 , pcount );			// C>B			pcount = 0;			sname = "extC";			s = styleManager.getStyle( sname );						assertNotNull( sname + " not null" , s );			assertEquals( "0xFF0000" , s.getObject( ).color );			assertEquals( "false" , s.getObject( ).background );			assertEquals( "12" , s.getObject( ).size );			for( pp in s.getObject( ) ) 				pcount ++;						assertEquals( "num props " + sname , 3 , pcount );			// D>C			pcount = 0;			sname = "extD";			s = styleManager.getStyle( sname );						assertNotNull( sname + " not null" , s );			assertEquals( "0x000000" , s.getObject( ).color );			assertEquals( "false" , s.getObject( ).background );			assertEquals( "12" , s.getObject( ).size );			for( pp in s.getObject( ) ) 				pcount ++;						assertEquals( "num props " + sname , 3 , pcount );		}
		public function testTfApply() : void {			var sname : String;			var s : AdvancedFormat;			var tf : TextField = new TextField();						// D>C			sname = "extD";			s = styleManager.getStyle( sname );			s.format( tf );						assertFalse( sname+" tf.background ", tf.background );			assertTrue( sname+" tf.defaultTextFormat.size" ,( tf.defaultTextFormat.size == 12 ) );			assertTrue( sname+" tf.defaultTextFormat.color", ( tf.defaultTextFormat.color == 0 ) );			// E>D			sname = "extE";			s = styleManager.getStyle( sname );			s.format( tf );						assertTrue( sname+" tf.background ", tf.background );			assertTrue( sname+" tf.defaultTextFormat.size" ,( tf.defaultTextFormat.size == 12 ) );			assertTrue( sname+" tf.defaultTextFormat.color", ( tf.defaultTextFormat.color == 0 ) );			// .E>D			sname = ".extE";			s = styleManager.getStyle( sname );			s.format( tf );						assertTrue( sname+" tf.background ", tf.background );			assertTrue( sname+" tf.defaultTextFormat.size" ,( tf.defaultTextFormat.size == 12 ) );			assertTrue( sname+" tf.defaultTextFormat.color", ( tf.defaultTextFormat.color == 0 ) );						// D>C			sname = ".extD";			s = styleManager.getStyle( sname );			s.format( tf );						assertFalse( sname+" tf.background ", tf.background );			assertTrue( sname+" tf.defaultTextFormat.size" ,( tf.defaultTextFormat.size == 12 ) );			assertTrue( sname+" tf.defaultTextFormat.color", ( tf.defaultTextFormat.color == 0 ) );					}	}}