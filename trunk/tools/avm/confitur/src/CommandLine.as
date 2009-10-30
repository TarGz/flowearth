package {
	import flash.utils.Dictionary;	

	/**
	 * @author pierre
	 */
	public class CommandLine {

		public function isEmpty() : Boolean {
			return _empty;
		}

		
		public function CommandLine( arguments : Array ) {
			_init();
			_build(arguments);
		}

		private var _basedir : String;

		private var _report : String;

		private var _sp : String;

		private var _class : String;

		private var _inputs : Array;

		private var _generateQNamesAccess : Boolean;

		private var _help : Boolean;

		
		private function _build(arguments : Array) : void {
			
			
			_empty = arguments.length == 0;
			var arg : String;
			while( arguments.length > 0 ) {
				arg = arguments.shift();
				//				if( !isAnArgument( arg ) )
				//					throw new Error(arg+" is not a valid argument" );
				var handler : Function = _argHandlers[ arg ];
				if( handler == undefined )
					throw new Error(arg + " is not a valid argument." + HELP);
					
				handler(arguments);
			}
		}

		
		private function handleDir( args : Array ) : void {
			if( _basedir != null )
				throw new Error("-dir argument cannot be define twice." + HELP);
			_basedir = formatPath( args.shift() );
		}

		private function handleIn( args : Array ) : void {
			if( _inputs == null ) _inputs = [];
			_inputs.push( formatPath( args.shift() ) );
		}

		private function handleReport( args : Array ) : void {
			if( _report != null )
				throw new Error("-report argument cannot be define twice." + HELP);
			_report = args.shift();
		}

		private function handleSrcPath( args : Array ) : void {
			if( _sp != null )
				throw new Error("-sp argument cannot be define twice." + HELP);
			_sp = formatPath( args.shift() );
		}

		private function handleClassName( args : Array ) : void {
			if( _class != null )
				throw new Error("-class argument cannot be define twice." + HELP);
			_class = args.shift();
		}

		private function handleQNAccess( args : Array ) : void {
			_generateQNamesAccess = true;
		}

		private function handleHelp( args : Array ) : void {
			_help = true;
		}

		private function _init() : void {
			_argHandlers = new Dictionary();
			
			_argHandlers[ "-dir" ] = handleDir;
			_argHandlers[ "-in" ] = handleIn;
			_argHandlers[ "-report" ] = handleReport;
			_argHandlers[ "-sp" ] = handleSrcPath;
			_argHandlers[ "-class" ] = handleClassName;
			_argHandlers[ "-help" ] = handleHelp;
			_argHandlers[ "-qn" ] = handleQNAccess;
		}
		
		private function formatPath( str : String ) : String {
			return str.AS3::replace( /\\/g, "/" );
		}
		
		private var _empty : Boolean = true;

		private var _argHandlers : Dictionary;

		private static function isAnArgument( arg : String ) : Boolean {
			return (arg.AS3::charAt(0) == "-" && (arg.length > 1) && ( isNaN(parseInt(arg.AS3::charAt(1)))));
		}

		private static const HELP : String = " -help for more infos."
		
		
		
		public function get basedir() : String {
			return _basedir;
		}

		public function get report() : String {
			return _report;
		}

		public function get sourcePath() : String {
			return _sp;
		}

		public function get className() : String {
			return _class;
		}
		
		public function get inputs() : Array {
			return _inputs;
		}
		
		public function get help() : Boolean {
			return _help;
		}
		
		public function get generateQNamesAccess() : Boolean {
			return _generateQNamesAccess;
		}
	}
}
