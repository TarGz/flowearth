package fr.digitas.flowearth.csseditor.view.editor {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.StyleData;
	import fr.digitas.flowearth.csseditor.data.StyleProperty;
	import fr.digitas.flowearth.csseditor.event.PropertyEvent;
	import fr.digitas.flowearth.csseditor.managers.TabManager;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopJustifyRenderer;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.utils.Dictionary;		

	/**
	 * @author Pierre Lepers
	 */
	public class PropertyList extends Sprite {
		
		public function PropertyList() {
			_buildLayout( );
			addEventListener( FocusEvent.FOCUS_IN , focusIn );
			addEventListener( FocusEvent.FOCUS_OUT , focusOut );
			focusOut(null);
		}
		
		private function focusOut(event : FocusEvent) : void {
			tabChildren = false;
		}

		private function focusIn(event : FocusEvent) : void {
			tabChildren = true;
		}

		
		
		public function init(sData : StyleData) : void {
			_sdata = sData;
			
			_sdata.addEventListener( PropertyEvent.ADDED , onStyleAdded );
			_sdata.addEventListener( PropertyEvent.REMOVED , onStyleRemoved );
			updateHeight();
		}
		
		public function dispose() : void {
			_sdata.removeEventListener( PropertyEvent.ADDED , onStyleAdded );
			_sdata.removeEventListener( PropertyEvent.REMOVED , onStyleRemoved );
			_sdata = null;
			cacheAsBitmap = false;
			var item : PropertyItemRenderer;
			while( _layout.numChildren > 0 ) {
				item = _layout.removeChildAt( 0 ) as PropertyItemRenderer;
				item.dispose();
			}
		}
		
		internal function set quickAddItem( flag : Boolean ) : void {
			
			if( ! flag ) {
				if( _quickAdd ) {
					Console.log( " remove QuickPropertyAdd " );
					_layout.removeChild( _quickAdd );
					_quickAdd.dispose();
					_quickAdd = null;
					updateLayout();
				}
			} else {
				if( ! _quickAdd ) {
					Console.log( " add QuickPropertyAdd " );
					_quickAdd = new QuickPropertyAdd( _sdata );
					_layout.addChild( _quickAdd );
					updateLayout();
				}
			}
		}

		private function onStyleAdded(event : PropertyEvent) : void {
			addPropItem( event.prop );
			updateLayout( );
		}
		
		

		private function onStyleRemoved(event : PropertyEvent) : void {
			removePropItem( event.prop );
			updateLayout();
		}

		
		
		private function _lazyBuild( ) : void {
			if( _builded ) return;
			_rendererMap = new Dictionary();
			var prop : StyleProperty;
			var iter : IIterator = _sdata.getProps();
			var renderer : PropertyItemRenderer;
			
			
			while( prop = iter.next() as StyleProperty ) {
				renderer = _rendererMap[ prop ] = new PropertyItemRenderer_FC( );
				renderer.init( prop );
				_layout.addChild( renderer );
			}
			quickAddItem = true;
			
			updateLayout();
			_builded = true;
		}

		private function addPropItem( prop : StyleProperty ) : void {
			var renderer : PropertyItemRenderer = _rendererMap[ prop ] = new PropertyItemRenderer_FC( );
			renderer.init( prop );
			_layout.addChild( renderer );
			updateHeight();
		}

		private function removePropItem( prop : StyleProperty ) : void {
			var renderer : PropertyItemRenderer = _rendererMap[ prop ];
			_layout.removeChild( renderer );
			renderer.dispose();
			delete _rendererMap[ prop ];
			updateHeight();
		}

		
		override public function get height() : Number {
			return bg.height;
		}
		

		override public function set width(value : Number) : void {
			_layout.width = value;
			bg.width = value;
		}
		
		private function _buildLayout() : void {
			addChild( bg = new Shape() );
			bg.graphics.beginFill( 0xFFFFFF );
			bg.graphics.drawRect(0, 0, 100, 100 );

			_layout = new Layout( );
			_layout.renderer = new TopJustifyRenderer();
			addChild( _layout );
			
		}
		
		
		private function updateHeight( ) : void {
			if( bg.height == (_sdata.length+1) * 22 ) return;
			bg.height = (_sdata.length + 1 )* 22;
			dispatchEvent( new Event( Event.RESIZE , true ) );
		}
		
		private function updateLayout() : void {
			if (_quickAdd )
				_layout.setChildIndex( _quickAdd , _layout.numChildren - 1 );
			
			TabManager.reset();
			for (var i : int = 0; i < _layout.numChildren; i++) {
				( _layout.getChildAt( i ) as PropertyItemRenderer ).setTabIndex();
			}
			
			_layout.update();
			dispatchEvent( new Event( Event.RESIZE , true ) );
		}

		private var bg : Shape;

		private var _layout : Layout;

		private var _rendererMap : Dictionary;
		
		private var _sdata : StyleData;
		
		private var _quickAdd : QuickPropertyAdd;
		
		private var _builded : Boolean = false;
		
		private var _render : Boolean = false;
		
		public function get render() : Boolean {
			return _render;
		}
		
		public function set render(render : Boolean) : void {
			if( render == _render ) return;
			_render = render;
			_lazyBuild();
			cacheAsBitmap = ! render;
		}
	}
}
