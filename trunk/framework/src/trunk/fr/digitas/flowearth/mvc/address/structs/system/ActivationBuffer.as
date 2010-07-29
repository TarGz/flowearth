package fr.digitas.flowearth.mvc.address.structs.system 
{
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.event.NodeEvent;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.IPath;

	//_____________________________________________________________________________
	//															   ActivationBuffer
	
	//			  AAA    CCCCC  TTTTTT IIIIII V     V   AAA   TTTTTT IIIIII  OOOO  NN  NN         BBBBBB  UU   UU FFFFFF FFFFFF EEEEEEE RRRRR   
	//			 AAAAA  CC   CC   TT     II   V     V  AAAAA    TT     II   OO  OO NNN NN         BB   BB UU   UU FF     FF     EE      RR  RR  
	//			AA   AA CC        TT     II    V   V  AA   AA   TT     II   OO  OO NNNNNN         BBBBBB  UU   UU FFFF   FFFF   EEEE    RRRRR   
	//			AAAAAAA CC   CC   TT     II     V V   AAAAAAA   TT     II   OO  OO NN NNN         BB   BB UU   UU FF     FF     EE      RR  RR  
	//			AA   AA  CCCCC    TT   IIIIII    V    AA   AA   TT   IIIIII  OOOO  NN  NN         BBBBBB   UUUUU  FF     FF     EEEEEEE RR   RR 

	
	
	public class ActivationBuffer 
	{
		private var _node : INode;

		function ActivationBuffer( node : INode ) 
		{
			_node = node;
			_node.addEventListener( NodeEvent.CHILD_ADDED, onChildAdded );
		}

		bi_internal function apply( path : IPath ) : void 
		{
		
			if( path.nodeExist( ) ) 
			{
				path.toNode( ).activate( path.getParams( ) );
				_pendingPath = null;
			} 
			else 
			{
				_pendingPath = path;
				_lock = true;
				path.cleanup( ).toNode( ).activate( path.getParams( ) );
			}
			_lock = false;
			
			
		}

		bi_internal function dispose() : void 
		{
			_node.removeEventListener( NodeEvent.CHILD_ADDED, onChildAdded );
			_node = null;
		}

		bi_internal function lockAddress() : Boolean 
		{
			return ( _lock );
		}

		bi_internal function get pendingPath() : IPath
		{
			return _pendingPath;
		}

		
		private function onChildAdded(event : NodeEvent) : void 
		{
			if( _pendingPath ) bi_internal::apply( _pendingPath );
		}

		private var _pendingPath : IPath;
		private var _lock : Boolean = false;
	}
}
