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
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;	

	/**
	 * @author Pierre Lepers
	 */
	public class SimpleButton extends MovieClip {
		public function SimpleButton(){
			focusRect = false;
			if( _selected ) return;
			mouseEnabled  = flag;