package fr.digitas.flowearth.csseditor.view.editor {
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.ui.scroller.Scroller;
	import fr.digitas.flowearth.ui.scroller.Scroller_FC;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;	

	/**
	 * @author Pierre Lepers
	 */
	public class StyleEditor extends Sprite {

		public var bg : Sprite;

		
		public function StyleEditor() {
			addChildAt( bg = new StyleEditorBg_FC(), 0 );
			_scroll = new Scroller_FC();
			addChild( _scroll );
			_scroll.addEventListener( Scroller.SCROLL_CHANGE , onScrollChange );
			_initKeyManager();
			
			super( );
		}
		
		private function onScrollChange(event : Event) : void {
			if( !_table ) return;
			_table.renderZone( _scroll.bounds );
		}

		
		public function setCss( css : CSS ) : void {
			dispose( );
			_css = css;
			_css.addEventListener( Event.CLOSE , onCssClosed );
			_scroll.addChild( _table = new StylesTable() );
			_table.addEventListener( Event.RESIZE , onTableResize );
			_table.init( css );
			_table.width = bg.width;
			_scroll.update( );
		}
		

		override public function set width(value : Number) : void {
			bg.width = value;
			_scroll.width = value;
			if( _table ) _table.width = value;
		}

		override public function set height(value : Number) : void {
			bg.height = value;
			_scroll.height = value;
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
		
		private function onTableResize(event : Event) : void {
			if( event.bubbles )
				event.stopImmediatePropagation( );
			_scroll.update();
		}
		
		
		private function _initKeyManager() : void {
			addEventListener( KeyboardEvent.KEY_DOWN , onKeyDown );
		}
		
		private function onKeyDown(event : KeyboardEvent) : void {
			
			if( event.ctrlKey ) {
				if( event.charCode == "s".charCodeAt(0) )
					save();
				else if( event.ctrlKey && event.charCode == "w".charCodeAt(0) )
					_css.close();
			}
		}
		
		private function save() : Boolean {
			_css.save();
			return true;
		}

		private var _css : CSS;

		private var _table : StylesTable;
		
		private var _scroll : Scroller;
		
	}
}
