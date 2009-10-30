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
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.text.TextField;	

	/**
	* Static class containing string utilities.
	*/
	public class StringUtility {
		
	
		
		/**
		* Duplicates a given string for the amount of given times.
		* @param str String to duplicate.
		* @paran Amount of time to duplicate.
		*/
		public static function multiply(str : String, n : Number):String {
			var ret:String = "";
			for(var i:Number=0;i<n;i++) ret += str;
			return ret;
		}
		
	
		public static function StringToURLRequest(p : String) : URLRequest {
			var split : Array = p.split("?");
			var request:URLRequest = new URLRequest(split[0]);
			request.method = URLRequestMethod.POST;
			try{
				if( split[1] ) request.data = new URLVariables(split[1]);
			}catch( e : Error ) {}
			return request;
		}
		
		/**
		 * renvoi la chaine passé en parametre avec la premiere lettre en majuscule.
		 */
		public static function upperFirstLetter(str : String ) : String {
			str = str.charAt(0).toUpperCase() + str.slice(1);
			return str;
		}
		
		/**
		 * renvoi la chaine passé en parametre sans les tag html.
		 */
		public static function cleanHtmlTags( str : String ) : String 
		{
			var tf : TextField = new TextField();
			tf.htmlText = str;

			return tf.text;
		}
		
		
	}

}