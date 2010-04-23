package fr.digitas.tutorial.layout {
	import fr.digitas.flowearth.ui.layout.renderer.HTidyBlockRenderer;	
	
	import fl.controls.ComboBox;
	import fl.data.DataProvider;
	
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.HBlockRenderer;
	import fr.digitas.flowearth.ui.layout.renderer.LeftRenderer;
	import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;
	import fr.digitas.flowearth.ui.layout.renderer.VBlockRenderer;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class LayoutExample extends Layout {

		
		public function LayoutExample() {
			_buildLayout( );
			_buildRenderCb();
		}
		
		
		protected function _buildLayout() : void {
			
			renderer = new LeftRenderer();
			
			addEventListener( Event.RESIZE, onLayoutUpdate );
			
			bi_internal::addChild( _borders = new Shape );
			bi_internal::addChild( _sborders = new Shape );
			bi_internal::addChild( _resizer = new ResizeGuizmo_FC );
			
			
			
			_resizer.addEventListener( Event.RESIZE, onLayoutSizer );
		}
		
		private function onLayoutSizer(event : Event) : void {
			width = _resizer.x;
			height = _resizer.y;
			_sborders.graphics.clear();
			_sborders.graphics.lineStyle( 1, 0x800000 );
			_sborders.graphics.drawRect( 0 , 0 , _resizer.x , _resizer.y );
			
			
		}

		
		private function onLayoutUpdate(event : Event ) : void {
			
			_borders.graphics.clear();
			_borders.graphics.lineStyle( 1, 0x333333 );
			_borders.graphics.drawRect( 0 , 0 , getWidth() , getHeight() );
			
			_renderCb.y = getHeight() + 1;
			_renderCb.x = getWidth() - _renderCb.width;
			
			_resizer.x = width;
			_resizer.y = height;
		}
		

		private function _buildRenderCb() : void {
			_renderCb = new ComboBox( );
			_renderCb.dataProvider = new DataProvider( [ { label : "LeftRenderer" }, { label : "TopRenderer" }, { label : "VBlockRenderer" }, { label : "HBlockRenderer" }, { label : "HTidyBlockRenderer" } ] );
			_renderCb.addEventListener( Event.CHANGE , onRendererChange );
			bi_internal::addChild( _renderCb );
			
			_rendererMap = new Dictionary( );
			_rendererMap[ "TopRenderer" ] = TopRenderer;
			_rendererMap[ "LeftRenderer" ] = LeftRenderer;
			_rendererMap[ "VBlockRenderer" ] = VBlockRenderer;
			_rendererMap[ "HBlockRenderer" ] = HBlockRenderer;
			_rendererMap[ "HTidyBlockRenderer" ] = HTidyBlockRenderer;
		}

		private function onRendererChange(event : Event) : void {
			renderer = new (_rendererMap[ _renderCb.selectedLabel ])();
		}

		private var _borders : Shape;
		private var _sborders : Shape;
		
		private var _renderCb : ComboBox;

		private var _rendererMap : Dictionary;
		
		private var _resizer : ResizeGuizmo;
	}
}
