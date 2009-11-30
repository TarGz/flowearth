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
			addChild( _scroll = new Scroller_FC() );
			_initKeyManager();
			super( );
		}
		

		public function setCss( css : CSS ) : void {
			dispose( );
			_css = css;
			_scroll.addChild( _table = new StylesTable() );
			_table.addEventListener( Event.RESIZE , onTableResize );
			_table.init( css );
			_table.width = bg.width;
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
			_css = null;
			if( _table )
				_scroll.removeChild( _table );
			_table = null;
		}
		
		
		private function onTableResize(event : Event) : void {
			if( event.bubbles )
				event.stopImmediatePropagation( );
			_scroll.invalidate();
		}
		
		
		private function _initKeyManager() : void {
			addEventListener( KeyboardEvent.KEY_DOWN , onKeyDown );
		}
		
		private function onKeyDown(event : KeyboardEvent) : void {
			
			if( event.ctrlKey && event.charCode == "s".charCodeAt(0) )
				save();
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
