package fr.digitas.flowearth.mvc.address.structs.descriptor {
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;		

	/**
	 * @author Pierre Lepers
	 */
	public class BaseDescriptor implements INodeDescriptor {

		public var childs : Array;
		
		public var id : String;
		
		public var defaultId : String;


		public function BaseDescriptor() {
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

	}
}
