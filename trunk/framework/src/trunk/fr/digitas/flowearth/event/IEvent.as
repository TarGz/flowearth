package fr.digitas.flowearth.event {
	import flash.events.Event;	
	
	/**
	 * @author Pierre Lepers
	 */
	public interface IEvent {
		
		function isDefaultPrevented() : Boolean;

		function get eventPhase() : uint;

		function formatToString(className : String, ...args) : String;

		function clone() : Event;

		function get bubbles() : Boolean;

		function preventDefault() : void;

		function stopPropagation() : void;

		function toString() : String;

		function get target() : Object;

		function get cancelable() : Boolean;

		function get currentTarget() : Object;

		function get type() : String;

		function stopImmediatePropagation() : void;
		
	}
}
