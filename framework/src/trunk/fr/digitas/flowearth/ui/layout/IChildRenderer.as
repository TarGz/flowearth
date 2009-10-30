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


package fr.digitas.flowearth.ui.layout {
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	import flash.geom.Rectangle;	

	/**
	 * Interface des objects qui gerent le placement des childrens dans un Layout
	 * 
	 * Peut dispatcher Event.CHANGE qui sera transféré au Layout (qui redispatch le CHANGE )
	 * 
	 * @author Pierre Lepers
	 */
	public interface IChildRenderer extends IEventDispatcher {

		
		function init( padding : Rectangle, margin : Rectangle, w : Number, h : Number ) : void;

		function render( child : DisplayObject ) : void;

		function getType( ) : String;
		
		function complete () : void;
	}
}
