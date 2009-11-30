package fr.digitas.flowearth.csseditor.view.editor {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.StyleData;
	import fr.digitas.flowearth.csseditor.data.StyleProperty;
	import fr.digitas.flowearth.csseditor.event.PropertyEvent;
	import fr.digitas.flowearth.csseditor.view.console.Console;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopJustifyRenderer;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class PropertyList extends Sprite {
		
		public function PropertyList() {
			_buildLayout( );
			
		}
		
		
		
		public function init(sData : StyleData) : void {
			_sdata = sData;
			
			_sdata.addEventListener( PropertyEvent.ADDED , onStyleAdded );
			_sdata.addEventListener( PropertyEvent.REMOVED , onStyleRemoved );
			updateList( );
		}
		
		public function dispose() : void {
			_sdata.removeEventListener( PropertyEvent.ADDED , onStyleAdded );
			_sdata.removeEventListener( PropertyEvent.REMOVED , onStyleRemoved );
			_sdata = null;
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
			updateLayout();
		}

		private function onStyleRemoved(event : PropertyEvent) : void {
			removePropItem( event.prop );
			updateLayout();
		}

		
		
		private function updateList( ) : void {
			_rendererMap = new Dictionary();
			var prop : StyleProperty;
			var iter : IIterator = _sdata.getProps();
			while( prop = iter.next() as StyleProperty ) {
				addPropItem( prop );
			}
		}

		private function addPropItem( prop : StyleProperty ) : void {
			var renderer : PropertyItemRenderer = _rendererMap[ prop ] = new PropertyItemRenderer_FC( );
			renderer.init( prop );
			_layout.addChild( renderer );
		}

		private function removePropItem( prop : StyleProperty ) : void {
			var renderer : PropertyItemRenderer = _rendererMap[ prop ];
			_layout.removeChild( renderer );
			renderer.dispose();
			delete _rendererMap[ prop ];
		}

		
		
		
		override public function set width(value : Number) : void {
			_layout.width = value;
		}
		
		private function _buildLayout() : void {
			_layout = new Layout( );
			_layout.renderer = new TopJustifyRenderer();
			addChild( _layout );
		}
		
		private function updateLayout() : void {
			_layout.update();
			if (_quickAdd )
				_layout.setChildIndex( _quickAdd , _layout.numChildren - 1 );
			dispatchEvent( new Event( Event.RESIZE , true ) );
		}

		
		
		private var _layout : Layout;

		private var _rendererMap : Dictionary;
		
		private var _sdata : StyleData;
		
		private var _quickAdd : QuickPropertyAdd;
		
	}
}
