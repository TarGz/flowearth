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
	import asunit.framework.AsynchronousTestCase;
	
	import fr.digitas.flowearth.event.BatchErrorEvent;
	import fr.digitas.flowearth.event.BatchEvent;
	import fr.digitas.flowearth.event.BatchStatusEvent;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.StatusEvent;	

	public class BatcherAdvancedTest extends AsynchronousTestCase {

		public function BatcherAdvancedTest(testMethod:String = null) {
			super(testMethod);
		}
		private var dataSource:XML;

		public override function run():void {
			build();
			start( );
		}
		
		private function start () : void {
			_mainBatcher.start();
		}

		protected override function completeHandler(event:Event):void {
			dataSource = XML(event.target.data).copy();
			super.run();
		}


		protected function build():void {
			_statusStr = "";
			_errorsStr = "";
			_completeStr = "";
			_startsStr = "";
			
			_mainBatcher = new Batcher( );
			_mainBatcher.statusMessage = "main";
			_mainBatcher.addEventListener( Event.COMPLETE, onAllComplete );
			_mainBatcher.addEventListener( BatchEvent.ITEM_COMPLETE, onItemComplete );
			_mainBatcher.addEventListener( BatchEvent.ITEM_START, onItemStart );
			_mainBatcher.addEventListener( StatusEvent.STATUS, onStatus );
			_mainBatcher.addEventListener( ErrorEvent.ERROR, onItemError );
			
				_mainBatcher.addItem( new TestItem( 1, 10 ) );
				_mainBatcher.addItem( new TestItem( 2 ) );
				_mainBatcher.addItem( new TestItem( 3, 10, true ) );
				
				var bA : Batcher = new TestBatcher( 90 );
					var bA1 : Batcher = new TestBatcher( 91 );
						bA1.addItem( new TestItem( 4, 10 ));
						bA1.addItem( new TestItem( 5, 10, true ));
						bA1.addItem( new TestItem( 6 ));
					var bA2 : Batcher = new TestBatcher( 92 );
						bA2.addItem( new TestItem( 7 ));
						bA2.addItem( new TestItem( 8, 10 ));
						bA2.addItem( new TestItem( 9, 10 ));
				bA.addItem( bA1 );
				bA.addItem( bA2 );
			
			_mainBatcher.addItem( bA );
				
			_mainBatcher.addItem( new TestItem( 10, 10 ) );

				var bB : Batcher = new TestBatcher( 93 );
					bB.addItem( new TestItem( 11, 10 ));
				_mainBatcher.addItem( bB );
		}
		
		private function onStatus (event : BatchStatusEvent) : void {
			/*FDT_IGNORE*/
			UT_CONFIG::verbose {
			/*FDT_IGNORE*/
				trace( "[bi.command.BatcherAdvancedTest] - onStatus - " + event.messages.join(" , " ) );
			/*FDT_IGNORE*/
			}
			/*FDT_IGNORE*/
			_statusStr += "-"+event.messages.join("," );
		}

		private function onItemError (event : BatchErrorEvent) : void {
			var i : IDiable = event.item as IDiable;
			_errorsStr += i.getStrId();
		}

		private function onItemStart (event : BatchEvent) : void {
			var i : IDiable = event.item as IDiable;
			_startsStr += i.getStrId();
		}

		private function onItemComplete (event : BatchEvent) : void {
			/*FDT_IGNORE*/
			UT_CONFIG::verbose {
			/*FDT_IGNORE*/
				trace( "[bi.command.BatcherAdvancedTest] - onItemComplete - " );
			/*FDT_IGNORE*/
			}
			/*FDT_IGNORE*/
			var i : IDiable = event.item as IDiable;
			_completeStr += i.getStrId();
		}

		private function onAllComplete (event : Event) : void {
			/*FDT_IGNORE*/
			UT_CONFIG::verbose {
			/*FDT_IGNORE*/
				trace( "[bi.command.BatcherAdvancedTest] - onAllComplete - " );
			/*FDT_IGNORE*/
			}
			/*FDT_IGNORE*/
			super.run();
		}

		protected override function tearDown():void {
			
		}

		private var _statusStr 		: String;
		private var _errorsStr 		: String;
		private var _completeStr 	: String;
		private var _startsStr 		: String;

		public function test():void {
			/*FDT_IGNORE*/
			UT_CONFIG::verbose {
			/*FDT_IGNORE*/
				trace( "[bi.command.BatcherAdvancedTest] - status - ", _statusStr );
				trace( "[bi.command.BatcherAdvancedTest] - test - ", _errorsStr );
				trace( "[bi.command.BatcherAdvancedTest] - test - ", _completeStr );
				trace( "[bi.command.BatcherAdvancedTest] - test - ", _startsStr );
			
			/*FDT_IGNORE*/
			}
			/*FDT_IGNORE*/
			assertTrue("failing test", true);
			assertTrue("failing test", true);
		}
		
		public function testStatus() : void {
			assertEquals( "status"	, "-i1,main-i2,main-i3,main-batcher 90 start,main-batcher 91 start,b90,main-i4,b91,b90,main-i5,b91,b90,main-i6,b91,b90,main-batcher 92 start,b90,main-i7,b92,b90,main-i8,b92,b90,main-i9,b92,b90,main-i10,main-batcher 93 start,main-i11,b93,main"
									, _statusStr );	
		}

		public function testErrors() : void {
			assertEquals( "errors"	, "35", _errorsStr );	
		}

		public function testComplete() : void {
			assertEquals( "complete"	, "1246917899290101193", _completeStr );	
		}

//		public function testItemErrors() : void {
//			assertEquals( "Errors"	, "1346917899290101193", _completeStr );	
//		}

		public function testStart() : void {
			assertEquals( "starts"	, "123909145692789109311", _startsStr );	
		}

		
		private var _mainBatcher : Batcher;
	}
}

