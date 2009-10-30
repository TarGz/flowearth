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


package fr.digitas.flowearth.text.styles {
	import flash.text.TextField;
	import flash.text.TextFormat;	

	/**
	 * @author Pierre Lepers
	 */
	public class AdvancedFormat {

		
		public function format( tf : TextField ) : void {
			_formatter.format( tf );
			tf.defaultTextFormat = _format;
			tf.setTextFormat( _format );
		}

		
		internal function parseObject( obj : Object ) : void {
			_format = new FormatFactory( obj ).format( );
			_formatter = new Formatter( obj );
			_obj = obj;
		}

		internal function getFormatter() : Formatter {
			return _formatter;	
		}

		public function getObject() : Object {
			return _obj;
		}

		private var _obj : Object;

		private var _format : TextFormat;
		private var _formatter : Formatter;
	}
}

//_____________________________________________________________________________
//																 FORMAT FACTORY
//
//		FFFFFF  OOOO  RRRRR   MM   MM   AAA   TTTTTT         FFFFFF   AAA    CCCCC  TTTTTT  OOOO  RRRRR   YY  YY  
//		FF     OO  OO RR  RR  MMM MMM  AAAAA    TT           FF      AAAAA  CC   CC   TT   OO  OO RR  RR   YYYY   
//		FFFF   OO  OO RRRRR   MMMMMMM AA   AA   TT           FFFF   AA   AA CC        TT   OO  OO RRRRR     YY    
//		FF     OO  OO RR  RR  MM M MM AAAAAAA   TT           FF     AAAAAAA CC   CC   TT   OO  OO RR  RR    YY    
//		FF      OOOO  RR   RR MM   MM AA   AA   TT           FF     AA   AA  CCCCC    TT    OOOO  RR   RR   YY

import fr.digitas.flowearth.text.styles.TypeMapper;

import flash.text.StyleSheet;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Dictionary;

final class FormatFactory extends StyleSheet {

	
	
	private var _obj : Object;

	public function FormatFactory( obj : Object ) {
		_obj = obj;
	}

	public function format() : TextFormat {
		return transform( _obj );
	}
}

//_____________________________________________________________________________
//																 	  FORMATTER
//
//		FFFFFF  OOOO  RRRRR   MM   MM   AAA   TTTTTT TTTTTT EEEEEEE RRRRR   
//		FF     OO  OO RR  RR  MMM MMM  AAAAA    TT     TT   EE      RR  RR  
//		FFFF   OO  OO RRRRR   MMMMMMM AA   AA   TT     TT   EEEE    RRRRR   
//		FF     OO  OO RR  RR  MM M MM AAAAAAA   TT     TT   EE      RR  RR  
//		FF      OOOO  RR   RR MM   MM AA   AA   TT     TT   EEEEEEE RR   RR 



final class Formatter {


	public function Formatter( obj : Object ) {
		_props = new Dictionary( );
		_tfp =  new Array();
		_compileProps( obj );
	}

	public function format( tf : TextField) : void {
		if( ! tf )
			throw new Error( "com.nissan.core.styles.Style - format() textfield parameters cannot be null" );
		var  l : int = _tfp.length;
		var pname : String;
		while( -- l > - 1 ) {
			pname = _tfp[l];
			tf[ pname ] = _props[pname];
		}
	}

	private function _compileProps(obj : Object) : void {
		var pname : String;
		var transtyped : *;
		for( pname in obj ) {
			transtyped = TypeMapper.transtype( pname , obj[ pname ] );
			if( transtyped != null ) {
				_props[ pname ] = transtyped;
				_tfp.push( pname );
			}
		}
	}

	private var _tfp : Array;
	
	private var _props : Dictionary;
}
