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


package fr.digitas.flowearth.command {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Pile;	

	/**
	 * Collection pour le batcher Batcher
	 * 
	 * <p>Batch etends Pile mais empeche les doublon, et implemente IIterator</p>
	 * @author Pierre Lepers
	 */
	public class Batch extends Pile implements IIterator {
	
		public static const FIFO : Number = 0;
		public static const LIFO : Number = 1;
		
		
		public function get type () : Number { 
			return _type ; 
		}
		public function set type ( val : Number ) : void { _type = (val ==1 ) ? 1 : 0; }
		
		
		public function Batch() {
			super();
		}
	
		
		public function next() : Object {
			if( _type == 1 ) return removeItemAt( length-1 );
			return removeItemAt( 0 );
		}
	
		public function hasNext() : Boolean {
			return ( length > 0 );
		}
		
		
		override public function addItem( item : * ) : int {
			if( ! item ) throw new ArgumentError( "Impossible d'ajouter un Item null a un Batch" );
			if( indexOf(item) > -1 ) return -1;
			return super.addItem( item );
		}

		override public function addItemAt( item : * , index : uint ) : void {
			if( ! item ) throw new ArgumentError( "Impossible d'ajouter un Item null a un Batch");
			if( indexOf(item) > -1 ) return;
			super.addItemAt( item, index );
		}
		
		private var _type : Number = 0;
		
	}
}
