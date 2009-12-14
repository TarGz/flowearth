package fr.digitas.flowearth.csseditor.view.fontprofile {
	import flash.events.Event;	
	
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.fonts.FontSource;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.csseditor.view.picts.Picts;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopJustifyRenderer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontSourceItem extends Sprite {
		
		public var label : TextField;

		public var bg : Sprite;
		
		public function FontSourceItem( ) {
			_build( );
		}

		public function init( source : FontSource ) : void {
			_source = source;
			label.text = source.file.name;
			icon.bitmapData = getIconForType( );
			
			if( source.loaded )
				onSourceLoaded();
			else
				source.addEventListener( FontEvent.FONT_LOADED , onSourceLoaded );
		}
		

		
		
		private function _build() : void {
			label.autoSize = TextFieldAutoSize.LEFT;
			addChild( icon = new Bitmap() );
			icon.y = 2;
			icon.x = 5;
			
			_fontList = new Layout( );
			_fontList.renderer = new TopJustifyRenderer( );
			_fontList.y = bg.height;
			addChild( _fontList );
		}

		private function onSourceLoaded(event : FontEvent = null ) : void {
			var fontItem : FontItem;
			var iter : IIterator = _source.fonts;
			var item : Class;
			while( iter.hasNext() ) {
				item = iter.next() as Class;
				fontItem = new FontItem_FC( );
				fontItem.init( new item() );
				_fontList.addChild( fontItem );
			}
			_fontList.update();
			dispatchEvent( new Event( Event.RESIZE ) );
		}

		override public function set width(value : Number) : void {
			bg.width = value;
			_fontList.width = value;
		}
		
		
		private function getIconForType() : BitmapData {
			return Picts.SWF_FONT_FILE;
		}

		private var _source : FontSource;
		
		private var icon : Bitmap;
		
		private var _fontList : Layout;

	}
}
