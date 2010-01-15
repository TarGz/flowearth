package fr.digitas.flowearth.csseditor.view.fontprofile {
	import flash.events.MouseEvent;	
	
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.csseditor.data.fonts.FontSource;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.csseditor.view.picts.Picts;
	import fr.digitas.flowearth.font.FontBuilder;
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopJustifyRenderer;
	import fr.digitas.flowearth.ui.toobar.ToolBar;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Shape;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontSourceItem extends FontSourceItem_FC implements ILayoutItem {

		public function FontSourceItem( ) {
			_build( );
		}

		public function init( source : FontSource ) : void {
			_source = source;
			label.text = source.file.name;
			icon.bitmapData = getIconForType( );
			bg.visible = false;
			_buildToolbar( );
			
			if( source.loaded )
				onSourceLoaded( );
			else
				source.addEventListener( FontEvent.FONT_LOADED , onSourceLoaded );
				
			source.profile.addEventListener( FontEvent.SELECTION_CHANGE , onSelectionChange );
			onSelectionChange( null );
			
			if( _source.configurable() )
				label.addEventListener( MouseEvent.DOUBLE_CLICK , onDoubleClick );
		}
		
		public function dispose() : void {
			_source.removeEventListener( FontEvent.FONT_LOADED , onSourceLoaded );
			_source.profile.removeEventListener( FontEvent.SELECTION_CHANGE , onSelectionChange );
			_source = null;
		}

		
		
		public function collapse( flag : Boolean ) : void {
			if( _collapsed == flag ) return;
			_collapsed = flag;
			collapseButton.collapse( flag );
			treeShape.visible = _fontList.visible = ! flag;
			dispatchEvent( new Event( Event.RESIZE ) );
		}
		
		public function getWidth() : Number {
			return 10;
		}
		
		public function getHeight() : Number {
			return _collapsed ? 20: height;
		}
		

		
		private function _buildToolbar() : void {
			_toolBar = new ToolBar( );
			addChild( _toolBar );
			

			_toolBar.addButton( "remove" , null , Picts.REMOVE );
			if( _source.configurable( ) ) {
				_toolBar.addButton( "configure" , null , Picts.FONT_SETTING );
				_toolBar.addButton( "rebuild" , null , Picts.REFRESH );
			}
			
			_toolBar.width = 200;
			_toolBar.addEventListener( Event.SELECT , onToolbarBtn );
		}

		private function onToolbarBtn(event : TextEvent) : void {
			switch ( event.text ) {
				case "remove" :
					
					break;
				case "rebuild" :
					_source.getConfig().build();
					break;
				case "configure" :
					openFontConfig();
					break;
			}
		}
		
		private function openFontConfig() : void {
			
			if( _currentFontBuilder ) {
				_currentFontBuilder.stage.nativeWindow.orderToFront();
				return;
			}
			
			var W : int = 427;
			
			var nwio : NativeWindowInitOptions = new NativeWindowInitOptions( );
			var detailWindow : NativeWindow = new NativeWindow( nwio );
			detailWindow.activate();
			detailWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			detailWindow.stage.align = StageAlign.TOP_LEFT;
			detailWindow.width = W;
			detailWindow.minSize = new Point( W, 100 );
			detailWindow.maxSize = new Point( W, 3000 );
			detailWindow.addEventListener( Event.CLOSE , onConfigWindowClosed );
			
			_currentFontBuilder = new FontBuilder( _source.getConfig() );
			detailWindow.stage.addChild( _currentFontBuilder );
			
		}
		

		private function onConfigWindowClosed(event : Event) : void {
			_currentFontBuilder.dispose( );
			_currentFontBuilder = null;
			_source.getConfig().build();
		}

		private var _currentFontBuilder : FontBuilder;

		
		private function _build() : void {
			label.autoSize = TextFieldAutoSize.LEFT;
			label.backgroundColor = 0xbebebe;
			label.background = false;
			label.doubleClickEnabled = true;
			
			label.addEventListener( MouseEvent.CLICK , onClick );
			
			addChild( icon = new Bitmap( ) );
			icon.y = 2;
			icon.x = 20;
			
			collapseButton.visible = false;
			
			treeShape = new Shape();
			addChildAt( treeShape , 0 );
			treeShape.x = 25;
			treeShape.visible = false;

			_fontList = new Layout( );
			_fontList.visible = false;
			_fontList.renderer = new TopJustifyRenderer( );
			treeShape.y = _fontList.y = bg.height;
			
			addChild( _fontList );
			
			
			collapseButton.addEventListener( MouseEvent.CLICK , onSwitchCollapse );
		}
		
		private function onDoubleClick(event : MouseEvent) : void {
			openFontConfig();
		}

		private function onClick(event : MouseEvent) : void {
			_source.profile.selectedSource = _source;
		}

		private function onSwitchCollapse(event : MouseEvent) : void {
			collapse( ! _collapsed );
		}

		private function onSourceLoaded(event : FontEvent = null ) : void {
			var fontItem : FontItem;
			var iter : IIterator = _source.fonts;
			var item : Class;
			while( iter.hasNext( ) ) {
				item = iter.next( ) as Class;
				fontItem = new FontItem_FC( );
				fontItem.init( new item( ) );
				_fontList.addChild( fontItem );
			}
			_fontList.update( );
			updateTree();
			dispatchEvent( new Event( Event.RESIZE ) );
		}
		

		override public function set width(value : Number) : void {
			bg.width = value;
			_fontList.width = value;
			_toolBar.x = value - _toolBar.width -4;
		}

		
		private function getIconForType() : BitmapData {
			if( _source.configurable( ) )
				return Picts.SWF_CONF_FONT_FILE;
			else
				return Picts.SWF_FONT_FILE;
		}
		
		
		private function updateTree() : void {
			
			
			treeShape.graphics.clear( );
			
			if( _fontList.numChildren == 0 ) {
				collapseButton.visible = false;
				return;
			}
			collapseButton.visible = true;
			treeShape.graphics.lineStyle( 1 );
			treeShape.graphics.lineBitmapStyle(motif);
			
			var sub : DisplayObject;
			for (var i : int = 0; i < _fontList.numChildren ; i++) {
				sub = _fontList.getChildAt( i );
				treeShape.graphics.moveTo(5, sub.y + 8 );
				treeShape.graphics.lineTo(15, sub.y + 8 );
			}
			
			treeShape.graphics.moveTo( 5 , -10 );
			treeShape.graphics.lineTo( 5 , sub.y + 8 );
		}
		
		
		private function onSelectionChange(event : FontEvent) : void {
			label.background = _source.selected();
		}
		

		private var treeShape : Shape;
		
		private var _source : FontSource;

		private var icon : Bitmap;

		private var _fontList : Layout;

		private var _toolBar : ToolBar;
		
		private var _collapsed : Boolean = true;
		
		private static const motif : BitmapData = _buildMotif();
		private static function _buildMotif() : BitmapData {
			var bmp : BitmapData = new BitmapData( 2, 2, true, 0 );
			bmp.setPixel32(0, 0, 0x80000000);
			bmp.setPixel32(1, 1, 0x80000000);
			return bmp;
		}
		
		
		
	}
}
