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

	/**
	 * This interface is used by <code>fr.digitas.flowearth.command.Batcher</code> in two different ways:
	 * <ul>
	 * 	<li>using <code>Batcher#scan()</code> method, the traverser immetiately run into whole Batcher descendants.</li>
	 * 	<li>using <code>Batcher#traverser</code> property, the traverser is called in sync with descendants execution.</li>
	 * 	<li></li>
	 * </ul>
	 * 
	 * <p><code>IBatchTraverser</code> is able to replace or remove <code>IBatchable</code> item of a Batchers structure.</p>
	 * <p>To replace items, <code>enter</code> and <code>item</code> methods can return the new item that will replace the given parameter. </p>
	 * <p>To remove items, <code>enter</code> and <code>item</code> methods can return null. The IBatchable passed as parameter will ber removed from his container.</p>
	 * <p>If you dont want to modify child, return the IBatchable passed as parameter.</p>
	 * <p>Some examples:</p>
	 * <listing version="3.0"> 
	 *	// this implementation replace all item that have a weigth > 10.
	 *	//
	 *	public function item ( i : IBatchable ) : IBatchable  {
	 *		if( i.weight > 10 )
	 *			return new MyCustomIbatchable();
	 *		return i;
	 *	}
	 *	
	 *	// this implementation remove all item that have a weigth > 10.
	 *	//
	 *	public function item ( i : IBatchable ) : IBatchable  {
	 *		if( i.weight > 10 )
	 *			return new MyCustomIbatchable();
	 *		return null;
	 *	}
	 *	
	 *	// this implementation don't modify structure of batchers.
	 *	//
	 *	public function item ( i : IBatchable ) : IBatchable  {
	 *		if( i.weight > 10 )
	 *			trace( "hi guy!" );
	 *		return i;
	 *	}
	 * </listing>
	 * 
	 * 
	 * @see Batcher#scan
	 * @see Batcher#traverser
	 * @author Pierre Lepers
	 */
	public interface IBatchTraverser {
		
		function add ( sub : IBatchTraverser ) : IBatchTraverser; 

		function enter ( b : Batcher ) : IBatchable;

		function leave ( b : Batcher ) : void;

		function item ( i : IBatchable ) : IBatchable;
		
	}
}
