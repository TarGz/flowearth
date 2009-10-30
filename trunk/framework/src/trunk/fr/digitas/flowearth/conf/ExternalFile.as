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


package fr.digitas.flowearth.conf {
	import fr.digitas.flowearth.conf.AbstractConfiguration;	
		import flash.net.URLRequest;		/**
	 * @author Pierre Lepers
	 */
	public class ExternalFile {

		public var id 		: String;
		public var size 	: uint;
		public var request 	: URLRequest;
		public var datas 	: XMLList;
		
		public function ExternalFile( node : XML, conf : AbstractConfiguration ) {
			parse( node, conf );
		}
		
		private function parse ( node : XML, conf : AbstractConfiguration ) : void {
			var url : String;
			var _currentURI : String = node.namespace().uri;
			
			if( node.@url.length() > 0 )	url = conf.getString( new QName( _currentURI, node.@url ) );
			else url = conf.solve( node.text( )[0], node.namespace() );
			
			if( node.@size.length() > 0 )	size = node.@size;
			else size = 1;
			
			if( node.@id.length() > 0 )		id = node.@id;
			datas = node.children( );
			request = new URLRequest( url );
		}
	}
}