import fr.digitas.flowearth.command.Batcher;
import fr.digitas.flowearth.command.IBatchable;
import fr.digitas.flowearth.event.BatchErrorEvent;
import fr.digitas.flowearth.event.BatchStatusEvent;

import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.StatusEvent;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

class TestItem extends EventDispatcher implements IBatchable , IDiable {

	
	private var _delay : Number;
	private var _error : Boolean;
	private var _failonError : Boolean;

	
	public function TestItem ( id : int,  delay : Number = 0 , error : Boolean = false, failonError : Boolean = false ) {
		
		this.id = id;
		_failonError = failonError;
		_error = error;
		_delay = delay;
		
	}
	
	
	public var id : int;

	
	public function execute () : void {
		dispatchEvent( new BatchStatusEvent ( StatusEvent.STATUS, this, "i"+id ) );
		if( _delay > 0 ) complete();
		else _timeout = setTimeout( complete, _delay );
	}

	public function get weight () : Number {
		return 1;
	}
	
	public function dispose () : void {
		
	}
	
	private function complete() : void {
		clearTimeout( _timeout );
		if( _error ) 
			dispatchEvent( new BatchErrorEvent( ErrorEvent.ERROR, this, "erreur", _failonError ) );
		else 
			dispatchEvent( new Event( Event.COMPLETE ) );
	}

	
	private var _timeout : uint;
	
	
	public function getId () : int {
		return id;
	}
	
	public function getStrId () : String {
		return String( id );
	}
}


class TestBatcher extends Batcher implements IDiable {

	
	public var id : int;
	
	public function TestBatcher( id : int ) {
		this.id = id;
		super( );
		statusMessage =  "b"+id;
	}

	public override function execute () : void {
		dispatchEvent( new BatchStatusEvent ( StatusEvent.STATUS, this, "batcher "+id+" start" ) );
		super.execute( );
	}

	public function getId () : int {
		return id;
	}
	
	public function getStrId () : String {
		return String( id );
	}
}


interface IDiable {
	function getId() : int;
	function getStrId() : String;	
}
