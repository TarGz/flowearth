package fr.digitas.flowearth.csseditor.view.builds {
	import fr.digitas.flowearth.ui.scroller.Scroller;
	import fr.digitas.flowearth.ui.scroller.Scroller_FC;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;		

	/**
	 * @author Pierre Lepers
	 */
	public class BuildsView extends Sprite {
		
		public function BuildsView() {
			_build( );
		}
		

		
		private function onTableResize(event : Event) : void {
			if( event.bubbles )
				event.stopImmediatePropagation( );
			_scroll.update();
		}

		
		override public function set width(value : Number) : void {
			bg.width = value;
			_scroll.width = value;
			if( _table ) _table.width = _scroll.width;
		}

		override public function set height(value : Number) : void {
			bg.height = value;
			_scroll.height = value;
		}
		
		private function _build() : void {
			addChild( bg = new Shape() );
			bg.graphics.beginFill( 0xffffff );
			bg.graphics.drawRect(0, 0, 150, 150 );
			
			_scroll = new Scroller_FC( );
			addChild( _scroll );

			_scroll.addChild( _table = new BuildTable( ) );
			_table.addEventListener( Event.RESIZE , onTableResize );
			_table.width = bg.width;
			_scroll.update( );
		}

	
		
		
		private var _table : BuildTable;

		private var _scroll : Scroller;
		
		private var bg : Shape;
		
	}
}
