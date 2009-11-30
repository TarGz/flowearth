package fr.digitas.tutorial.batcher {
	import fr.digitas.flowearth.command.IBatchable;
	import fr.digitas.flowearth.event.BatchEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;	

	/**
	 * @author Pierre Lepers
	 */
	public class BatchItem extends EventDispatcher implements IBatchable {
		
		public function execute() : void {
			
			setTimeout( _complete, _duration );
			stime = getTimer();
			pinterval = setInterval( sendProgress , _duration/20 );
		}
		
		public function get weight() : Number {
			return 1;
		}
		
		public function dispose() : void {
			dispatchEvent( new BatchEvent( BatchEvent.DISPOSED , this ) );
		}
		
		private function sendProgress() : void {
			//dispatchEvent( new BatchProgressEvent( BatchProgressEvent.ITEM_PROGRESS, false, ( getTimer( ) - stime ), _duration, getLenght() ) );
			dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, ( getTimer( ) - stime ), _duration ) );
		}
		
		private function _complete() : void {
			clearInterval( pinterval );
			dispatchEvent( new ProgressEvent( ProgressEvent.PROGRESS, false, false, 100, 100 ) );
			dispatchEvent( new Event( Event.COMPLETE ) );
		}
		
		private var _duration : int = 3000;
		
		private var stime : int;
		private var pinterval : int;
	}
}
