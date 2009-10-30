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


package fr.digitas.flowearth.command.traverser 
{
/**
 * @author Pierre Lepers
 */
	public const nullTraverser : IBatchTraverser = new NullTraverser();
}

import fr.digitas.flowearth.command.Batcher;
import fr.digitas.flowearth.command.IBatchable;
import fr.digitas.flowearth.command.traverser.IBatchTraverser;

class NullTraverser implements IBatchTraverser {

	public function enter (b : Batcher) : IBatchable {
		return b;
	}
	
	public function add( sub : IBatchTraverser ) : IBatchTraverser {
		return sub;
	}
	
	public function leave (b : Batcher) : void {
	}
	
	public function item (i : IBatchable) : IBatchable {
		return i;
	}
}

