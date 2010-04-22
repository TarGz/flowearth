package fr.digitas.flowearth.ui.tree {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	import fr.digitas.flowearth.ui.layout.Layout;
	import fr.digitas.flowearth.ui.layout.renderer.TopJustifyRenderer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;	

	/**
	 * @author Pierre Lepers
	 */
	public class TreeItem extends TreeItem_FC implements ILayoutItem {
		
		public function TreeItem() {
			super();
			_build( );
			bg.visible = false;
		}
		
		public function dispose() : void {
			var sub : TreeItem;
			while( _subLayout.numChildren > 0 ){
				sub = _subLayout.getChildAt( 0 ) as TreeItem;
				sub.dispose();
				_subLayout.removeChildAt( 0 );
			}
			
		}

		
		
		public function collapse( flag : Boolean ) : void {
			if( _collapsed == flag ) return;
			_collapsed = flag;
			collapseButton.collapse( flag );
			treeShape.visible = _subLayout.visible = ! flag;
			dispatchEvent( new Event( Event.RESIZE ) );
		}
		
		public function getWidth() : Number {
			return 10;
		}
		
		public function getHeight() : Number {
			return _collapsed ? 20: height;
		}
		
		public function getDisplay() : DisplayObject {
			return this;
		}

		
		
		override public function set width(value : Number) : void {
			bg.width = value;
			_subLayout.width = value - _subLayout.x;
		}
		
		public function addSubitem( sub : TreeItem ) : void {
			_subLayout.addChild( sub );
			updateTree();
		}

		public function removeSubitem( sub : TreeItem ) : void {
			_subLayout.removeChild( sub );
			updateTree();
		}

		protected function updateTree() : void {
			
			
			treeShape.graphics.clear( );
			
			if( _subLayout.numChildren == 0 ) {
				collapseButton.visible = false;
				return;
			}
			collapseButton.visible = true;
			treeShape.graphics.lineStyle( 1 );
			treeShape.graphics.lineBitmapStyle(motif);
			
			var sub : DisplayObject;
			for (var i : int = 0; i < _subLayout.numChildren ; i++) {
				sub = _subLayout.getChildAt( i );
				treeShape.graphics.moveTo(5, sub.y + 8 );
				treeShape.graphics.lineTo(15, sub.y + 8 );
			}
			
			treeShape.graphics.moveTo( 5 , -10 );
			treeShape.graphics.lineTo( 5 , sub.y + 8 );
		}
		
		protected function _build() : void {
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

			_subLayout = new Layout( );
			_subLayout.visible = false;
			_subLayout.renderer = new TopJustifyRenderer( );
			_subLayout.x = 25;
			treeShape.y = _subLayout.y = bg.height;
			
			addChild( _subLayout );
			
			
			collapseButton.addEventListener( MouseEvent.CLICK , onSwitchCollapse );
			
		}
		
		protected function onClick(event : MouseEvent) : void {
			
		}
		
		protected function onSwitchCollapse(event : MouseEvent) : void {
			collapse( ! _collapsed );
		}
		
		
		
		protected var treeShape : Shape;
		
		

		protected var icon : Bitmap;


		protected var _collapsed : Boolean = true;
		
		protected var _subLayout : Layout;
		
		private static const motif : BitmapData = _buildMotif();
		private static function _buildMotif() : BitmapData {
			var bmp : BitmapData = new BitmapData( 2, 2, true, 0 );
			bmp.setPixel32(0, 0, 0x80000000);
			bmp.setPixel32(1, 1, 0x80000000);
			return bmp;
		}
		
		public function setIcon( ico : BitmapData ) : void {
			icon.bitmapData = ico;
		}
	}
}
