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
	
		public override function render( child : ILayoutItem ) : void {
			var _do : DisplayObject = child.getDisplay();
			_offset += _margin.top;
			_do.x = _margin.left + _padding.left;
			_do.y = _offset;
			_offset += _margin.height + child.getHeight();;
			_do.width = _width;
		}
	}
}
