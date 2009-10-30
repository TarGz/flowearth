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
	import fr.digitas.flowearth.toolbox.URLRequestHelper;
	
	import flash.net.URLRequest;
	import flash.utils.Dictionary;	
	
	import avmplus.File;	

	dynamic final public class Configuration extends AbstractConfiguration {

		
		
		public function Configuration( basedir : String ) {
			super();
			if( basedir ) 
				ref_dir_helper = new URLRequestHelper( new URLRequest( basedir ) );
			_reqStack = [];
		}

		override public function loadXml(urlRequest : URLRequest) : void {
			super.loadXml(urlRequest);
			_shift();
		}
		
		public function getNamespaces() : Array {
			var res : Array = [];
			
			var allUri : Array = [];
			for (var i : String in _pProvider._spaces ) {
				allUri.push( i );
			}
			
			
			for (var i : * in _pProvider._pres ) {
				
				if( i != "null" ) {
					
					var allindex : int = allUri.indexOf(_pProvider._pres[i]);
					allUri.splice(allindex, 1);
					
					res.push( new Namespace( i, _pProvider._pres[i] ) );
					
				}
			}
			
			var c : int = 1;
			for each (var uri : String in allUri ) {
				res.push( new Namespace( "ns_"+c, uri ) );
				c++;
			}
			
			return res;
		}
		
		public function getNames( uri : String ) : Array {
			
			var space : Dictionary = _pProvider._spaces[ uri ];
			var res : Array = [];
			for( var i : String in space )
				res.push(new QName( uri, i ) );
			return res;
		}
		
		public function isSimpleProp( name : QName ) : Boolean {
			return getProperty( name ).hasSimpleContent;
		}

		
		
		
		
		override protected function addExternalRequest(req : URLRequest, params : Object, index : int = -1) : void {
			req = _solveRequest( req );
			var ri : RequestItem = new RequestItem( req, params, RequestItem.EXT );
			_push(ri, index);
		}

		override protected function addDataRequest(req : URLRequest, params : Object, index : int = -1) : void {
			req = _solveRequest( req );
			var ri : RequestItem = new RequestItem( req, params, RequestItem.DTL );
			_push(ri, index);
		}

		override protected function _handleExt(ext : XML, space : Namespace) : void {
			super._handleExt(ext, space);
			_shift();
		}

		override protected function _handleDtl(datas : String, node : XML) : void {
			super._handleDtl(datas, node);
			_shift();
		}
		
		private function _shift() : void {
			if( _reqStack.length == 0 )
				return;
				
			var req : RequestItem = _reqStack.shift();
			try {
				var f : String = File.read( req.request.url );
				trace( "open file : "+req.request.url );
			} catch ( e : Error ) {
				trace( "unable to open file : "+req.request.url );
			}
			if( req.type == RequestItem.EXT )
				_handleExt( XML( f ), req.datas.space );
			if( req.type == RequestItem.DTL )
				_handleDtl( XML( f ), req.datas.node );
		}

		private function _push( ri : RequestItem, index : int ) : void {
			_reqStack.push( ri ); //TODO handle index
		}
		
		private function _solveRequest( req : URLRequest ) : URLRequest {
			var h : URLRequestHelper = new URLRequestHelper( req );
			if( h.absolute ) return req;
			if( ref_dir_helper )
				return ref_dir_helper.append( h );
			return req;
		}

		private var _reqStack : Array;

		private var ref_dir_helper : URLRequestHelper;
		
	}
	
	final class RequestItem {

		public static const EXT : int = 0;
		public static const DTL : int = 1;
		
		public var request : URLRequest;
		public var datas : Object;
		public var type : int;

		public function RequestItem( req : URLRequest , datas : Object, type : int ) {
			this.type = type;
			this.datas = datas;
			this.request = req;
		}
		
	}
	
}



