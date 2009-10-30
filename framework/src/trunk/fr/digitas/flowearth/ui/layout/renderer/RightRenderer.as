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
	public class RightRenderer extends ChildRenderer {
	
		public override function init( padding : Rectangle, margin : Rectangle, w : Number, h : Number ) : void {
			super.init(padding, margin, w, h );
			_offset = - padding.width;
		}
	
		public override function render( child : DisplayObject ) : void {
			var w : Number = ( child is ILayoutItem ) ? ( child as ILayoutItem).getWidth() : child.width;
			_offset -= _margin.width + w;
			child.x = _offset;
			child.y = _margin.top + _padding.top;
			_offset -= _margin.left;
		}
	}
}
