
package {
	import flash.net.URLRequest;
	import avmplus.System;	
	import avmplus.File;
	import fr.digitas.flowearth.conf.Configuration;

	public class Main {
		
		function Main( arguments : Array ) {
			
			cmdl = new CommandLine( arguments );
			
			if( cmdl.isEmpty() ) {
				HelpPrinter.print();
				System.exit( 0 );
			}
			
			conf = new Configuration( cmdl.basedir );
			
			for each (var input : String in cmdl.inputs ) 
				conf.loadXml( new URLRequest( input ) );
			
			if( cmdl.sourcePath )
				ouputAs( );
			
			
			
			
			
		
		}
		
		private function ouputAs() : void {
			
//			var ash : URLRequestHelper = new URLRequestHelper( new URLRequest( cmdl.asfile ) );
//			if( ash)
			
			var builder : AsBuilder = new AsBuilder( conf, cmdl );
			
			if ( cmdl.className )
				builder.className = cmdl.className;
			
			builder.generate( cmdl.sourcePath );
			
			
		}

		private var cmdl : CommandLine;

		private var conf : Configuration;
	}
	
}


include "AsBuilder.as"
include "CommandLine.as"
include "HelpPrinter.as"

import avmplus.System;

var confitur : Main = new Main( System.argv );
