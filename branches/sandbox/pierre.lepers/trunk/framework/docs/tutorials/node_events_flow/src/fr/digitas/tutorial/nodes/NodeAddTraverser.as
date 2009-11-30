package fr.digitas.tutorial.nodes {
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;	

	/**
	 * @author Pierre Lepers
	 */
	public class NodeAddTraverser implements INodeTraverser {
		
		
		
		public function NodeAddTraverser( ) {
			
		}

		public function enter(node : INode) : Boolean {
			
			return true;
		}
		
		public function leave(node : INode) : void {
			_desc = new BaseDescriptor( null );
			_desc.setId( node.getId() );
			
			var cid : String = node.getId()+"-add";
			_desc.getChildsArray().push( new BaseDescriptor( <data id={cid}/> )  );
			
			node.describe( _desc );
			
		}
		
		
		
		private var _desc : BaseDescriptor;
	}
}
