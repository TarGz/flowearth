package fr.digitas.flowearth.text.styles {
	
	/**
	 * getaway used to create textLayoutFramework objects, without creating compile-time dependancy
	 * between flowearth and tlf implementations
	 * 
	 * @author Pierre Lepers
	 */
	public var tlfFactory : ITlfFactory = new NullTlfFactory( );
}
