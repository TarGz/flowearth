package fr.digitas.flowearth.ui.layout.renderer {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class LeftJustifyRenderer extends ChildRenderer {
	
		public override function init( padding : Rectangle, margin : Rectangle, w : Number, h : Number ) : void {
			super.init(padding, margin, w, h );
			_offset = padding.left;
		}
	
		public override function render( child : DisplayObject ) : void {
			var w : Number = ( child is ILayoutItem ) ? ( child as ILayoutItem).getWidth() : child.width;
			_offset += _margin.left;
			child.x = _offset;
			child.y = _margin.top + _padding.top;
			_offset += _margin.width + w;
			child.height = _height;
		}
	}
}
