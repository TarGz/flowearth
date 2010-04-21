package fr.digitas.tutorial.layout {
	import fr.digitas.flowearth.ui.layout.IChildRenderer;	
	import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;	
	
	import flash.utils.Dictionary;	
	
	import fl.data.DataProvider;	
	import fl.controls.ComboBox;	
	
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.LeftRenderer;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import fr.digitas.flowearth.bi_internal;		

	/**
	 * @author Pierre Lepers
	 */
	public class LayoutExample1 extends Layout {

		
		public function LayoutExample1() {
			_buildLayout( );
			_buildRenderCb();
			_buildItems( );
		}
		
		protected function _buildItems() : void {
			
			for (var i : int = 0; i < 3; i++) {
				addChild( new ResizableLayoutItem_FC );
			}
			
		}

		protected function _buildLayout() : void {
			
			
			renderer = new LeftRenderer();
			
			margin = new Rectangle( 5, 5, 5, 5 );
			padding = new Rectangle( 10, 10, 10, 10 );
			
			addEventListener( Event.RESIZE, onLayoutUpdate );
			
			bi_internal::addChild( _borders = new Shape );
		}
		

		private function onLayoutUpdate(event : Event ) : void {
			_borders.graphics.clear();
			_borders.graphics.lineStyle( 1, 0x333333 );
			_borders.graphics.drawRect( 0 , 0 , getWidth( ) , getHeight() );
			
			_renderCb.y = getHeight() + 1;
			_renderCb.x = getWidth() - _renderCb.width;
		}
		
		private function _buildRenderCb() : void {
			_renderCb = new ComboBox( );
			_renderCb.dataProvider = new DataProvider( [ { label : "TopRenderer" }, { label : "LeftRenderer" } ] );
			_renderCb.addEventListener( Event.CHANGE , onRendererChange );
			bi_internal::addChild( _renderCb );
			
			_rendererMap = new Dictionary( );
			_rendererMap[ "TopRenderer" ] = TopRenderer;
			_rendererMap[ "LeftRenderer" ] = LeftRenderer;
		}

		private function onRendererChange(event : Event) : void {
			renderer = new (_rendererMap[ _renderCb.selectedLabel ])();
		}

		private var _borders : Shape;
		
		private var _renderCb : ComboBox;

		private var _rendererMap : Dictionary;
		
	}
}
