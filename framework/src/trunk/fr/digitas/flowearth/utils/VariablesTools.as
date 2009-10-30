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


package fr.digitas.flowearth.utils {
	import flash.net.URLVariables;		

	/**
	 * Provide tools for URLVariables
	 * 
	 * @author Pierre Lepers
	 */
	public class VariablesTools {
		
		
		/**
		 * check if to URLVariables have strictely same values
		 * @return Boolean true if variables are equals.
		 */
		public static function equals( v1 : URLVariables, v2 : URLVariables) : Boolean {
			var c : int = 0;
			for (var p : String in v1) {
				c++;
				if( v2[ p ] != v1[ p ] ) return false;
			}
			for ( p in v2 ) c--;
			return c==0;
		}
		
		/**
		 * concat values of 2 URLVAriables.
		 * note that if a variable exist in the 2 given URLVariables, the value of the first param is keep.
		 */
		public static function concat( v1 : URLVariables, v2 : URLVariables ) : URLVariables {
			if( !v1 && !v2 ) return null;
			var res : URLVariables = new URLVariables();
			var p : String;
			if( v2 ) for ( p in v2 ) res[p] = v2[p];
			if( v1 ) for ( p in v1 ) res[p] = v1[p];
			return res;
		}
	}
}
