package fr.digitas.flowearth.font.view {
	import fr.digitas.flowearth.font.FontConfig;
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontViewContainer extends Sprite implements ILayoutItem {

		public function FontViewContainer(fontConfig : FontConfig ) {
			_fontConfig = fontConfig;
			header = new FontViewHeader( fontConfig);
			view = new FontView( fontConfig );
			
			addChild( header );
			view.y = header.height;
			addChild( view );
			
			header.addEventListener( MouseEvent.CLICK , clickHeader );
			collapse( false );
		}
		
		private function clickHeader(event : MouseEvent) : void {
			collapse( ! _collapse );
		}

		public function collapse( flag : Boolean ) : void {
			_collapse = flag;
			view.visible = !flag;
			header.arrow.rotation = flag ? 0 : 90;
			resize( );
		}
		
		private var _fontConfig : FontConfig;

		private var _collapse : Boolean = false;

		private function resize() : void {
			dispatchEvent( new Event( Event.RESIZE ) );
		}

		
		
		
		private var header : FontViewHeader;
		private var view : FontView;
		
		public function getWidth() : Number {
			return 10;
		}
		
		public function getHeight() : Number {
			return _collapse ? header.height : height;
		}
		
		public function getDisplay() : DisplayObject {
			return this;
		}
		
		public function get fontConfig() : FontConfig {
			return _fontConfig;
		}
		
		public function dispose() : void {
			view.dispose();
		}
	}
}
