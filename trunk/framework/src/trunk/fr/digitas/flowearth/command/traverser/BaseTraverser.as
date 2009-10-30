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


package fr.digitas.flowearth.command.traverser {
	import fr.digitas.flowearth.command.Batcher;
	import fr.digitas.flowearth.command.IBatchable;
	import fr.digitas.flowearth.command.traverser.IBatchTraverser;	

	/**
	 * Batch tarerser abstrait, implementation en decorateur
	 * @author Pierre Lepers
	 */
	public class BaseTraverser implements IBatchTraverser {
		
		
		public function BaseTraverser( sub : IBatchTraverser = null ) {
			if( !sub ) sub = nullTraverser;
			_subTraverser = sub;
		}
		
		public function add( sub : IBatchTraverser ) : IBatchTraverser {
			_subTraverser =	_subTraverser.add( sub );
			return this;
		}

		public function enter (b : Batcher) : IBatchable {
			return _subTraverser.enter(b);
		}
		
		public function leave (b : Batcher) : void {
			_subTraverser.leave(b);
		}

		public function item (i : IBatchable) : IBatchable {
			return _subTraverser.item(i);
		}

		public function get subTraverser() : IBatchTraverser {
			return _subTraverser;
		}

		protected var _subTraverser : IBatchTraverser;
		
	}
}
