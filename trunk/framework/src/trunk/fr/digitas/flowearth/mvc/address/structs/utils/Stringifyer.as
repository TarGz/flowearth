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


package fr.digitas.flowearth.mvc.address.structs.utils {
	import fr.digitas.flowearth.mvc.address.structs.INode;			

	/**
	 * @author Pierre Lepers
	 */
	public class Stringifyer {

		public static function htmlString( node : INode ) : String {
			
			var t : HtmlStringifyerTraverser = new HtmlStringifyerTraverser();
			node.scan( t );
			return t.result;
			
//			var tab : String = StringUtility.multiply( "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , indent );
//			var str : String = "";
//			var params : String = "";
//			if( node.getParams( ) ) params = node.getParams( ).toString( );
//			
//			if( node.isActive( ) )
//				str += tab + "<b>id : " + node.getId( ) + "  </b><i>" + params + "</i>";
//			else
//				str += tab + "id : " + node.getId( ) + "<i>" + params + "</i>";
//			
//			if( node.getDefaultId( ) )
//				str += "<i>" + node.getDefaultId( ) + "</i>";
//			
//			str += "</br>";
//			
//			var iter : IIterator = node.getChilds( );
//			var i : INode;
//			while ( iter.hasNext( ) ) {
//				i = iter.next( ) as INode;
//				str += tab + htmlString( i , indent + 1 );
//			}
//			return str;
		}
	}
}

import fr.digitas.flowearth.mvc.address.structs.INode;
import fr.digitas.flowearth.mvc.address.structs.traverser.INodeTraverser;
import fr.digitas.flowearth.utils.StringUtility;

class HtmlStringifyerTraverser implements INodeTraverser {

	
	
	
	public function HtmlStringifyerTraverser() {
		_result = "</br>";
	}

	public function get result() : String {
		return _result;
	}

	public function enter(node : INode) : Boolean {
		_tab ++;
		var tab : String = StringUtility.multiply( "|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" , _tab );
		
		var params : String = "";
		if( node.getParams( ) ) params = node.getParams( ).toString( );
			
			
		if( node.isActive( ) )
			_result += tab + "|- <b>id : " + node.getId( ) + "  </b><i> " + params + " </i>";
		else
			_result += tab + "|- id : " + node.getId( ) + " <i> " + params + "</i>";
		
		if( node.getDefaultId( ) )
			_result += " <i> " + node.getDefaultId( ) + "</i>";
			
			
		_result += "</br>";
		
		return true;
	}

	public function leave(node : INode) : void {
		_tab --;
	}

	private var _result : String;
	private var _tab : int = -1;
}