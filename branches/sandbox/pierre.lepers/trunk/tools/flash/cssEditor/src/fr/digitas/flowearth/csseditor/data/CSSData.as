package fr.digitas.flowearth.csseditor.data {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.csseditor.event.StyleEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TextEvent;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class CSSData extends EventDispatcher {

		
		
		public function CSSData() {
			_aStyles = [];
			_dStyles 	= new Dictionary();
			_invdStyles = new Dictionary();
		}

		public function addStyle( name : String ) : StyleData {
			
			if( _dStyles[ name ] == undefined ) {
				var s : StyleData = new StyleData( name );
				s._cssData = this;
				_aStyles.push( _dStyles[ name ] = s );
				
				s.addEventListener( Event.CHANGE , onStyleChange );
				s.addEventListener( StyleEvent.RENAME , onStyleNameChange );
			}
			return _dStyles[ name ];
		}

		public function removeStyle( name : String ) : void {
			var sd : StyleData = _dStyles[ name ];
			sd._cssData = null;
			var index : int = _aStyles.indexOf( sd );
			if( index > - 1 ) _aStyles.splice( index , 1 );
			_dStyles[ name ].removeEventListener( Event.CHANGE , onStyleChange );
			_dStyles[ name ].removeEventListener( StyleEvent.RENAME , onStyleNameChange );
			delete _dStyles[ name ];
		}

		private function renameStyle( oldName : String, newName : String ) : Boolean {
			if( _dStyles[ oldName ] == undefined ) return false;
			if( _dStyles[ newName ] != undefined ) return false;
			_dStyles[ newName ] = _dStyles[ oldName ];
			delete _dStyles[ oldName ];
			return true;
		}

		public function getStyle( name : String ) : StyleData {
			return _dStyles[ name ];
		}

		public function getStyles( ) : IIterator {
			return new Iterator( _aStyles );
		}
		
		private function onStyleChange(event : Event) : void {
			dispatchEvent( event );
		}
		
		private function onStyleNameChange(event : TextEvent) : void {
			renameStyle( event.text, ( event.currentTarget as StyleData ).getName() );
		}

		private var _aStyles : Array;

		private var _dStyles : Dictionary;
		private var _invdStyles : Dictionary;
	}
}
