package fr.digitas.flowearth.ui.tabs {
	import flash.events.MouseEvent;	
	import flash.display.MovieClip;
	import flash.display.Sprite;	

	/**
	 * @author Pierre Lepers
	 */
	public class CloseControl extends Sprite implements ITabsControl {


		public var overMc : MovieClip;

		
		public function CloseControl() {
			overMc.visible = false;
			addEventListener( MouseEvent.ROLL_OVER , over );
			addEventListener( MouseEvent.ROLL_OUT , out );
		}
		
		private function over(event : MouseEvent) : void {
			overMc.visible = true;
		}

		private function out(event : MouseEvent) : void {
			overMc.visible = false;
		}

		public function execute(tabs : Tabs) : void {
			tabs.removeItem( tabs.currentItem );
		}
	}
}
