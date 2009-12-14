package fr.digitas.flowearth.csseditor.view.fontprofile {
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

		public function FontItem() {
			_build();
		}

		public function init( font : Font ) : void {
			label.text = font.fontName;
		}

		private function _build() : void {
			label.autoSize = TextFieldAutoSize.LEFT;
			icon = new Bitmap( Picts.FONT_ITEM );
			addChild( icon );
			icon.y = 2;
			icon.x = 25;
		}
		
		private var icon : Bitmap;
	}
}
