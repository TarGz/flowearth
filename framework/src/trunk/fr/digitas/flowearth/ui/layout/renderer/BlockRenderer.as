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
	import fr.digitas.flowearth.ui.layout.renderer.ChildRenderer;
	
	import flash.geom.Rectangle;	

	/**
	 * @author Pierre Lepers
	 */
	public class BlockRenderer extends ChildRenderer {

		
		public function BlockRenderer () {
			
		}

		override public function init (padding : Rectangle, margin : Rectangle, w : Number, h : Number) : void {
			super.init( padding, margin, w, h );
			_mawWidth 	= w;
			_mawHeight 	= h;
			_baseOffset = 0;
		}

		protected var _baseLine : Number;
		protected var _baseOffset : Number;
		protected var _mawWidth : Number;
		protected var _mawHeight : Number;
	}
}
