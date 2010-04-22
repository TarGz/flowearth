package fr.digitas.flowearth.ui.utils {
	import flash.utils.Dictionary;	
	
	import fr.digitas.flowearth.event.DisposableEventDispatcher;	
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;		

	/**
	 * @author Pierre Lepers
	 */
	public class InvalidationManager extends DisposableEventDispatcher {

		public function InvalidationManager( stage : Stage ) {
			_stage = stage;
		}
		
		public function invalidate( ) : void {
			_stage.addEventListener( Event.RENDER , _onRender );
			_stage.invalidate( );
		}
		

		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			if( _process ) listener( new Event( type ) );
			else  super.addEventListener( type , listener , useCapture , 100000 - _ls.length , false );
		}

		private function _onRender(event : Event) : void {
			_stage.removeEventListener( Event.RENDER, _onRender );
			_process = true;
			dispatchEvent( event );
			dispose();
			_process = false;
		}

		private var _stage : Stage;

		private var _process : Boolean = false;
		
		
		
		//_____________________________________________________________________________
		//																		  ACCES
		
		private static var _dinstance : Dictionary = new Dictionary();

		
		public static function getManager( stage : Stage, type : String = "_im_default" ) : InvalidationManager {
			if ( _dinstance [ type ] == null)
				_dinstance [ type ] = new InvalidationManager(stage);
			return _dinstance [ type ];
		}
		
	}
}
