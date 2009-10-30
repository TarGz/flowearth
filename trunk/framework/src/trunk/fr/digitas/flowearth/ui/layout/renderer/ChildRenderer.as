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
	import fr.digitas.flowearth.ui.layout.IChildRenderer;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;	

	/**
	 * Classe Abstraite
	 * @author Pierre Lepers
	 */
	public class ChildRenderer extends EventDispatcher implements IChildRenderer {

		internal var _offset : Number;
		internal var _margin : Rectangle;
		internal var _padding : Rectangle;
		internal var _type : String;
	
		
		public function init( padding : Rectangle, margin : Rectangle, w : Number, h : Number ) : void {
			_margin = margin;
			_padding = padding;
		}
		
		public function getType() :String {
			return _type;
		}
		
		public function render( child : DisplayObject ) : void {
			
		}
		
		public function complete () : void {
			
		}
	}
}
