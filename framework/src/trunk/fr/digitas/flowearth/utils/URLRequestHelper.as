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


package fr.digitas.flowearth.utils {
	import flash.net.URLRequest;
	import flash.net.URLVariables;	
	
	use namespace AS3;
	
	/**
	 * Parse et donne des info sur une URL ( domaine, protocole, port, fichier, relative ou absolue , etc...)
	 * 
	 * @author Pierre Lepers
	 */
	public class URLRequestHelper {
		
		
		public static const RELATIVE_PATH : int = 0;
		public static const ABSOLUTE_PATH : int = 1;
		
		/**
		 * renvoi true si l'url est relative, false sinon
		 * 
		 * @return Boolean true si l'url est relative, false sinon
		 */
		public function get relative() : Boolean {
			return _pathType == RELATIVE_PATH;
		}

		/**
		 * renvoi true si l'url est absolue, false sinon
		 * 
		 * @return Boolean true si l'url est absolue, false sinon
		 */
		public function get absolute() : Boolean {
			return _pathType == ABSOLUTE_PATH;
		}
		
		
		/**
		 * renvoi le type de protocole de la requete, null si il n'y en a pas
		 * <listing version="3.0" > 
		 * exemple : 
		 *  ->  "https://mon.subdomain.domain.info:8888/folder/subfolder/index.html?param1=3dfg&amp;param2=mlgvc" 
		 *      renvoi "http"
		 * </listing>
		 * @return String le protocole ou null
		 */
		public function get protocol() : String {
			return _protocole;
		}
		
		/**
		 * renvoi le domain de l'url, ou null si il n'y en a pas.
		 * <listing version="3.0" > 
		 * exemple : 
		 *  ->  "https://mon.subdomain.domain.info:8888/folder/subfolder/index.html?param1=3dfg&amp;param2=mlgvc" 
		 *      renvoi "mon.subdomain.domain.info"
		 * </listing>
		 * @return String le domain de l'url, ou null si il n'y en a pas
		 */
		public function get domain() : String {
			return _domain;	
		}
		/**
		 * renvoi le port de l'url, ou -1 si il n'y en a pas.
		 * <listing version="3.0" > 
		 * exemple : 
		 *  ->  "https://mon.subdomain.domain.info:8888/folder/subfolder/index.html?param1=3dfg&amp;param2=mlgvc" 
		 *      renvoi "8888"
		 * </listing>
		 * @return uint le port de l'url, ou -1 si il n'y en a pas
		 */
		public function get port() : int {
			return _port;	
		}
		
		/**
		 * renvoi le chemin de l'url, ou null si il n'y en a pas.
		 * <listing version="3.0" > 
		 * exemple : 
		 *  ->  "https://mon.subdomain.domain.info:8888/folder/subfolder/index.html?param1=3dfg&amp;param2=mlgvc" 
		 *      renvoi "folder/subfolder/"
		 * </listing>
		 * @return String le chemin de l'url, ou null si il n'y en a pas
		 */
		public function get path() : String {
			return _path;	
		}
		
		/**
		 * renvoi le fichier de l'url, ou null si il n'y en a pas.
		 * <listing version="3.0" > 
		 * exemple : 
		 *  ->  "https://mon.subdomain.domain.info:8888/folder/subfolder/index.html?param1=3dfg&amp;param2=mlgvc" 
		 *      renvoi "index.html"
		 * </listing>
		 * @return String le fichier de l'url, ou null si il n'y en a pas
		 */
		public function get file() : String {
			return _file;	
		}
		
		/**
		 * return extension of the file if request has file and file has extension, otherwise return null.
		 */
		public function get extension() : String {
			return _extension;
		}
		
		/**
		 * renvoi les parametre GET de l'url sous forme d'URLVariables, ou null si il n'y en a pas.
		 * <listing version="3.0" > 
		 * exemple : 
		 *  ->  "https://mon.subdomain.domain.info:8888/folder/subfolder/index.html?param1=3dfg&amp;param2=mlgvc" 
		 *      renvoi { param1 : "3dfg" , param2 : "mlgvc" }
		 * </listing>
		 * @return URLVariables les parametre GET de l'url, ou null si il n'y en a pas
		 */
		public function get parameters() : URLVariables {
			return _params;	
		}
		
		/**
		 * renvoi le fragment de l'url (#...) , ou null si il n'y en a pas.
		 * <listing version="3.0" > 
		 * exemple : 
		 *  ->  "https://mon.subdomain.domain.info:8888/folder/subfolder/index.html?param1=3dfg&amp;param2=mlgvc#le/fragement" 
		 *      renvoi "le/fragement"
		 * </listing>
		 * @return String le fragement de l'url, ou null si il n'y en a pas
		 */
		public function get fragment() : String {
			return _fragment;	
		}
		
		
		/**
		 * Parse et donne des info sur une URL ( domaine, protocole, port, fichier, relative ou absolue , etc...)
		 * 
		 * @param request URLRequest : la request a parser
		 */
		public function URLRequestHelper( request : URLRequest ) {
			_request = request;
			_compute( );
		}
		
		/**
		 * concat this request with the given request
		 */
		public function append( urh : URLRequestHelper ) : URLRequest {
			if( urh.absolute ) 
				throw new Error( "The given URLRequestHelper must be relativ : ", urh._request.url );
				
			
			var url : String = "";
			if( _protocole )
				url += _protocole+"://";
			if( _domain )
				url += _domain + ( ( _port > -1 ) ? (":"+_port) : "" ) + "/";
			
			var inputPathSegments : Array = urh.path ? urh.path.split( "/" ).filter( _skipEmpty ) : [];
			var pathSegments : Array = _path ? _path.split( "/" ).filter( _skipEmpty ) : [];
			
			if( !_extension && _file )
				pathSegments.push( _file );
			
			var ind : int, _rbackCount : int = 0;
			while( ( ind = inputPathSegments.indexOf( ".." ) ) > - 1 ) {
				if( ind == 0 ) {
					_rbackCount ++;
					pathSegments.pop();
					inputPathSegments.shift( );
				}
				else inputPathSegments.splice( ind - 1 , 2 );
			}
			
			url += pathSegments.concat(inputPathSegments).join( "/" )+"/";
			
			if( urh.file )
				url += urh.file;
				
			var result : URLRequest = new URLRequest( url);
			result.data = VariablesTools.concat(_params, urh._params );
			
			return result;
		}

		
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		private function _compute() : void {
			var url : String = _request.url;
			var exec : Array = MAIN_REGEXP.exec( url );
			
			_protocole 	= exec[2] || null;
			_domain 	= exec[3] || null;
			_port 		= exec[5] || -1;
			_path 		= exec[6] || null;
			_file		= exec[8] || null;
			_params		= getParams( exec[9] || null ) ;
			_fragment 	= exec[12] || null;
			_pathType = ( _protocole ) ? ABSOLUTE_PATH : RELATIVE_PATH;
			
			var ql : int = ((exec[9]) ? exec[9].length : 0) + ((exec[10]) ? exec[10].length : 0);
			if( _pathType == RELATIVE_PATH && _domain != null ) {
				if( _file || url.charAt( url.length - 1 - ql ) == "/" )	_path = _domain+'/'+ ((_path ) ? _path : "");
				else _file = _domain;
				_domain = null;
			}
			
			if( _file ) {
				var splitExt : Array = _file.split(".");
				if( splitExt.length > 1 )
					_extension = splitExt[ splitExt.length-1 ];
			}
		}

		private function getParams( s : String ) : URLVariables {
			if( s ) s = s.substr( 1 );
			return new URLVariables( s );
		}
		
		private function _skipEmpty( item : *, index : int, array : Array ) : Boolean {
			return ( item != "" && item != "." );
		}

		
		internal var _request 	: URLRequest;
		
		private var _pathType 	: int;
		private var _protocole 	: String;
		private var _port 		: int;
		private var _domain 	: String;
		private var _path 		: String;
		private var _file 		: String;
		private var _extension 	: String;
		private var _fragment 	: String;
		internal var _params 	: URLVariables;

		//______________________________________________________________
		//														  REGEXP
		
		
		private static const MAIN_REGEXP : RegExp = /^(([\w]+):\/[\/]?)?([^\/:\?#\[\]@]+\.[\w]{2,5})?(:([\d]{1,5}))?\/?(([\w\d~\-._]+\/)*)([\w\d~\-._]+)?(\?[\w\d=%&\/\?]+)?((#)([\w\d~\-._\/\?]+))?/i;
		
	}
}
