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


package fr.digitas.flowearth.ui.scroller 
{

	/**
	 * @author Pierre Lepers
	 */
	public class ScrollPolicy {
		/**
		 * cache la scrollBar si elle n'est pas utile
		 */
		public static const AUTO_HIDE 		: String = "autoHide";

		/**
		 * deactive la scrollBar si elle n'est pas utile
		 */
		public static const AUTO_ACTIVATE 	: String = "autoActivate";

		/**
		 * afiche en permanence la scrolbar, faut s'attendre a des truc bizarre quand meme hein.
		 */
		public static const ALWAYS			: String = "always";

		/**
		 * n'affiche jamais la scrolbar
		 */
		public static const NEVER			: String = "never";
	}
}
