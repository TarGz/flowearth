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
	import fr.digitas.flowearth.command.IBatchable;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;		

	/**
	 * @author Pierre Lepers
	 */
	public class BatchableDecorator extends EventDispatcher implements IBatchable {

		
		public var size : int = -1;
		
		public function BatchableDecorator( sub : IBatchable ) {
			super( null );
			if( !_sub ) _sub = sub;
			if( !_sub ) _sub = new NullBatchable( this );
		}
		
		public function decorate( sub : IBatchable ) : void {
			_sub = sub;
		}
		
		public function execute () : void {
		}
		
		public function valueOf() : IBatchable {
			return _sub;
		}

		public function get weight() : Number {
			if( size >= 0 ) return uint( size );
			return _sub.weight;
		}
		
		public function dispose () : void {
			_sub.dispose( );
		}
		
		public function findType( type : * ) : * {
			if( this is type ) 
				return this;
			else if( _sub is BatchableDecorator ) 
				return ( _sub as BatchableDecorator ).findType(type);
			else if( _sub is type )
				return _sub;
			return null;
		}

		
		
		override public function dispatchEvent ( event : Event ) : Boolean {
//			super.dispatchEvent( event );
			return _sub.dispatchEvent( event );
		}
	
		override public function removeEventListener (type : String, listener : Function, useCapture : Boolean = false) : void {
			_sub.removeEventListener( type, proxyListener, useCapture );
			super.removeEventListener( type, listener, useCapture );
		}

		override public function addEventListener (type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			_sub.addEventListener( type, proxyListener, useCapture, priority, useWeakReference );
			super.addEventListener(type, listener, useCapture, priority, useWeakReference );
		}

		private function proxyListener( e : Event ) : void {
			trace( "ddd", e, e.type );
			super.dispatchEvent( e );
		}

		protected var _sub : IBatchable;
		
	}
}


//_____________________________________________________________________________
//																  NullBatchable

import fr.digitas.flowearth.command.IBatchable;
import fr.digitas.flowearth.event.DisposableEventDispatcher;

import flash.events.IEventDispatcher;

class NullBatchable extends DisposableEventDispatcher implements IBatchable {

	
	public function NullBatchable( target : IEventDispatcher ) {
		super( target );
	}
	
	public function get weight() : Number {
		return 1;
	}
	
	public function execute () : void {}	
}
