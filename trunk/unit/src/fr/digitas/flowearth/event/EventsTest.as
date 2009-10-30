////////////////////////////////////////////////////////////////////////////////
//
//  DIGITAS FRANCE / VIVAKI COMMUNICATIONS
//  Copyright 2008-2009 Digitas France
//  All Rights Reserved.
//
//  NOTICE: Digitas permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


package fr.digitas.flowearth.event {
	import asunit.framework.TestCase;
	
	import fr.digitas.flowearth.net.BatchLoaderItem;
	
	import flash.net.URLRequest;	
	public class EventsTest extends TestCase {

		
		public function EventsTest( ) {
			var methodes : Array = ["instanciate", 
										"testInstances", 
										"dispatch", 
										"testDispatch"];
										
			super( methodes.join( "," ) );
		}

		protected override function setUp() : void {
			
		}

		private function onArray( e : ArrayEvent ) : void {
			assertEquals( e.array, pArray );
			arrayResult = true;
		}

		private function onBatchError1( e : BatchErrorEvent ) : void {
			assertEquals( e.item, pBatchItem );
		}
		
		private function onBatchError( e : BatchErrorEvent ) : void {
			assertEquals( e.item, pBatchItem );
			assertEquals( e.failOnError, true );
			assertEquals( e.text, "testError" );
			batchErrorResult = true;
		}

		private function onBatch( e : BatchEvent ) : void {
			assertEquals( e.item, pBatchItem );
			batchResult = true;
		}

		private function onBatchStatus( e : BatchStatusEvent ) : void {
			assertEquals( e.messages[0], "status0" );
			assertEquals( e.messages[1], "status1" );
			assertEquals( e.messages[2], "status2" );
			batchStatusResult = true;
		}

		
		private function onNumber( e : NumberEvent ) : void {
			assertEquals( e.value, 12.4 );
			numberResult = true;
		}

		private function onBool( e : BoolEvent ) : void {
			assertTrue( e.flag );
			boolResult = true;
		}

		private function onXml( e : XmlEvent ) : void {
			assertEquals( e.xml, <root><pierre/></root> );
			xmlResult = true;
		}

		protected override function tearDown() : void {
		}

		public function instanciate() : void {
			
			//array
			pArray = ["1", 2];
			arrayEvent = new ArrayEvent( "array", pArray );
			
			//batchError
			pBatchItem = new BatchLoaderItem( new URLRequest( ) );
			batchErrorEvent = new BatchErrorEvent( "batchError", pBatchItem, "testError", true );
			
			//batch
			batchEvent = new BatchEvent( "batch", pBatchItem );
			
			//batchStatus
			batchStatusEvent = new BatchStatusEvent( "batchStatus", pBatchItem,  "status2", "status0||status1" );
			
			//bool
			boolEvent = new BoolEvent( "bool", true );
			
			//number
			numberEvent = new NumberEvent( "number", 12.4 );
			
			
			//xml
			xmlEvent = new XmlEvent( "xml", <root><pierre/></root> );
		}

		public function testInstances() : void {
			assertTrue( arrayEvent is ArrayEvent );
			assertTrue( batchErrorEvent is BatchErrorEvent );
			assertTrue( batchEvent is BatchEvent );
			assertTrue( batchStatusEvent is BatchStatusEvent );
			assertTrue( boolEvent is BoolEvent );
			assertTrue( numberEvent is NumberEvent );
			assertTrue( xmlEvent is XmlEvent );
		}

		public function dispatch() : void {
			addEventListener( "batchError", onBatchError1 );

			dispatchEvent( arrayEvent );
			dispatchEvent( batchErrorEvent );
			dispatchEvent( batchEvent );
			dispatchEvent( batchStatusEvent );
			dispatchEvent( boolEvent );
			dispatchEvent( numberEvent );
			dispatchEvent( xmlEvent );
			
			addEventListener( "batchError", onBatchError );
			addEventListener( "array", onArray );
			addEventListener( "batch", onBatch );
			addEventListener( "batchStatus", onBatchStatus );
			addEventListener( "number", onNumber );
			addEventListener( "bool", onBool );
			addEventListener( "xml", onXml );

			dispatchEvent( arrayEvent );
			dispatchEvent( batchErrorEvent );
			dispatchEvent( batchEvent );
			dispatchEvent( batchStatusEvent );
			dispatchEvent( boolEvent );
			dispatchEvent( numberEvent );
			dispatchEvent( xmlEvent );
		}

		public function testDispatch() : void {
			assertTrue( "array", arrayResult );
			assertTrue( "batchError", batchErrorResult );
			assertTrue( "batch", batchResult );
			assertTrue( "batchStatus", batchStatusResult );
			assertTrue( "bool", boolResult );
			assertTrue( "number", numberResult );
			assertTrue( "xml", xmlResult );
		}

		
		private var arrayEvent : ArrayEvent;
		private var batchErrorEvent : BatchErrorEvent;
		private var batchEvent : BatchEvent;
		private var batchStatusEvent : BatchStatusEvent;
		private var boolEvent : BoolEvent;
		private var numberEvent : NumberEvent;
		private var xmlEvent : XmlEvent;

		private var pArray : Array;
		private var pBatchItem : BatchLoaderItem;

		private var arrayResult : Boolean = false;
		private var batchErrorResult : Boolean = false;
		private var batchResult : Boolean = false;
		private var batchStatusResult : Boolean = false;
		private var boolResult : Boolean = false;
		private var numberResult : Boolean = false;
		private var xmlResult : Boolean = false;
	}
}
