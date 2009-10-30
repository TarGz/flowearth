////////////////////////////////////////////////////////////////////////////////
//
//  DIGITAS FRANCE / VIVAKI COMMUNICATIONS
//  Copyright 2008-2009 Digitas France
//  All Rights Reserved.
//
//  NOTICE: Digitas permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


package fr.digitas.flowearth.ui.layout.renderer {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	import fr.digitas.flowearth.ui.layout.renderer.ChildRenderer;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;	

	/**
	 * @author Pierre Lepers
	 */
	public class HBlockRenderer extends BlockRenderer {

		
		
		public function HBlockRenderer () {
			
			
		}

		override public function init (padding : Rectangle, margin : Rectangle, w : Number, h : Number) : void {
			super.init( padding, margin, w, h );
			_baseLine 	= _padding.top + _margin.top;
			_offset = padding.left;
		}

		override public function render (child : DisplayObject) : void {
			var w : Number;
			var h : Number;
			
			if( child is ILayoutItem ) {
				w = ( child as ILayoutItem).getWidth();
				h = ( child as ILayoutItem).getHeight();
			} else {
				w = child.width;
				h = child.height;
			}
			
			if( _offset + w + _margin.right > _mawWidth ) lineBreak();
			_baseOffset = Math.max( _baseOffset , h );
			
			_offset += _margin.left;
			child.x = _offset;
			child.y = _baseLine;
			_offset += _margin.width + w;
		}
		
		private function lineBreak() : void {
			_baseLine += _baseOffset + _margin.top;
			_baseOffset = 0;
			_offset = _padding.left;
		}
	}
}
