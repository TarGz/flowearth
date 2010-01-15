package fr.digitas.flowearth.csseditor.view.fontprofile {
	import flash.events.Event;	
	import flash.display.NativeMenuItem;	
	import flash.display.NativeMenu;	
	import flash.text.TextField;	
	import flash.text.TextFieldAutoSize;	

	import fr.digitas.flowearth.csseditor.view.picts.Picts;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.Font;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontItem extends Sprite {

		public var label : TextField;

		public var bg : Sprite;

		public function FontItem() {
			_build( );
			_buildContextMenu( );
			bg.visible = false;
		}
		

		public function init( font : Font ) : void {
			_font = font;
			label.text = font.fontName;
		
		}

		override public function set width(value : Number) : void {
			bg.width = value;
		}

		
		private function _build() : void {
			label.autoSize = TextFieldAutoSize.LEFT;
			icon = new Bitmap( Picts.FONT_ITEM );
			addChild( icon );
			icon.y = 2;
			icon.x = 45;
		}

		private function _buildContextMenu() : void {
			contextMenu = new NativeMenu();
			
			var dItem : NativeMenuItem = new NativeMenuItem( "details" );
			dItem.addEventListener( Event.SELECT , onShowDetails );
			contextMenu.addItem( dItem );
		}
		
		private function onShowDetails(event : Event) : void {
			FontDetailsManager.instance.openDetails( _font );
		}

		private var _font : Font;

		private var icon : Bitmap;
	}
}
