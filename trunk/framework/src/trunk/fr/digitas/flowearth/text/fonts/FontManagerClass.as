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


package fr.digitas.flowearth.text.fonts {
	import flash.text.Font;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	internal class FontManagerClass {


		public function hasFont( fontName : String ) : Boolean {
			return ( _embeddedFonts[ fontName ] != undefined );
		}
		
		public function registerFonts( provider : IFontsProvider ) : void {
			var fonts : Array = provider.getFonts();
			for each (var font : Class in fonts) 
				Font.registerFont( font );
				
			_updateEmbedded();
		}
		
		//_____________________________________________________________________________
		//																		PRIVATE
		
		function FontManagerClass() {
			if( _instance != null ) throw new Error( "FontManagerClass, still created singleton" );
			_embeddedFonts = new Dictionary();
			_updateEmbedded();
		}
		
		private function _updateEmbedded() : void {
			var list:Array = Font.enumerateFonts();
			var n:int = list.length;
			for (var i:Number = 0; i < n; i++) 
				_embeddedFonts[ (list[i] as Font).fontName ] = list[i];
			
		}

		private var _embeddedFonts : Dictionary;


		//_____________________________________________________________________________
		//																		 STATIC
		
		internal static function _start() : FontManagerClass {
			if (_instance == null)
				_instance = new FontManagerClass();
			return _instance;
		}
		
		private static var _instance : FontManagerClass;

		
	}
}
