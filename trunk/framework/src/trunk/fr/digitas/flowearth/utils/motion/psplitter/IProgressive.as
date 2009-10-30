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

	/**
	 * @author Pierre Lepers
	 */
	public interface IProgressive {
		
		/**
		 * pondere la durée de l'interpolation pour cet objet (peut etre 1 par defaut du coup)
		 */
		function get pond() : Number;
		
		/**
		 * appelé par le splitter lorsque progress est modifié
		 */
		function setProgress( p : Number ) : void;
		
	}
}
