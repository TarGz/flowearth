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


package fr.digitas.flowearth.mvc.address.struct {
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractNodeDescriptor;					

	/**
	 * @author Pierre Lepers
	 */
	public class BaseDescriptor extends AbstractNodeDescriptor {

		
		
		public function BaseDescriptor( datas : XML ) {
			_parse( datas );
		}
		
		private function _parse(datas : XML) : void {
			_childs = new Array( );
			
			if( datas == null ) return;
			
			_id = datas.@id;
			
			if( datas.@default.length() )
				_defaultId = datas.@default;

			
			for each ( var nodeData : XML in datas.node )
				_childs.push( new BaseDescriptor( nodeData ) );
		}
		
		
		public function setId( id : String ) : void {
			_id = id;
		}

		public function setDefaultId( id : String ) : void {
			_defaultId = id;
		}
		
		public function getChildsArray() : Array {
			return _childs;	
		}
		
	}
}
