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


package fr.digitas.flowearth.core 
{

	/**
	 * @author Pierre Lepers
	 */
	public class Iterator implements IIterator {
		
		public function Iterator( a : Array ) {
			_a = a;
			_c = 0;
		}
		
		public function next () : Object {
			return _a[_c++];
		}
		
		public function hasNext () : Boolean {
			return _a.length > _c;
		}
		
		protected var _a : Array;
		protected var _c : int;
		
	}
}
