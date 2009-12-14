package fr.digitas.flowearth.csseditor.view.fontprofile {
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.view.editor.StylesTable;
	import fr.digitas.flowearth.ui.scroller.Scroller;
	import fr.digitas.flowearth.ui.scroller.Scroller_FC;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontProfileView extends Sprite {
		
		public function FontProfileView() {
			_build( );
			
		}
		

		public function setCss(css : CSS) : void {
			dispose();
			_css = css;
			_css.addEventListener( Event.CLOSE , onCssClosed );
			_scroll.addChild( _table = new FontsTable( ) );
			_table.addEventListener( Event.RESIZE , onTableResize );
			_table.init( _css.fontProfile );
			_table.width = bg.width;
			_scroll.update( );
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
			
			_scroll = new Scroller_FC();
			addChild( _scroll );
//			_scroll.addEventListener( Scroller.SCROLL_CHANGE , onScrollChange );
//			_initKeyManager();
		}

		private function dispose() : void {
			if( _css )
				_css.removeEventListener( Event.CLOSE , onCssClosed );
			_css = null;
			if( _table ) {
				_scroll.removeChild( _table );
				_table.dispose();
			}
			_table = null;
		}
		
		private function onCssClosed(event : Event) : void {
			dispose();
			
		}

		private var _css : CSS;
		
		private var _table : FontsTable;

		private var _scroll : Scroller;
		
		private var bg : Shape;
		
	}
}
