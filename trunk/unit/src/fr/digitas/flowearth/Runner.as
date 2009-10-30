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
