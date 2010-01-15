package fr.digitas.flowearth.csseditor.view.fontprofile.details {
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.HBlockRenderer;
	import fr.digitas.flowearth.ui.scroller.ScrollBar_FC;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.Font;	

	/**
	 * @author Pierre Lepers
	 */
	public class CharTable extends Sprite {

		
		public function CharTable( font : Font ) {
			_font = font;
			_buildLayout();
			addEventListener( Event.ADDED_TO_STAGE, onAdded );
			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}

		private function onAdded( e : Event ) : void {
		}
		
		private function onRemoved( e : Event ) : void {
			stage.removeEventListener( Event.RENDER , updateLayout );
		}
		
		
		public function set range(range : Array) : void {
			_range = range;
			update( );
		}
		
		private function update( e : Event = null) : void {
			var rangeStart : int = Math.round(  (_allrows - _rows)* _scrollPosition ) * _cols ;
			var l : int = _rows * _cols;
			
			var item : CharTableItem;
			for (var i : int = 0; i < l; i++) {
				item = _items[ i ];
				item.code = _range[ i + rangeStart ];
			}
			
			stage.removeEventListener( Event.RENDER , updateLayout );
			_validcodes = true;
		}

		override public function set height(value : Number) : void {
			
			_height = value;
			_layout.height = value;
			resize();
			invalidate();
		}
		

		override public function set width(value : Number) : void {
			_width = value;
			_layout.width = value;
			_scrollbar.x = value;
			resize();
			invalidate( );
		}
		
		private function resize() : void {
			_cols = Math.floor( _width / CharTableItem.WIDTH );
			_rows = Math.floor( _height / CharTableItem.HEIGHT );
			_allrows = Math.ceil( _range.length / _cols );
			
			_scrollbar.update( _scrollPosition , _allrows*CharTableItem.HEIGHT , _height );
		}

		private function updateLayout(event : Event) : void {
			_items = [];
			_clear( );
			var l : int = _cols * _rows;
			for (var i : int = 0; i < l; i++)
				_items.push( _layout.addChild( new CharTableItem( _font ) ) );
			
			_layout.update();
			update( );
			stage.removeEventListener( Event.RENDER , updateLayout );
			_valid = true;
		}

		private function _clear() : void {
			while( _layout.numChildren > 0 ) 
				_layout.removeChildAt( 0 );
		}

		private function _buildLayout() : void {
			_items = [];
			
			_layout = new Layout();
			_lrenderer = new HBlockRenderer( );
			_layout.renderer = _lrenderer;
			addChild( _layout );
			
			_scrollbar = new ScrollBar_FC( );
			addChild( _scrollbar );
			_scrollbar.addEventListener( Event.CHANGE , onScrollChange );
		}
		
		private function onScrollChange(event : Event) : void {
			scrollPosition = _scrollbar.ownPosition;
		}

		private function invalidate() : void {
			if( ! _valid ) return;
			if( stage ) {
				stage.addEventListener( Event.RENDER , updateLayout );
				stage.invalidate();
			} else 
				addEventListener( Event.ADDED_TO_STAGE , updateLayout );
			
			_valid = false;
		}

		private function invalidatecodes() : void {
			if( ! _validcodes ) return;
			if( stage ) {
				stage.addEventListener( Event.RENDER , update );
				stage.invalidate();
			} else 
				addEventListener( Event.ADDED_TO_STAGE , update );
			
			_validcodes = false;
		}
		

		
		private var _valid : Boolean = true;
		private var _validcodes : Boolean = true;
		
		private var _font : Font;

		
		private var _lrenderer : HBlockRenderer;
		private var _layout : Layout;
		
		private var _scrollbar : ScrollBar_FC;

		private var _height : Number = 500;
		private var _width : Number = 500;
		
		private var _rows : int;
		private var _cols : int;
		private var _allrows : int;
		
		private var _range : Array = FULL_RANGE;

		private static const FULL_RANGE : Array = _getFullRange();
		
		private static function _getFullRange() : Array {
			var a : Array = [];
			for (var i : int = 0; i <= 0xFFFF; i++)
				a.push( i );
			return a;
		}
		
		private var _scrollPosition : Number = 0;
		
		private var _items : Array;
		
		public function get scrollPosition() : Number {
			return _scrollPosition;
		}
		
		public function set scrollPosition(scrollPosition : Number) : void {
			_scrollPosition = scrollPosition;
			update();
		}
	}
}
