package fr.digitas.tutorial.nodes {
	import fr.digitas.flowearth.mvc.address.structs.INode;	import fr.digitas.flowearth.mvc.address.structs.Node;	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;	
	/**
	 * @author Pierre Lepers
	 */
	public class ExtraNode extends Node {

		
		public function ExtraNode(descriptor : INodeDescriptor = null) {
			super( descriptor );
		}
		
		override protected function createNode( descriptor : INodeDescriptor ) : INode {
			return new ExtraNode( descriptor );
		}

		public var attribute : String = "";

	}
}
