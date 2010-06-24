package fr.digitas.flowearth.ui.colorpicker {
	import flash.ui.Keyboard;	
	import flash.events.KeyboardEvent;	
	
	import fr.digitas.flowearth.event.UintEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;import flash.utils.setTimeout;		

	/**
	 * @author Pierre Lepers
	 */
	public class TiledView extends Sprite {
		
		

		public var preview : ColorPreview;
		
		public var bg : MovieClip;
		
		public var input : TextField;

		
		public function TiledView() {
			_build( );
		}
		
		private function _build() : void {
			_tiles = new TilesCanvas( );
			addChild( _tiles );
			_tiles.x = 4;
			_tiles.y = 26;
			_tiles.addEventListener( TilesCanvas.OVER_COLOR , colorChange );
			_tiles.addEventListener( TilesCanvas.SELECT_COLOR , colorSelected );
			_tiles.addEventListener( MouseEvent.ROLL_OUT , resetDeepValue );
			
			bg.width = _tiles.width + 8;
			bg.height = _tiles.height + 30;
			
			input.maxChars = 7;
			input.borderColor = 0x969696;
			input.addEventListener( FocusEvent.FOCUS_IN , ontfFocusIn );
			input.addEventListener( FocusEvent.FOCUS_OUT , ontfFocusOut );
		}
		

		
		private function resetDeepValue(event : MouseEvent) : void {
			value = deepValue;
		}

		private function colorSelected(event : UintEvent) : void {
			if( _tfFocus ) return;
			deepValue = event.value;
			complete();
		}

		private function colorChange( event : UintEvent ) : void {
			if( _tfFocus ) return;
			value = event.value;
			change();
		}

		private var _tiles : TilesCanvas;

		private var _deepValue : uint;
		private var _value : uint;
		
		
		public function get deepValue() : uint {
			return _deepValue;
		}
		
		public function set deepValue(deepValue : uint) : void {
			_deepValue = deepValue;
			value = _deepValue;
		}

		public function get value() : uint {
			return _value;
		}
		
		public function set value(value : uint) : void {
			_value = value;
			preview.color = _value;
			_updateTf( );
		}
		
		
		private function ontfFocusOut(event : FocusEvent) : void {
			input.removeEventListener( Event.CHANGE , onInputChange );
			input.removeEventListener( KeyboardEvent.KEY_DOWN , onInputKeyDown );
			_tfFocus = false;
		}

		private function ontfFocusIn(event : FocusEvent) : void {
			input.addEventListener( Event.CHANGE , onInputChange );
			input.addEventListener( KeyboardEvent.KEY_DOWN , onInputKeyDown );
			_tfFocus = true;
			setTimeout( selectAllInput, 10 );
		}
		
		private function onInputKeyDown(event : KeyboardEvent) : void {
			if( event.keyCode == Keyboard.ENTER ) {
				complete();
			}
		}
		
		private function complete() : void {
			dispatchEvent( new Event( Event.COMPLETE ) );
		}

		private function change() : void {
			dispatchEvent( new Event( Event.CHANGE ) );
		}

		private function selectAllInput() : void {
			input.setSelection( 0 , input.text.length );
		}

		private function onInputChange(event : Event) : void {
			var val : String = input.text;
			if( val.charAt( 0 ) == "#" )
				val = "0x"+val.substr( 1 );
			else if( !( val.charAt( 0 ) == "0" && val.charAt( 0 ) == "x" ) ) 
				val = "0x"+val;
				
			deepValue = parseInt( val );
		}

		private function _updateTf() : void {
			if( _tfFocus ) return;
			var hex : String = _value.toString( 16 ).toUpperCase();
			while( hex.length < 6 ) hex = "0"+hex;
			input.text = "#" + hex;
		}

		private var _tfFocus : Boolean = false;
		
		
		//_____________________________________________________________________________
		//																		 STATIC
		
		public static function getView() : TiledView {
			if( instance == null ) 
				instance = SelectorSkin.getTiledView();
			return instance;
		}

		private static var instance : TiledView;
		
		public function clear() : void {
			dispatchEvent( new Event( Event.CLOSE ) );
		}
	}
}
