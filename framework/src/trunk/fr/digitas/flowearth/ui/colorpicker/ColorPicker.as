package fr.digitas.flowearth.ui.colorpicker {
	import flash.ui.Keyboard;	
	import flash.events.KeyboardEvent;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;	

	/**
	 * @author Pierre Lepers
	 */
	public class ColorPicker extends Sprite {

		public var skin : PickerSkin;
		public var selector : SelectorSkin;

		public function ColorPicker() {
			_build( );
		}
		
		
		
		private function _build() : void {
			removeChild( selector );
			selector = null;
			
			addEventListener( MouseEvent.MOUSE_DOWN , onDown );
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}

		private function onAdded( e : Event ) : void {
		}
		
		private function onRemoved( e : Event ) : void {
			close();
		}
		
		private function onDown(event : MouseEvent) : void {
			if( _tview ) return;
			open();
			addEventListener( MouseEvent.CLICK  , onClick );
		}

		private function open() : void {
			if( _tview ) return;
			_tview = TiledView.getView( );
			
			var pos : Point = localToGlobal( new Point( 0 , skin.height + 1 ) );
			
			_tview.x = pos.x;
			_tview.y = pos.y;
			stage.addChild( _tview );
			
			_tview.clear();
			_tview.deepValue = _color;
			_tview.addEventListener( Event.CLOSE , onTViewremoved );
			_tview.addEventListener( MouseEvent.CLICK  , onTviewClick );
			
			_tview.addEventListener( Event.CHANGE , onColorChange );
			_tview.addEventListener( Event.COMPLETE , onColorComplete);
			
			stage.addEventListener( MouseEvent.CLICK  , onStageClick );
			stage.addEventListener( KeyboardEvent.KEY_DOWN , onStageKeyDown );
		}

		private function onTViewremoved(event : Event) : void {
			_tview.removeEventListener( Event.CLOSE , onTViewremoved );
			_tview.removeEventListener( MouseEvent.CLICK  , onTviewClick );

			_tview.removeEventListener( Event.CHANGE , onColorChange );
			_tview.removeEventListener( Event.COMPLETE , onColorComplete);

			stage.removeEventListener( MouseEvent.CLICK , onStageClick );
			stage.removeEventListener( KeyboardEvent.KEY_DOWN , onStageKeyDown );
			
			color = _tview.deepValue;
			dispatchEvent( new Event( Event.CHANGE ) );
			
			_tview = null;
		}

		private function close() : void {
			if( ! _tview ) return;
			_tview.parent.removeChild( _tview );
			_tview.clear();
		}

		private function onStageKeyDown(event : KeyboardEvent) : void {
			if( event.keyCode == Keyboard.ESCAPE ) {
				onColorComplete(null);
			}
		}

		
		private function onColorComplete(event : Event) : void {
			
			color = _tview.deepValue;
			dispatchEvent( new Event( Event.CHANGE ) );
			close();
		}

		private function onColorChange(event : Event) : void {
			_color = _tview.value;
			dispatchEvent( event );
		}
		
		private function onStageClick(event : MouseEvent) : void {
			onColorComplete(null);
		}

		private function onClick(event : MouseEvent) : void {
			removeEventListener( MouseEvent.CLICK , onClick );
			event.stopPropagation();
		}
		
		private function onTviewClick (event : MouseEvent) : void {
			event.stopPropagation();
		}
		
		private var _tview : TiledView;
		
		private var _color : uint;
		
		public function get color() : uint {
			return _color;
		}
		
		public function set color(color : uint) : void {
			_color = color;
			skin.color = _color;
		}
	}
}
