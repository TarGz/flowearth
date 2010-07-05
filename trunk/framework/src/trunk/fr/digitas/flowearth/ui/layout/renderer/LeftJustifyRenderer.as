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
	
		public override function render( child : ILayoutItem ) : void {
			var _do : DisplayObject = child.getDisplay();
			_offset += _margin.left;
			_do.x = _offset;
			_do.y = _margin.top + _padding.top;
			_offset += _margin.width + child.getWidth();
			_do.height = _height;
		}
	}
}