package fr.digitas.flowearth.csseditor.view.fontprofile.details {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.Font;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontDetails extends Sprite {
		
		public var rSelector : RangeSelector;

		public function FontDetails() {
		}

		private function onAdded( e : Event ) : void {
			stage.addEventListener( Event.RESIZE , onResize );
			onResize( null );
		}

		private function onRemoved( e : Event ) : void {
			stage.removeEventListener( Event.RESIZE , onResize );
		}

		private var _font : Font;

		private function onResize(event : Event) : void {
			_ctable.width = stage.stageWidth - 20;
			_ctable.height = stage.stageHeight - 60;
		}

		public function init( font : Font ) : void {
			_font = font;
			_rProvider = new RangeProvider( font );
			rSelector.init( _rProvider );
			rSelector.addEventListener( Event.CHANGE , onRangeChange );
			_build( );
		}
		
		private function onRangeChange(event : Event) : void {
			_ctable.range = rSelector.range;
		}

		private function _build() : void {
			_ctable = new CharTable( _font );
			_ctable.x = 10;
			_ctable.y = 35;
			_ctable.width = 600;
			_ctable.height = 600;
			
			addChild( _ctable ); 

			addEventListener( Event.REMOVED_FROM_STAGE , onRemoved );
			if( stage ) 
				onAdded( null );
			else
				addEventListener( Event.ADDED_TO_STAGE , onAdded );
		}

		private var _ctable : CharTable;
		
		private var _rProvider : RangeProvider;
	}
}
