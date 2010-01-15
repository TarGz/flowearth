package fr.digitas.flowearth.csseditor {
	import fr.digitas.flowearth.csseditor.view.MainLayout;
	import fr.digitas.flowearth.process.flex.MxmlcConfiguration;
	import fr.digitas.flowearth.process.flex.MxmlcProcess;
	import fr.digitas.flowearth.text.fonts.FontManagerClass;
	import fr.digitas.flowearth.text.styles.StyleManagerClass;
	
	import flash.desktop.NativeProcess;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.utils.IDataInput;		

	/**
	 * @author Pierre Lepers
	 */
	public class Main extends Sprite {

		
		public function Main() {
			
			StyleManagerClass;
			FontManagerClass;
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			App.run( this );
			
			addChild( new MainLayout( ) );
//			addChild( new TestTabs( ) );

//			testMxmlcProcess();
		}
//		
//		private function testMxmlcProcess() : void {
//			
//			var config : MxmlcConfiguration = new MxmlcConfiguration();
//			
//			config.output = "D:/Documents and Settings/lepersp/Bureau/temp/airMxmlcProcess/Main.swf";
//			config.mainClass = "D:/Documents and Settings/lepersp/Bureau/temp/airMxmlcProcess/Main.as";
//			
//			var p : NativeProcess = MxmlcProcess.run( config );
//			
//			p.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, onOutputData);
//            p.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, onErrorData);
//            p.addEventListener(NativeProcessExitEvent.EXIT, onExit);
//            p.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, onIOError);
//            p.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, onIOError);
//            p.addEventListener(Event.ACTIVATE, onActivate);
//        }
//        public function onActivate(event:Event):void
//        {
//            trace(event);
//        }
//        public function onOutputData(event:ProgressEvent):void
//        {
//        	var p : NativeProcess = event.currentTarget as NativeProcess;
//			trace("Got: ", p.standardOutput.readUTFBytes(p.standardOutput.bytesAvailable)); 
//        }
//        
//        public function onErrorData(event:ProgressEvent):void
//        {
//        	var p : NativeProcess = event.currentTarget as NativeProcess;
//            trace("ERROR -", p.standardError.readUTFBytes(p.standardError.bytesAvailable)); 
//        }
//        
//        public function onExit(event:NativeProcessExitEvent):void
//        {
//            trace("Process exited with ", event.exitCode);
//        }
//        
//        public function onIOError(event:IOErrorEvent):void
//        {
//             trace(event.toString());
//        }
	}
}
