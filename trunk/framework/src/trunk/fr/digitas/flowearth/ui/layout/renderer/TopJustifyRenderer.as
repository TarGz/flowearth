package fr.digitas.flowearth.ui.layout.renderer {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;	
	
	/**
	 * @author Pierre Lepers
	 */
	public class TopJustifyRenderer extends ChildRenderer {
	
		public override function init( padding : Rectangle, margin : Rectangle, w : Number, h : Number ) : void {
			super.init( padding, margin, w, h );
			_offset = padding.top;
		}
	
		public override function render( child : DisplayObject ) : void {
			var h : Number = ( child is ILayoutItem ) ? ( child as ILayoutItem).getHeight() : child.height;
			_offset += _margin.top;
			child.x = _margin.left + _padding.left;
			child.y = _offset;
			_offset += _margin.height + h;
			child.width = _width;
		}
	}
}
