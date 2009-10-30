package fr.digitas.flowearth.event {
	import fr.digitas.flowearth.command.IBatchable;	
	
	/**
	 * @author Pierre Lepers
	 */
	public interface IBatchEvent extends IEvent {

		function get item () : IBatchable;
		
	}
}
