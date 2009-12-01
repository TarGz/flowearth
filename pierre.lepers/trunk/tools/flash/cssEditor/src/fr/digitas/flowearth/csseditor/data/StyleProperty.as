package fr.digitas.flowearth.csseditor.data {
	import fr.digitas.flowearth.csseditor.data.builder.Transtyper;	
	import fr.digitas.flowearth.csseditor.data.builder.types.PropertyType;	
	import fr.digitas.flowearth.core.Iterator;	
	import fr.digitas.flowearth.core.IIterator;	
	import fr.digitas.flowearth.csseditor.data.builder.TypeMapper;
	import fr.digitas.flowearth.csseditor.data.errors.ValidityState;
	import fr.digitas.flowearth.csseditor.data.lexem.NativeProps;
	import fr.digitas.flowearth.csseditor.event.PropertyEvent;
	import fr.digitas.flowearth.csseditor.event.ValidityEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TextEvent;	

	/**
	 * @author Pierre Lepers
	 */
	public final class StyleProperty extends EventDispatcher {

		
		
		public function StyleProperty( name : String ) {
			setName( name );
			_validityStates = [];
		}
		
		
		
		private var _strValue : String;

		private var _value : *;
		private var _name : String;

		private var _type : PropertyType;

		public function get strValue() : String {
			return _strValue;
		}
		
		public function set strValue(strValue : String) : void {
			if( strValue == "null" ) strValue = null;
			if( _strValue == strValue ) return;
			_strValue = strValue;
			value = Transtyper.transtype( this );
			dispatchEvent( new PropertyEvent( PropertyEvent.STRVALUE_CHANGE , this ) );
		}
		
		public function get value() : * {
			return _value;
		}
		
		public function set value( value : * ) : void {
			if( _value == value ) return;
			_value = value;
			strValue = Transtyper.stringify( this );
			dispatchEvent( new PropertyEvent( PropertyEvent.VALUE_CHANGE , this ) );
			_change();
		}
		
		public function get name() : String {
			return _name;
		}
		
		public function setName(name : String) : void {
			if( _name == name ) return;
			var oname : String = _name;
			_name = name;
			_type = TypeMapper.getType( name );
			dispatchEvent( new TextEvent( PropertyEvent.RENAME, false, false , oname ) );
			_change();
		}
		
		public function get type() : PropertyType {
			return _type;
		}
		
		private function _change() : void {
			_validityStates = [];
			dispatchEvent( new Event( Event.CHANGE ) );
			_checkValidy();
		}

		
		
		private function _checkValidy() : void {
			if( ! NativeProps.isNativeProp( _name ) ) 
				addValidityState( new ValidityState( "prop '" + _name + "' doesn't exist" , ValidityState.WARN_LEVEL ) );
			if( _strValue == null ) 
				addValidityState( new ValidityState( "prop '" + _name + "' has null value" , ValidityState.ERROR_LEVEL ) );
		}
		
		private function addValidityState( vs : ValidityState ) : void {
			_validityStates.push( vs );
			dispatchEvent( new ValidityEvent( ValidityEvent.VALIDITY_CHANGE , vs ) );
		}

		
		
		private var _validityStates : Array;
		
		public function get validityStates() : IIterator {
			return new Iterator( _validityStates );
		}
	}
}
