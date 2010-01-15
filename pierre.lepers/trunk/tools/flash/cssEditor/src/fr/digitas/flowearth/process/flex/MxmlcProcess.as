package fr.digitas.flowearth.process.flex {
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;	

	/**
	 * @author Pierre Lepers
	 */
	public class MxmlcProcess {

		public function MxmlcProcess() {

		}

		public static function run( config : MxmlcConfiguration ) : NativeProcess {
			
			var npsi : NativeProcessStartupInfo = new NativeProcessStartupInfo( );
			npsi.executable = new File( MXMLC_EXE );
			npsi.arguments = config.getArguments();
			npsi.workingDirectory = config.workingDirectory;
			
			var np : NativeProcess = new NativeProcess();
			
			np.start( npsi );
			
			if( log ) {
				logProcess( np );
				
			}
			
			return np;
		}

		private static const MXMLC_EXE : String = "app:/deploy/includes/flex_compiler/bin/mxmlc.exe";
		
		
		private static function logProcess(p : NativeProcess) : void {
			
			p.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
            p.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
            p.addEventListener(NativeProcessExitEvent.EXIT, onExit);
            p.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
            p.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
            p.addEventListener(Event.ACTIVATE, onActivate);
			
		}
		
		public static function onActivate(event:Event):void
        {
            trace("MxmlcProcess---> "+event);
        }
        public static function onOutputData(event:ProgressEvent):void
        {
        	var p : NativeProcess = event.currentTarget as NativeProcess;
			trace("MxmlcProcess---> Got: ", p.standardOutput.readUTFBytes(p.standardOutput.bytesAvailable)); 
        }
        
        public static function onErrorData(event:ProgressEvent):void
        {
        	var p : NativeProcess = event.currentTarget as NativeProcess;
            trace("MxmlcProcess---> ERROR -", p.standardError.readUTFBytes(p.standardError.bytesAvailable));
             
			p.removeEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
            p.removeEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
            p.removeEventListener(NativeProcessExitEvent.EXIT, onExit);
            p.removeEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
            p.removeEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
            p.removeEventListener(Event.ACTIVATE, onActivate);
        }
        
        public static function onExit(event:NativeProcessExitEvent):void
        {
        	var p : NativeProcess = event.currentTarget as NativeProcess;
            trace("MxmlcProcess---> Process exited with ", event.exitCode);
        }
        
        public static function onIOError(event:IOErrorEvent):void
        {
             trace("MxmlcProcess--->"+ event.toString());
        }
		
		public static var log : Boolean = false;
	}
}
