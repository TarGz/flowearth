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

	
	/**
	 * Fourni des option supplementaire a l'interpolation des item d'un Layout, lors de l'utilisation d'un InterpolatedRenderer.
	 * Doit (ou peut) etre implementé par un displayObject ajouté au Layout.
	 * 
	 * @author Pierre Lepers
	 * @see ILayoutItem
	 */
	public interface IInterpolable {
		
		/**
		 * pondere la durée de l'interpolation pour cet objet (peut etre 1 par defaut du coup)
		 */
		function get timeStretch() : Number;
		
		/**
		 * facultatif
		 * pour gerer specifiquement la progression de cet objet
		 */
		function setProgress( helper : AnimationHelper ) : Boolean;
	}
}
