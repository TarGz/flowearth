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


package fr.digitas.flowearth.ui.controls {
	
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;	

	/**
	
	/**
	 * @author Pierre Lepers
	 */
	public class ToggleButton extends SimpleButton {
		public static const TOGGLED : String = "onToggled";
			if( value == _toggled ) return;
	 		dispatchEvent( new BoolEvent( TOGGLED, value , false ) );