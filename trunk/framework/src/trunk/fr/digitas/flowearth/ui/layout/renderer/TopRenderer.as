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
	public class TopRenderer extends ChildRenderer {
	
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
		}
	}
}

