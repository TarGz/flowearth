package fr.digitas.tutorial.layout {
	import fr.digitas.flowearth.ui.layout.renderer.TopRenderer;
	import fr.digitas.tutorial.layout.LayoutExample1;
	
	import flash.geom.Rectangle;	

	/**
	 * @author Pierre Lepers
	 */
	public class LayoutExample2 extends LayoutExample1 {
		public function LayoutExample2() {
			super( );
		}
		
		override protected function _buildItems() : void {
			
			for (var i : int = 0; i < 3; i++) {
				addChild( new LayoutExample1() );
			}
			
		}

		override protected function _buildLayout() : void {
			super._buildLayout();
			renderer = new TopRenderer( );
			margin = new Rectangle( 5, 5, 5, 20 );
			
		}
	}
}
