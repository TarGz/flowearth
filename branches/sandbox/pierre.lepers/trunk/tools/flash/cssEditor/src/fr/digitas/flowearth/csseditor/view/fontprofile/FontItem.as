package fr.digitas.flowearth.csseditor.view.fontprofile {
	import fr.digitas.flowearth.csseditor.view.picts.Picts;
	import fr.digitas.flowearth.font.FontInfo;
	import fr.digitas.flowearth.ui.tree.TreeItem;
	
	import flash.desktop.Clipboard;
	import flash.display.Bitmap;
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontItem extends TreeItem {

		public function FontItem() {
			super();
			_buildContextMenu( );
			bg.visible = false;
			
			addEventListener( MouseEvent.MOUSE_DOWN , onMouseDown );
			
			stylesView = new FontItemStyleView_FC();
			addChild( stylesView );
		}

		
		private function onMouseDown(event : MouseEvent) : void {
			var cboard : Clipboard = new Clipboard( );
//			cboard.setData( ClipboardFormats.TEXT_FORMAT,  );
			
//			NativeDragManager.doDrag( this, )
		}

		override public function dispose() : void {
			super.dispose( );
			
			contextMenu.removeAllItems( );
			_fontInfos = null;
		}

		public function init( fontInfos : FontInfo ) : void {
			_fontInfos = fontInfos;
			label.text = _fontInfos.fontFamily;
			
			icon.bitmapData = Picts.FONT_ITEM;
			
			stylesView.p.visible = fontInfos.style_normal;
			stylesView.b.visible = fontInfos.style_bold;
			stylesView.i.visible = fontInfos.style_italic;
			stylesView.t.visible = fontInfos.style_bolditalic;
		}

		override public function set width(value : Number) : void {
			bg.width = value;
			stylesView.x = value - 5;
		}

		

		private function _buildContextMenu() : void {
			contextMenu = new NativeMenu();
			
			var dItem : NativeMenuItem = new NativeMenuItem( "details" );
			dItem.addEventListener( Event.SELECT , onShowDetails , false, 0, true );
			contextMenu.addItem( dItem );
		}
		
		private function onShowDetails(event : Event) : void {
			FontDetailsManager.instance.openDetails( _fontInfos.font );
		}

		
		private var _fontInfos : FontInfo;
		
		private var stylesView : FontItemStyleView;
	}
}
