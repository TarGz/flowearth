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
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.StatusEvent;	

	/**
	 * IProgressor peut etre ecouté par une <code>ILoadingView</code> pour gerer l'affichage de la progression.
	 * 
	 * 
	 * 
	 * @author Pierre Lepers
	 */
	public interface IProgressor extends IEventDispatcher {		
		
		/**		 * doit dispatcher un StatusEvent.STATUS		 */		function sendStatus( e : StatusEvent ) : void;
				/**		 * doit dispatcher un ErrorEvent.ERROR		 */		function sendError( e : ErrorEvent ) : void;				/**		 * doit dispatcher un ProgressEvent.PROGRESS		 */		function sendProgress( e : ProgressEvent ) : void;
		/**		 * doit dispatcher un Event.OPEN		 */		function sendOpen ( e : Event ) : void;
		/**		 * doit dispatcher un Event.COMPLETE		 */		function sendComplete ( e : Event ) : void;		
	}
}
