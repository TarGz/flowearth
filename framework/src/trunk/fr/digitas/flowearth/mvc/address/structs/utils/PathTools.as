package fr.digitas.flowearth.mvc.address.structs.utils {
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.IPath;		

	/**
	 * @author Pierre Lepers
	 */
	public class PathTools {

		public static function removeDefaultPart( path : IPath ) : IPath {
			
			var segs : Array/*INode*/ =  path.nodes();
			var len : int = segs.length;
			var ilen : int = len;
			var n : INode;
			while( --len > -1 ) {
				n = segs[ len ];
				if( n.parent() && n.parent().getDefaultChild() == n ) segs.pop();
				else break;
			}
			
			if( ilen == len + 1 ) return path;
			return segs[ len ].path();
		}
	}
}
