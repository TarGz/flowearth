package fr.digitas.flowearth.process.flex {
	import flash.filesystem.File;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class MxmlcConfiguration {

		
		
		
		public function MxmlcConfiguration() {
			_sourcePath = new Vector.<String>();
			_libraryPath = new Vector.<String>( );
		}
		
		public function addSource( source : String ) : void {
			_sourcePath.push( source );
		}

		public function addLibrary( lib : String ) : void {
			_libraryPath.push( lib );
		}

		
		
		public var workingDirectory : File;

		public var mainClass : String;

		public var debug : Boolean = false;

		public var useNetwork : Boolean = false;

		public var output : String;
		

		internal function getArguments() : Vector.<String> {
			
			_validate();
			
			var args : Vector.<String> = new Vector.<String>();
			
			var val : String;
			
			for each ( val in _sourcePath ) {
				args.push( "-sp" );
				args.push( val );
			}

			for each ( val in _libraryPath ) {
				args.push( "-l" );
				args.push( val );
			}
			
			args.push( "-debug="+debug );

			args.push( "-use-network="+useNetwork );

			args.push( "-output=" + output );
			
			args.push( "--" );
			args.push( mainClass + "" );
			
			
			
			return args;
		}
		
		private function _validate() : void {
			
			if( !mainClass )
				throw new ArgumentError( "MxmlcConfiguration error : main class not defined" );
			if( ! output)
				throw new ArgumentError( "MxmlcConfiguration error : output not defined" );
			
		}

		private var _sourcePath : Vector.<String>;

		private var _libraryPath : Vector.<String>;

	}
}
