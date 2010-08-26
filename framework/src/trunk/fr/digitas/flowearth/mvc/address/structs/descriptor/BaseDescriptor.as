package fr.digitas.flowearth.mvc.address.structs.descriptor {
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;		

	/**
	 * @author Pierre Lepers
	 */
	public class BaseDescriptor implements INodeDescriptor {

		public var childs : Array;
		
		public var id : String;
		
		public var defaultId : String;


		public function BaseDescriptor( datas : XML ) {
			_parse( datas );
		}

		public function getDefaultId( ) : String {
			return defaultId;
		}
		
		public function getChilds() : Array {
			return childs;
		}
		
		public function getId() : String {
			return id;
		}
		
		private function _parse(datas : XML) : void {
			childs = [];
			
			id = datas.@id;
			
			if( datas.@default.length() )
				defaultId = datas.@default;

			for each ( var nodeData : XML in datas.node )
				childs.push( new BaseDescriptor( nodeData ) );
		}
		

	}
}