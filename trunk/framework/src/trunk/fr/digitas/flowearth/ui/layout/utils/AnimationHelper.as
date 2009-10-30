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


package fr.digitas.flowearth.ui.layout.utils {
	import fr.digitas.flowearth.ui.layout.ILayoutItem;
	import fr.digitas.flowearth.utils.motion.psplitter.IProgressive;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;	

	/**
	 * 
	 */
	public class AnimationHelper extends Shape implements ILayoutItem, IProgressive {

		
		public var timeStretch : Number = 1;
		
		public function AnimationHelper ( original : DisplayObject ) {
			super( );
			_original = original;
			if ( _original is IInterpolable ) timeStretch = ( _original as IInterpolable ).timeStretch;
		}
		

		public function getWidth () : Number {
			return ( _original is ILayoutItem ) ? ( _original as ILayoutItem).getWidth( ) : _original.width;
		}

		public function getHeight () : Number {
			return ( _original is ILayoutItem ) ? ( _original as ILayoutItem).getHeight( ) : _original.height;
		}

		
		public function get original () : DisplayObject {
			return _original;
		}
		
		public function setProgress ( p : Number ) : void {
			_progress = p;
		}

		public function getProgress () : Number {
			return _progress;
		}

		public function get pond () : Number {
			return timeStretch;
		}

		protected var _original : DisplayObject;

		private var _progress : Number;

	}
}
