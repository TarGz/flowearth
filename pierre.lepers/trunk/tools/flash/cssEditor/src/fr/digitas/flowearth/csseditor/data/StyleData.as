package fr.digitas.flowearth.csseditor.data {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.csseditor.event.PropertyEvent;
	import fr.digitas.flowearth.csseditor.event.StyleEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TextEvent;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class StyleData extends EventDispatcher {

		
		

		public function hasProperty( name : String ) : Boolean {
			return (_dProps[ name ] != undefined );
			
		}
		
		
		public function get length() : uint {
			return _length;
		}
		
		public function get cssData() : CSSData {
			return _cssData;
		}

		public function addProperty( prop : StyleProperty ) : void {
			if( _dProps[ prop.name ] != undefined ) throw new Error( "fr.digitas.flowearth.csseditor.data.StyleData - addProperty : already exist" );
			_aProps.push( prop );
			_length ++;
			_dProps[ prop.name ] = prop;
			prop.addEventListener( PropertyEvent.RENAME , onPropRename );
			prop.addEventListener( Event.CHANGE , onPropChange );
			prop.addEventListener( PropertyEvent.REMOVED , onPropRemoved );
			dispatchEvent( new PropertyEvent( PropertyEvent.ADDED, prop ) );
		}
		

		public function removeProperty( prop : StyleProperty ) : void {
			_dProps[ prop.name ].removeEventListener( PropertyEvent.RENAME , onPropRename );
			_dProps[ prop.name ].removeEventListener( Event.CHANGE , onPropChange );
			_dProps[ prop.name ].removeEventListener( PropertyEvent.REMOVED , onPropRemoved );
			delete _dProps[ prop.name ];
			_aProps.splice( _aProps.indexOf( prop ) , 1 );
			_length --;
			dispatchEvent( new PropertyEvent( PropertyEvent.REMOVED, prop ) );
		}

		private function renameProperty( oldName : String, newName : String ) : Boolean {
			if( _dProps[ oldName ] == undefined ) return false;
			if( _dProps[ newName ] != undefined ) return false;
			_dProps[ newName ] = _dProps[ oldName ];
			delete _dProps[ oldName ];
			return true;
		}
		
		private function onPropRename( event : TextEvent ) : void {
			renameProperty( event.text, ( event.currentTarget as StyleProperty ).name );
		}
		
		private function onPropChange(event : Event) : void {
			_change();
		}
		
		private function onPropRemoved(event : PropertyEvent) : void {
			removeProperty( event.prop );
		}
		

		public function getName() : String {
			return _name;
		}
		
		public function setName(name : String) : void {
			name = checkSuper( name );
			if( _name == name ) return;
			var _oname : String = _name;
			_name = name;
			dispatchEvent( new TextEvent( StyleEvent.RENAME, false, false , _oname ) );
			_change( );
		}
		
		private function checkSuper(name : String) : String {
			var index : int = name.indexOf( ">" );
			if( index > -1 ) {
				superName = name.substr( index + 1 );
				return name.substr( 0, index );
			}
			return name;
		}

		
		public function get superName() : String {
			return _superName;
		}
		
		public function set superName(superName : String) : void {
			if( superName == "" ) superName = null;
			_superName = superName;
			dispatchEvent( new StyleEvent( StyleEvent.SUPER_CHANGE, this  ) );
			_change();
		}
		
		public function getProps() : IIterator {
			return new Iterator( _aProps );
		}
		
		public function getPropValue( name : String ) : * {
			return _dProps[ name ];
		}
		
		public function StyleData( name : String ) {
			_name = checkSuper( name );
			_aProps = [];
			_dProps = new Dictionary();
		}
		
		
		public function focus() : void {
			_cssData.currentStyle = this;
		}

		
		private function _change() : void {
			dispatchEvent( new Event( Event.CHANGE ) );
		}

		private var _name : String;
		
		private var _superName : String;
		
		private var _aProps : Array;
		
		private var _dProps : Dictionary;
		
		private var _length : uint = 0;
		
		internal var _cssData : CSSData;
		
	}
}
