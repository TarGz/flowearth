package fr.digitas.tutorial.nodes {
	import fr.digitas.flowearth.mvc.address.structs.INode;

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