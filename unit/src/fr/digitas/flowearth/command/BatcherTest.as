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


package fr.digitas.flowearth.command {
	import asunit.framework.TestCase;
	
	import fr.digitas.flowearth.net.BatchLoaderItem;	

	public class BatcherTest extends TestCase {

		
		private var instance : Batcher;

		public function BatcherTest( ) {
			
			super(  );
		}

		protected override function setUp() : void {
			instance = new Batcher( );
			itemA = new BatchLoaderItem( null );
			itemB = new BatchLoaderItem( null );
			itemC = new BatchLoaderItem( null );
			itemD = new BatchLoaderItem( null );
		}

		protected override function tearDown() : void {
			instance = null;
			itemA = null ;
			itemB = null ;
			itemC = null ;
			itemD = null ;
		}

		public function testInstantiated() : void {
			assertTrue( "Batch instantiated", instance is Batcher );
		}

		
		
		public function testNoDoubleAdd() : void {
			instance.addItem( itemA );
			instance.addItem( itemB );
			instance.addItem( itemC );
			
			var a1 : Boolean = instance.weight == 3;
			
			var b2 : Batcher = new Batcher( );
			b2.addItem( itemB ); 

			var a2 : Boolean = instance.weight == 2; 
			var a3 : Boolean = instance.indexOf( itemA ) == 0;
			var a4 : Boolean = instance.indexOf( itemC ) == 1;
			
			
			assertTrue( "No double add a1", a1 );
			assertTrue( "No double add a2", a2 );
			assertTrue( "No double add a3", a3 );
			assertTrue( "No double add a4", a4 );
			
		}

		
		
		public function testReplaceNull() : void {
			instance.addItem( itemA );
			instance.addItem( itemB );
			instance.addItem( itemC );
			
			instance.replaceItem( itemA, null );
			instance.replaceItem( itemB, null );
			instance.replaceItem( itemC, null );
			
			assertTrue( "testReplaceNull", instance.weight == 0  );
		}

		
		
		
		
		
		private var itemA : IBatchable;
		private var itemB : IBatchable;
		private var itemC : IBatchable;
		private var itemD : IBatchable;
	}
}
