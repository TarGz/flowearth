package fr.digitas.flowearth.perf {
	import fr.digitas.flowearth.perf.conf.ConfTest;	
	import fr.digitas.flowearth.perf.mvc.BasicVectorTest;	
	import fr.digitas.flowearth.Version;	
	import fr.digitas.flowearth.perf.mvc.NodeTest;	
	import fr.digitas.flowearth.perf.api.Perftest;
	import fr.digitas.flowearth.perf.mvc.PathTest;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.TextField;import flash.utils.setTimeout;		

	/**
	 * @author Pierre Lepers
	 */
	public class Performances extends Sprite {


		public function Performances() {
			
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 3;
			
			_instance = this;
			_build( );
			
			stage.addEventListener( Event.RESIZE, onResize );
			onResize( null );
			
			setTimeout(runNextTest, 1000 );
		}
		
		private function runNextTest() : void {
			if( _testsClasses.length == 0 ) return;
			
			var nextClass : Class = _testsClasses.shift();
			var test : Perftest = new nextClass() as Perftest;
			test.addEventListener( Event.COMPLETE , onTestComlpete );
			test.run();
		}
		
		private function onTestComlpete(event : Event) : void {
			( event.currentTarget as EventDispatcher).removeEventListener( Event.COMPLETE , onTestComlpete );
			setTimeout(runNextTest, 500 );
		}

		
		private function onResize(event : Event) : void {
			
			tf.width = stage.stageWidth;
			tf.height = stage.stageHeight;
			
		}
		
		private function _build() : void {
			
			tf = new TextField();
			addChild( tf );
			
			appendText( "flowearthv"+Version.major + "." + Version.minor+"." + Version.build+"  -  FP"+ Version.player );
			
			_testsClasses = [  ];
			
			_testsClasses.push( ConfTest );
			_testsClasses.push( NodeTest );
			_testsClasses.push( PathTest );
			//_testsClasses.push( BasicVectorTest );
		}

		
		private var _testsClasses : Array;
		
		private var tf : TextField;

		
		
		private static var _instance : Performances;

		public static function appendText( txt : String ) : void {
			_instance.tf.appendText( txt + "\n" );
		}
	}
}
