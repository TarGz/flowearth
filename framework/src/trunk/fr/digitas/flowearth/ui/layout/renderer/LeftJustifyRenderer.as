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
			_lineStock = [];
			_rwidth = w;
		}

		public override function render( child : ILayoutItem ) : void {
			var _do : DisplayObject = child.getDisplay();
			_offset += _margin.left;
			_do.x = _offset;
			_do.y = _margin.top + _padding.top;
			_offset += _margin.width + child.getWidth();
			
			_lineStock.push( _do );
		}
		
		override public function complete() : void {
			
			var space : Number = _rwidth - _offset - _padding.width;
			var len : int = _lineStock.length;
			var decay : Number = space/(len-1);
			var doDecay : Number = decay;
			
			for (var i : int = 1; i < len; i++) {
				_lineStock[i].x += doDecay;
				doDecay += decay;
			}
			
			_lineStock = null;
			
			super.complete();
			
		}
		
		private var _lineStock : Array;
		
	}
}
