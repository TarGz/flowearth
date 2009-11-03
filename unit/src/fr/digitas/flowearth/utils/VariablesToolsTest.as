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


package fr.digitas.flowearth.utils {	import asunit.framework.TestCase;
	
	import flash.net.URLVariables;	

	public class VariablesToolsTest extends TestCase {		public function VariablesToolsTest(testMethod:String = null) {			super(testMethod);		}
		
		public function testEqualsSimple() : void {						var vars1 : URLVariables = new URLVariables();			vars1.var1 = "val1";			vars1.intId = 12;			vars1.numId = 12.54;			var vars2 : URLVariables = new URLVariables();			vars2.numId = 12.54;			vars2.intId = 12;			vars2.var1 = "val1";			var vars3 : URLVariables = new URLVariables();			vars3.numId = 12.54;			vars3.intId = 12;			vars3.var1 = "valDiff";						assertTrue( "test simple equality" , VariablesTools.equals( vars1 , vars2 ) );			assertFalse( "test simple equality" , VariablesTools.equals( vars1 , vars3 ) );					}		public function testEqualsDiffConstruct() : void {						var vars1 : URLVariables = new URLVariables();			vars1.var1 = "val1";			vars1.intId = 12;			vars1.numId = 12.54;			var varsString : String = "var1=val1&intId=12&numId=12.54";			var vars2 : URLVariables = new URLVariables( varsString );			var varsString3 : String = "var1=val1&intId=12&numId=12.543";			var vars3 : URLVariables = new URLVariables( varsString3 );									assertTrue( "testEqualsDiffConstruct" , VariablesTools.equals( vars1 , vars2 ) );			assertFalse( "testEqualsDiffConstruct" , VariablesTools.equals( vars1 , vars3 ) );					}	}}