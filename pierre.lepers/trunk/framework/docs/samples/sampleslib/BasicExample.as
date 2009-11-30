package {
	import flash.text.TextFormat;	
	import flash.events.Event;	
	import flash.text.TextField;	
	import flash.display.StageScaleMode;	
	import flash.display.StageAlign;	
	import flash.display.Sprite;
	
	/**
	 * @author Pierre Lepers
	 */
	public class BasicExample extends Sprite {

		
		public function BasicExample() {
			__init__( );
		}
		
		protected function trace( ...args ) : void {
			if( _logField == null ) createLogField( );
			for each (var str : String in args) {
				_logField.appendText( str + "\n" );
			}
		}
		
		protected function get flashvars() : Object {
			return loaderInfo.parameters;
		}

		protected function get baseUrl() : String {
			return loaderInfo.parameters.basepath || ".";
		}
		
		private function __init__() : void {
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.addEventListener( Event.RESIZE , onStageResize );
			onStageResize( );
		}
		

		private function createLogField() : void {
			_logField = new TextField( );
			_logField.x = _logField.y = 5;
			_logField.selectable = true;
			_logField.multiline = true;
			_logField.defaultTextFormat = new TextFormat( 
															"_sans",
															12
														);
			
			addChildAt( _logField , 0 );
			
			stage.addEventListener( Event.RESIZE , onResizeLogField );
			onResizeLogField( null );
		}

		private function onResizeLogField( event : Event ) : void {
			_logField.height = stage.stageHeight - 10;
			_logField.width = stage.stageWidth - 5;
		}

		private var _logField : TextField;
		
		
		private function onStageResize(event : Event = null ) : void {
			rightSide.x = stage.stageWidth;
			bottomSide.y = stage.stageHeight;
		}

		protected var rightSide : Sprite = addChild( new Sprite() ) as Sprite;
		protected var bottomSide : Sprite = addChild( new Sprite() ) as Sprite;

	}
}
