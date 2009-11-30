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



package fr.digitas.flowearth {
	import asunit.textui.ResultPrinter;
	import asunit.textui.TestRunner;
	
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.profiler.profile;	

	/**
	 * @author Pierre Lepers
	 */
	public class Runner extends TestRunner {

		public static var stage : Stage;

		
		public function Runner() {
			super( );
			
			Runner.stage = stage;
			
			profile( true );
			
			
			start( fr.digitas.flowearth.AllTests, null, true );
		}

		override protected function addedHandler(event : Event) : void {
			super.addedHandler( event );
			stage.addEventListener( Event.RESIZE, resizeLogo );
		}

		private function resizeLogo( e : Event ) : void {
			if( logo ) logo.x = (stage.stageWidth - 244 ) / 2;
		}

		override public function setPrinter(printer : ResultPrinter) : void {
			if(fPrinter == null) {
				fPrinter = new ResultPrinter( Version.major + "." + Version.minor + "." + Version.build );
				addChild( fPrinter );
				
				logo = new Loader( );
				logo.load( new URLRequest( "assets/img/UnitTestr.png" ) );
				fPrinter.addChild( logo );
			}
		}

		private var logo : Loader;
	}
}
