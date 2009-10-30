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
	 * @author Pierre Lepers
	 */
	public class StopTraverser implements IBatchTraverser {

		
		public function add(sub : IBatchTraverser) : IBatchTraverser {
			return this;
		}
		
		public function enter(b : Batcher) : IBatchable {
			b.stop();
			return b;
		}
		
		public function leave(b : Batcher) : void {
		}
		
		public function item(i : IBatchable) : IBatchable {
			return i;
		}
	}
}
