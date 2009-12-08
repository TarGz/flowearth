package fr.digitas.flowearth.ui.canvas {
	import flash.geom.Rectangle;	
	import flash.display.DisplayObject;	
	
	import fr.digitas.flowearth.ui.layout.Layout;	
	import fr.digitas.flowearth.ui.layout.LayoutAlign;	
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.Sprite;	

	/**
	 * @author Pierre Lepers
	 */
	public class Canvas extends Sprite implements ILayoutItem {


		public function Canvas( align : String = LayoutAlign.TOP ) {
			_align = align;
			
			_contentLayout = new Layout();
			addChild( _contentLayout );
			_contentLayout.align = align;
			padding = new Rectangle();
			super( );
		}
		
		public function addContent( content : DisplayObject, percented : Boolean = false ) : void {
			_contentLayout.addChild( content as DisplayObject );
			if( percented ) _percentedContent = content;
			_contentLayout.update();
		}


		override public function set width(value : Number) : void {
			_width = value;
			updateContent();
		}
		

		override public function set height(value : Number) : void {
			_height = value;
			updateContent( );
		}
		
		private function updateContent() : void {
			var i : int;
			var tot : Number = 0;
			var rest : Number;
			if( _align == LayoutAlign.TOP ) {
				for ( i = 0; i < _contentLayout.numChildren ; i++ ) {
					_contentLayout.getChildAt( i ).width = _width - _contentLayout.padding.width - _contentLayout.padding.left;
					if( _contentLayout.getChildAt( i ) != _percentedContent )
						tot += _contentLayout.getChildAt( i ).height;
				
				}
				rest = _height - tot - _contentLayout.padding.top - _contentLayout.padding.height;
				if( _percentedContent ) _percentedContent.height = rest;
			} else {
				for ( i = 0; i < _contentLayout.numChildren ; i++ ) {
					_contentLayout.getChildAt( i ).height = _height - _contentLayout.padding.top - _contentLayout.padding.height;
					if( _contentLayout.getChildAt( i ) != _percentedContent )
						tot += _contentLayout.getChildAt( i ).width;
					
				}
				rest = _width - tot - _contentLayout.padding.width - _contentLayout.padding.left;
				if( _percentedContent ) _percentedContent.width = rest;
			}
			
		}

		
		override public function get width( ) : Number {
			return _width;
		}

		override public function get height( ) : Number {
			return _height;
		}

		
		public function getWidth() : Number {
			return _width;
		}

		public function getHeight() : Number {
			return _height;
		}
		

		
		
		protected var _height : Number = 10;
		protected var _width : Number = 10;

		protected var _contentLayout : Layout;
		
		protected var _percentedContent : DisplayObject;

		private var _align : String;
		
		public function get percentedContent() : DisplayObject {
			return _percentedContent;
		}
		
		public function set percentedContent(percentedContent : DisplayObject) : void {
			_percentedContent = percentedContent;
		}
		
		public function set padding(padding : Rectangle) : void {
			_contentLayout.padding = padding;
		}
	}
}
