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
	public class VBlockRenderer extends BlockRenderer {

		
		
		public function VBlockRenderer () {
		}

		override public function init (padding : Rectangle, margin : Rectangle, w : Number, h : Number) : void {
			super.init( padding, margin, w, h );
			_baseLine 	= _margin.left + _padding.left;
			_offset = padding.top;
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
			
			if( _offset + _margin.height + h > _mawHeight ) lineBreak();
			_baseOffset = Math.max( _baseOffset , w );
			
			_offset += _margin.top;
			child.x = _baseLine;
			child.y = _offset;
			_offset += _margin.height + h;
		}
		
		private function lineBreak() : void {
			_baseLine += _baseOffset + _margin.left;
			_baseOffset = 0;
			_offset = _padding.top;
		}
	}
}
