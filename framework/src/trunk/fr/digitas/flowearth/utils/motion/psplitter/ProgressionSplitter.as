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


package fr.digitas.flowearth.utils.motion.psplitter {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.core.IteratorR;	

	/**
	 * reparti une valeur global( progress ) sur une list d'objet (
	 * 
	 * @author Pierre Lepers
	 */
	public class ProgressionSplitter {
		
		/**
		 * pourcentage de chevauchement d'une progression d'un item sur le suivant ( j'me comprend )
		 */
		public var decay : Number = 0;

		/**
		 * inverse la liste
		 */
		public var revert : Boolean = false;
		
		
		

		public function set progress ( p : Number ) : void {
			if( p == _progress ) return;
			_progress = p;
			_compute();
		}
		
		public function get progress () : Number {
			return _progress;
		}

		public function get size () : Number {
			return _size;
		}
		
		
		
		public function ProgressionSplitter () {
			_list = new Array();
		}
		
		public function push( progressive : IProgressive ) : void {
			_size += progressive.pond;
			_list.push( progressive );
		}
		
		/**
		 * reset and remove all item;
		 */
		public function clear() : void {
			_size = 0;
			_list = new Array();
		}

		
		public function getIterator () : IIterator {
			return new Iterator( _list );
		}

		private function _compute() : void {
			var S : Number = 1/( _size + decay );
			
			var iterator : IIterator = revert ? new IteratorR( _list ) : new Iterator( _list );
			var ah : IProgressive;
			var c : Number = 0;
			var dp1 : Number;
			while ( iterator.hasNext() ) {
				ah = iterator.next( ) as IProgressive;
				dp1 = decay + ah.pond;
				ah.setProgress( Math.min( 1, Math.max( 0 , _progress / (S * dp1 ) - ( c/ dp1 ) ) ) );
				c += ah.pond;
			}
		}
		

		private var _progress : Number = 0;
		
		private var _list : Array;
		
		private var _size : Number = 0;
	}
}