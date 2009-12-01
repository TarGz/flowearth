package fr.digitas.flowearth.ui.tabs {
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.RightRenderer;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;		

	/**
	 * @author Pierre Lepers
	 */
	public class TabsControls extends Layout {

		
		public function TabsControls( tabs : Tabs ) {
			_tabs = tabs;
			renderer = new RightRenderer();
			margin = new Rectangle( 3 );
		}

		public function addControl( control : ITabsControl) : void {
			var _do : DisplayObject = control as DisplayObject;
			addChild( _do );
			_do.addEventListener( MouseEvent.CLICK , clickCtrl );
		}
		
		private function clickCtrl(event : MouseEvent) : void {
			var ctrl : ITabsControl = event.currentTarget as ITabsControl;
			ctrl.execute( _tabs );
		}

		private var _tabs : Tabs;

	}
}
