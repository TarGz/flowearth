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


package fr.digitas.flowearth.core {

	
	/**
	 * Iterator inversé ( part du dernier élement);
	 * @author Pierre Lepers
	 * 
	 * TODO reussir a etendre Iterator sans faire ecrouter le compilo cs3
	 */
	public class IteratorR implements IIterator {

		
		public function IteratorR( a : Array ) {
			_a = a;
			_c = 0;
		}
		
		public function next () : Object {
			return _a[ _a.length - _c++ - 1 ];
		}
		
		public function hasNext () : Boolean {
			return _a.length > _c;
		}
		
		protected var _a : Array;
		
		protected var _c : int;
		
	}
}
