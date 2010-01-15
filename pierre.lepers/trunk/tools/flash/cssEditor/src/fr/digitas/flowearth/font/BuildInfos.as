package fr.digitas.flowearth.font {
	import flash.events.EventDispatcher;	
	import flash.desktop.NativeProcess;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;	

	/**
	 * @author Pierre Lepers
	 */
	public class BuildInfos extends EventDispatcher {

		
		
		public function BuildInfos( process : NativeProcess ) {
			_process = process;
			_init( );
		}
		
			
		public function get logs() : String {
			return _logs;
		}
		
		public function get errors() : String {
			return _errors;
		}
		
		public function isComplete() : Boolean {
			return _complete;
		}

		public function hasFailed() : Boolean {
			if( ! _complete ) return false;
			return _failed;
		}

		
		
		public function dispose() : void {
			try {
				_process.exit();
			} catch( e : Error ) {
				
			}

			_process.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
            _process.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
            _process.removeEventListener(NativeProcessExitEvent.EXIT, onExit);
            _process.removeEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
            _process.removeEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
            _process.removeEventListener(Event.ACTIVATE, onActivate );
		}

		
		private function _init() : void {
			_process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
            _process.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
            _process.addEventListener(NativeProcessExitEvent.EXIT, onExit);
            _process.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
            _process.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
            _process.addEventListener(Event.ACTIVATE, onActivate);
            
            _logs = "";
            _errors = "";
		}
		
		private function onOutputData(event : ProgressEvent) : void {
			_logs += _process.standardOutput.readUTFBytes(_process.standardOutput.bytesAvailable);
		}

		private function onErrorData(event : ProgressEvent) : void {
			_errors += _process.standardError.readUTFBytes(_process.standardError.bytesAvailable);
			
		}

		private function onExit(event : NativeProcessExitEvent) : void {
			_complete = true;
			var code : Number = event.exitCode;
			_failed = (code != 0);
		}

		private function onIOError(event : IOErrorEvent) : void {
			
		}

		private function onActivate(event : Event) : void {
			
		}

		
		private var _process : NativeProcess;

		private var _complete : Boolean = false;

		private var _failed : Boolean = false;
		
		private var _logs : String;
		private var _errors : String;
	
	}
}
