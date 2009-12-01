package fr.digitas.flowearth.ui.tabs {
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.LeftRenderer;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class Tabs extends Sprite {

		public var bg : MovieClip;

		public function Tabs() {
			_buildLayout( );
			_aItems = [];
			_tabMap = new Dictionary( );
			_ctrls = new TabsControls( this );
			_ctrls.y = 4;
			
			addChild( _ctrls );
		}

		public function addItem( tdata : TabData ) : void {
			if( _aItems.indexOf( tdata ) > -1 ) return;
			var tab : Tab = new Tab_FC();
			tab.setData( tdata );
			tab.addEventListener( Event.SELECT , onSelectTab );
			_layout.addChild( tab );
			_layout.itemList.push( tab );
			_aItems.push( tdata );
			_tabMap[ tdata ] = tab;
			_layout.update( );
			tdata.dispatchEvent( new Event( Event.OPEN ) );
		}

		public function removeItem( tdata : TabData ) : void {
			if( _aItems.indexOf( tdata ) == -1 ) return;
			var tab : Tab = _tabMap[ tdata ];
			if( ! tdata.dispatchEvent( new Event( Event.CLOSING, false, true ) ) ) return;
			_layout.removeChild( tab );
			_layout.itemList.splice( _layout.itemList.indexOf( tab ), 1 );
			_aItems.splice( _aItems.indexOf( tdata ), 1 );
			tab.dispose( );
			if( _currentItem == tdata ) _currentItem = null;
			tdata.dispatchEvent( new Event( Event.CLOSE ) );
		}
		
		public function getItemAt( index : int ) : TabData {
			return _aItems[ index ];
		}
		
		public function get length() : uint {
			return _aItems.length;
		}
		
		public function set currentItem ( tdata : TabData ) : void {
			if( _currentItem == tdata) return;
			_currentItem = tdata;
			
			var tab : Tab = _tabMap[ tdata ];
			
			tab.selected = true;
			reorder( tab );
			if( _currentTabData )
				( _tabMap[ _currentTabData ] as Tab ).selected = false;
			_currentTabData = tab.tabData;
			
			dispatchEvent( new Event( Event.CHANGE ) );
		}
		public function get currentItem ( ) :  TabData {
			return _currentItem;
		}
				
		private var _currentItem :  TabData;
				
		
		
		
		
		
		
		override public function set width(value : Number) : void {
			bg.width = value;
			_ctrls.x = value - 2;
			
			onChanging( null );
		}

		override public function set height(value : Number) : void {
			value;
			return;
		}
		
		private function _buildLayout() : void {
			_layout = new Layout( );
			_layout.renderer = new LeftRenderer;
			_layout.y = 25;
			_layout.padding = new Rectangle( 4 );
			_layout.addEventListener( Layout.CHANGING , onChanging );
			_layout.itemList = [];
			addChild( _layout );
		}
		
		private function onChanging( event : Event ) : void {
			var ts : Number = 0;
			for (var i : int = 0; i < _layout.numChildren ; i++) 
				ts += _layout.getChildAt( i ).width;
			
			if( ts > bg.width - _ctrls.width - 20 ) {
				var rest : Number = ( ts - bg.width + 100 ) / ( _layout.numChildren - 1 );
				_layout.margin = new Rectangle( 0, 0, -rest );
			} else {
				_layout.margin = new Rectangle( );
			}
			
		}

		
		private function onSelectTab( event : Event ) : void {
			var tab : Tab = event.currentTarget as Tab;
			currentItem = tab.tabData;
		}
		
		private function reorder( tab  : Tab ) : void {
			var index : int = _layout.itemList.indexOf( tab );
			var i : int;
			
			for ( i = _layout.itemList.length-1; i > index ; i --)
				_layout.addChild( _layout.itemList[i] );
				
			for ( i = 0; i <= index ; i ++)
				_layout.addChild( _layout.itemList[i] );
		}

		private var _currentTabData : TabData;

		private var _aItems : Array;

		private var _tabMap : Dictionary;

		private var _layout : Layout;
		private var _ctrls : TabsControls;
		
		public function get controls() : TabsControls {
			return _ctrls;
		}
	}
}
