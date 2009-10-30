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


package fr.digitas.flowearth.ui.scroller {
	import fr.digitas.flowearth.ui.controls.SimpleButton;
	
	import flash.display.Sprite;
	import flash.geom.Rectangle;	

	/**
	 * Element Ascensceur d'un scrollBar
	 * 
	 * @see ScrollBar
	 * @author Pierre Lepers
	 */	public class Ascenseur extends SimpleButton
	{
		
		public var ico : Sprite;
		
		public function Ascenseur()
		{
			setScale9( );
			super();
		}
		
		public function setHeight( val : Number ) : void {
			realHeight = val;
			val = Math.max( val, 8 );
			height = val;
			if( ico ) {
				ico.scaleY = 1/scaleY;
				ico.visible = ( val > 12 );
			}
		}

		public var realHeight : Number; 
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		private function setScale9() : void {
			var x : Number = Math.min( width/3 , 3 );
			var y : Number = Math.min( height/3 , 3 );
			var b : Rectangle = getBounds( this );
			b.inflate( -x, -y );
			scale9Grid = b;				
		}
		
	}
}