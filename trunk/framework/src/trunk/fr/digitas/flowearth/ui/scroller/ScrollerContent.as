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


package fr.digitas.flowearth.ui.scroller {	import flash.display.Sprite;
	import flash.events.Event;	

	/**
	 * @author Pierre Lepers
	 */
	public class ScrollerContent extends Sprite {						public function ScrollerContent() {			super();			_lh = _lw = 0;//			addEventListener( Event.ADDED_TO_STAGE, onAdded );			addEventListener( Event.REMOVED_FROM_STAGE, onRemoved );
		}				
		internal function notifyResize( flag : Boolean) : void {			if( flag )	addEventListener( Event.ENTER_FRAME, enterFrame );			else 		removeEventListener( Event.ENTER_FRAME, enterFrame );		}		private function onRemoved( e : Event ) : void {			removeEventListener( Event.ENTER_FRAME, enterFrame );		}		//		private function onAdded( e : Event ) : void {//			addEventListener( Event.ENTER_FRAME, enterFrame );//		}		private function enterFrame( e : Event ) : void {			if( _lh != height || _lw != width ) dispatchEvent( new Event( Event.RESIZE ) );						_lh = height;			_lw = width;		}		//		override public function set height(value : Number) : void {//			trace( "lkjmkjmljk" );//		}						private var _lw : Number;
		private var _lh : Number;	}}