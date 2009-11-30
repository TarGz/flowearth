package fr.digitas.flowearth.csseditor.data.errors {

	/**
	 * @author Pierre Lepers
	 */
	public class ValidityState {
		
		public static const OK_LEVEL 	: int = 0;
		public static const WARN_LEVEL 	: int = 1;
		public static const ERROR_LEVEL : int = 2;
		
		public function get level() : int {
			return _level;
		}
		
		public function get msg() : String {
			return _msg;
		}
		
		public function ValidityState( msg : String , level : int ) {
			_msg = msg;
			_level = level;
		}

		private var _level : int;

		private var _msg : String;
		
	}
}
