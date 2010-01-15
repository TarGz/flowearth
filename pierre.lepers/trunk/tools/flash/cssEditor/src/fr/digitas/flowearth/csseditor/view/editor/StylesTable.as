package fr.digitas.flowearth.csseditor.view.editor {
	import flash.utils.Dictionary;	
	
	import fr.digitas.flowearth.csseditor.event.StyleEvent;	
	import fr.digitas.flowearth.csseditor.data.CSSData;	
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.CSS;
	import fr.digitas.flowearth.csseditor.data.StyleData;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopJustifyRenderer;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;		

	/**
	 * @author Pierre Lepers
	 */
	public class StylesTable extends Sprite {
		
		public function StylesTable() {
			_viewMap = new Dictionary();
			_buildView( );
		}

		public function init(css : CSS) : void {
			_cssData = css.datas;
			var iter : IIterator = css.datas.getStyles();
			var item : StyleData;
			var renderer : StyleItemRenderer;
			while( iter.hasNext() ) {
				item = iter.next() as StyleData;
				renderer = new StyleItemRenderer();
				renderer.init( item );
				_layout.addChild( renderer );
				_viewMap[ item ] = renderer;
			}
			_layout.update();
			
			_cssData.addEventListener( StyleEvent.ADDED , onStyleAdded );
			_cssData.addEventListener( StyleEvent.REMOVED , onStyleRemoved );
		}

		public function dispose() : void {
			var renderer : StyleItemRenderer;
			while( _layout.numChildren > 0 ) {
				renderer = _layout.removeChildAt( 0 ) as StyleItemRenderer;
				renderer.dispose();
			}
			removeChild( _layout );
			_layout = null;
			_cssData.removeEventListener( StyleEvent.ADDED , onStyleAdded );
			_cssData.removeEventListener( StyleEvent.REMOVED , onStyleRemoved );
			_cssData = null;
			_viewMap = null;
		}
		
		
		override public function set width(value : Number) : void {
			_layout.width = value;
			_layout.update();
		}

		override public function set height(value : Number) : void {
			_layout.height = value;
			_layout.update();
		}
		
		private function _buildView() : void {
			_layout = new Layout( );
			_layout.renderer = new TopJustifyRenderer();
			addChild( _layout );
		}
		
		
		private function onStyleAdded(event : StyleEvent) : void {
			var sData : StyleData = event.style;
			var renderer : StyleItemRenderer = new StyleItemRenderer();
			renderer.init( sData );
			_viewMap[ sData ] = renderer;
			_layout.addChild( renderer );
			_layout.update();
			
			renderer.render = ( renderer.getBounds( renderer.parent ).intersects( _prevRenderBounds ) );
		}

		private function onStyleRemoved(event : StyleEvent) : void {
			
			var renderer : StyleItemRenderer = _viewMap[ event.style ];
			if( ! renderer ) return;
			_layout.removeChild( renderer );
			delete _viewMap[ event.style ];
			_layout.update();
		}

		private var _layout : Layout;
		
		public function renderZone(bounds : Rectangle) : void {
			if( bounds.equals( _prevRenderBounds ) ) return; 
			var item : StyleItemRenderer;
			for ( var i : int = 0; i < _layout.numChildren ; i++) {
				item = _layout.getChildAt( i ) as StyleItemRenderer;
				item.render = ( item.getBounds( item.parent ).intersects( bounds ) );
			}
			_prevRenderBounds = bounds;
		}

		private var _prevRenderBounds : Rectangle = new Rectangle();
		
		private var _cssData : CSSData;
		
		private var _viewMap : Dictionary;
	}
}
