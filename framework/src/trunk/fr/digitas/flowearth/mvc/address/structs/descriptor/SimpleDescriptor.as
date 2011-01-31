package fr.digitas.flowearth.mvc.address.structs.descriptor {
	import fr.digitas.flowearth.mvc.address.structs.descriptor.BaseDescriptor;
	
	/**
	 * @author Pierre Lepers
	 * fr.digitas.flowearth.mvc.address.structs.SimpleDescriptor
	 */
	public class SimpleDescriptor extends BaseDescriptor {
		
		public function SimpleDescriptor(datas : XML) {
			_parse( datas );
		}
		
		private function _parse(datas : XML) : void {
			childs = [];
			
			id = datas.@id;
			
			if( datas.@default.length() )
				defaultId = datas.@default;

			for each ( var nodeData : XML in datas.node )
				childs.push( new SimpleDescriptor( nodeData ) );
		}
		
	}
}
