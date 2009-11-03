/* ***** BEGIN LICENSE BLOCK *****
 * Copyright (C) 2007-2009 Digitas France
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * The Initial Developer of the Original Code is
 * Digitas France Flash Team
 *
 * Contributor(s):
 *   Digitas France Flash Team
 *
 * ***** END LICENSE BLOCK ***** */

package fr.digitas.flowearth.conf {
	import fr.digitas.flowearth.conf.ExternalFile;
	
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	
	
	use namespace AS3;
	
	/**
	 * The <code>Configuration</code> is designed to store properties parsed from a specific xml format.
	 * see <a href="http://code.google.com/p/flowearth/wiki/ConfigurationUsage">wiki</a> for details about Configuration.
	 * 
	 * @example The most basic example about configuration 
	 * @includeExample ConfSampleA.as
	 * 
	 * @author Pierre Lepers
	 * @see http://code.google.com/p/flowearth/wiki/ConfigurationUsage
	 */
	public class AbstractConfiguration extends Proxy {

		
		private static const DATA_TO_LOAD_NODE : String = "externalData";
		private static const EXTERNAL_NODE : String = "externalConf";
		private static const SWITCH_NODE : String = "switch";

		
		/**
		 * @private
		 * Constructeur
		 */
		public function AbstractConfiguration () {
			super( );
			
			_pProvider = new PropProvider();
		}

		
		/**
		 * Add a conf file to the list of conf file to load.
		 * <p>You can call this method multiple time. Requests are enqueued and executed sequentially.</p>
		 * @param urlRequest : URLRequest - configuration file to load.
		 */
		public function loadXml ( urlRequest : URLRequest ) : void {
			addExternalRequest(urlRequest, {}, 0);
			
		}

		
		/**
		 * Parse given XML to build Configuration properties.
		 * <p>this method can also initiate loadings of potential 'externalData' and 'externalConf' resources.</p>
		 * <p>You can enforce namespace of the parsed xml by passing a custom namespace to the second argument. If a default namespace already exist in the given xml, it will be replaced.</p>
		 * @param xml : XML - XML to parse
		 * @param inheritSpace - enforce usage of given Namespace to build properties
		 * @return le batch contanant les external a loader pour ce xml
		 */
		public function parseXml ( xml : XML, inheritSpace : Namespace = null ) : void {
			if( inheritSpace ) {
				xml.addNamespace( inheritSpace );
				xml.setNamespace( inheritSpace );
//				var nxml :  XML = XML( xml.toXMLString() );
//				xml = nxml;
			}
			_parseDatas( xml );
		}		

		//________________________________________________________________________________________________________________________
		//																								  RÉCUPERATION DES DONNÉES
		
		
		/**
		 * Return a String representation of a property.
		 * <p>Note that String is the native value of a Configuration property.</p>
		 * @param propName : Object : a String or the QName of the property to retreive
		 * @return String - contenu de la propriété
		 * @throws Error if property with the given QName doesn't exist.
		 */	
		public function getString ( propName : Object ) : String {
			return getProperty( propName ).value; 
		}

		
		/**
		 * Return a boolean representation of a property.
		 * <p>return true if String lower case value of the property equals to "true" or "1". return false in other case.</p>
		 * @param propName : Object : a String or the QName of the property to retreive
		 * @return Boolean - renvoie true if <code>String.toLowerCase()</code> on the string value equal to <b>"true"</b> or <b>"1"</b>, false in all other cases.
		 * @throws Error if property with the given QName doesn't exist.
		 */	
		public function getBoolean ( propName : Object ) : Boolean {
			var val : String = getProperty( propName ).value.toLowerCase( );
			return (val == "true" || val == "1");
		}	

		
		/**
		 * return Number representation of a property.
		 * <p>return the result of <code>parseFloat()</code> method.</p>
		 * @param propName : Object : a String or the QName of the property to retreive
		 * @return Number - return the result of  <code>TopLevel.parseFloat()</code> on the string representation of the given property.
		 * @throws Error if property with the given QName doesn't exist.
		 */	
		public function getNumber ( propName : Object ) : Number {
			return parseFloat( getProperty( propName ).value );
		}

		/**
		 * return a XML object, containing the content of the given property.
		 * <p>The string representation of the property is convert to xml then surounded with an xml node named with the propery's localName.</p>
		 * renvoi un XML, toutes les propriété du conf ayant un contenu complexe peuvent etre recuperés via cette methode,<br>
		 * ainsi que les xml chargés via externalData
		 * @see http://livedocs.adobe.com/flex/2/langref/XML.html#hasComplexContent()
		 * @param propName : Object :a String or the QName of the property to retreive
		 * @return XMLList - renvoie un copie du noeud "propName" . Une nouvelle instance XML est renvoyé a chaque appel de cette methode
		 * @throws Error if property with the given QName doesn't exist.
		 */
		public function getDatas ( propName : Object ) : XML {
			var prop : ConfProperty = getProperty( propName );
			var qn : QName = new QName( propName );
			return XML( "<" + qn.localName + ">" + prop.value + "</" + qn.localName + ">" );
		}	

	
		/**
		 * Renvoi true si la propriété existe, false sinon
		 * 
		 * @param propName : Object : a String or the QName of the property to retreive
		 * @return Boolean - true si la propriété existe, false sinon
		 */	
		public function hasProperty( propName : Object ) : Boolean 
		{
			var name : QName = new QName( propName );
			var prop : ConfProperty = _pProvider.getProperty( name );
			return ( prop != null );
		}

		
		
		
		/**
		 * Definie ou redefinie une propriété<br>
		 * les propriétés dependantes sont automatiquement afféctées
		 * @param name : String - a String or the QName of the property to set
		 * @param value : String - valeur de la propriété, peut contenir des variable( ${prop} ) 
		 */
		public function setProperty ( propName : Object, value : * ) : void 
		{
			var name : QName = new QName( propName );
			var prop : ConfProperty = _pProvider.getProperty( name );
			
			if( ! prop ) {
				
				var propNode : XML = <temp/>;
				propNode.addNamespace( name );
				propNode.setName( name );
				
				propNode.appendChild( value );
				 _pProvider.setProperty( name , prop = new ConfProperty( propNode ) );
			}
			else {
				prop.invalidate( _pProvider );
				prop.source = value;
			}
		}
		
		
		/**
		 * supprime une propriété du conf.
		 * @param propName : Object : propriété a recuperer, l'object passé en parametre est casté en String
		 * @param killDependers : supprime les propriétés dependantes (false par defaut );
		 */
		public function deleteProperty( propName : Object, killDependers : Boolean = false) : void 
		{
			var name : QName = new QName( propName );
			var prop : ConfProperty =_pProvider.getProperty( name );
			var deps : Array = prop.getDependers();
			var dep : QName;
			if( killDependers )	
				for each ( dep in deps ) deleteProperty( dep, true );
			else {
				_resolveProperty( prop );
				for each ( dep in deps ) _pProvider.getProperty( dep ).breakDependancie( prop );
			}
			_pProvider.deleteProperty( name ) ;
		}
		
		
		/**
		 * supprime un namespace du Conf et toutes les prop associées
		 * @param uri : String : uri du namespace a supprimer
		 */
		public function deleteSpace( uri : String = null ) : void 
		{
			_pProvider.deleteSpace( uri ) ;
		}

		
		public function solve( str : String, ns : Namespace = null ) : String 
		{
			var propNode : XML = <{TEMP_NAME}/>;
			var name : QName;
			if( ns ) {
				name = new QName( ns, TEMP_NAME );
				propNode.addNamespace( ns );
			} else name = new QName( TEMP_NAME );
			propNode.setName( name );
			propNode.appendChild( str );
			
			return new LazySolver( new ConfProperty( propNode), _pProvider ).solve();
		}

		

		
		
		public function toString () : String 
		{
			
			var str : String = "";
			var properties : Dictionary;
			for ( var uri : String in _pProvider._spaces ) {
				str += "<b>-- " + uri + " -------------------------------------</b>  <br/>\n" ;
				properties = _pProvider._spaces[uri];
				for each( var prop : ConfProperty in properties )
					str += "\t" + prop.name + " --> " + prop.source + " --> " + (( ! prop.resolved )? _resolveProperty( prop ) : prop.value ) + "  <br/>\n" ;
			}
			return str;
		}
		
		protected function addExternalRequest( req : URLRequest, params : Object, index : int = -1 ) : void {
		
		}

		protected function addDataRequest( req : URLRequest, params : Object, index : int = -1 ) : void {
		
		}

		
		
		
		//________________________________________________________________________________________________________________________
		//________________________________________________________________________________________________________________________
		//																												  PRIVATES
		
		
		private function _parseDatas ( xml : XML ) : void {
			_retrieveNamespaceDeclaration( xml );
			
			_buildProperties( xml );
			_computeSwitchs( xml );
			_enqueue( xml );
		}

		
		//_____________________________________________________________________________
		//																	  NAMESPACE
		
		
		private function _retrieveNamespaceDeclaration( xml : XML ) : void
		{
			var namespaceList : Array = xml.namespaceDeclarations();
			for each( var ns : Namespace in namespaceList ) _pProvider.openNamespace( ns );
		}
		
		
		
		
		
		
		
		//_____________________________________________________________________________
		//																	 PROPERTIES


		protected function getProperty( pName : Object ) : ConfProperty 
		{
			var name : QName = new QName( pName);
			var prop : ConfProperty = _pProvider.getProperty( name );
			if( ! prop ) throw new Error( "Unable to find '" + String( pName ) + "' property" );
			if( ! prop.resolved ) _resolveProperty( prop );
			return prop;
		}
		
		
		private function _buildProperties ( xml : XML ) : void 
		{
			
			var propsNodes : XMLList = _getPropertyNodes( xml );
			var prop : ConfProperty;
			var name : QName;
			
			for each ( var propNode : XML in propsNodes ) 
			{
				name = new QName( propNode.name() );
				
				if( _pProvider.getProperty( name ) ) 
					setProperty( name, propNode.children( ).toString( ) );
				else 
				{
					prop = new ConfProperty( propNode );
					_pProvider.setProperty( name, prop );
				}
			}
		}

		
		private function _resolveProperty ( prop : ConfProperty ) : String 
		{
			if( prop.resolved ) return prop.value;
			return new Solver( prop, _pProvider ).solve();
		}


		private function _getPropertyNodes ( xml : XML ) : XMLList {
			return xml.children( ).( 	localName( ) != DATA_TO_LOAD_NODE 
									&& 	localName( ) != EXTERNAL_NODE
									&& 	localName( ) != SWITCH_NODE
									);
		}
		

		//_____________________________________________________________________________
		//																		SWITCHS
		
		private function _computeSwitchs ( xml : XML ) : void 
		{
			var switchNode : XML;
			var ns : Namespace = xml.namespace();
			
			for each( switchNode in xml.child( SWITCH_NODE  ) ) 
			{
				var prop : String = getString( new QName( ns.uri, switchNode.@property ) );
				
				var resultsNode : XMLList = switchNode.child(new QName( ns.uri, "case" ) ).( @value == prop );
				
				if( resultsNode.length() == 0 ) 
				{
					var caseNodes : XMLList = switchNode.child( new QName( ns.uri, "default" ) );
					
					if( caseNodes.length() == 1 )
						parseXml( caseNodes[0] );
				} 
				else parseXml( resultsNode[0] );
			}
		}
		
		
	
		private function _enqueue ( xml : XML ) : void 
		{
			var hspace : Namespace;
			var extList : XMLList = xml.children().( localName() == EXTERNAL_NODE );
			var extFiles: XMLList;
			for each (var ext : XML in extList ) {
				if( ext.@inheritSpace == "true" ) hspace = ext.namespace();
				else hspace =  null;
				extFiles = ext.descendants().( localName() == "file" );//xml.child( EXTERNAL_NODE ).descendants( "file" );
				_enqueExt( extFiles , hspace );
			}
			
			var dtpList : XMLList = xml.children().( localName() == DATA_TO_LOAD_NODE ).descendants().( localName() == "file" );//xml.child( DATA_TO_LOAD_NODE ).descendants( "file" );
			_enqueDtl( dtpList );
		}
		
		private function _enqueExt ( list : XMLList, inheritSpace : Namespace = null ) : void {
			
			if( list == null ) return;
			
			var node : XML;
			for each( node in list ) 
			{
				var ef : ExternalFile = new	ExternalFile( node, this );
				addExternalRequest( ef.request, {node : node, space : inheritSpace} );
			}
		}

		private function _enqueDtl ( list : XMLList ) : void {
			
			if( list == null ) return;
			
			var node : XML;
			for each( node in list ) 
			{
				var ef : ExternalFile = new	ExternalFile( node, this );
				addDataRequest( ef.request, { node : node } );
			}
		}

		
		protected function _handleExt ( ext : XML, space : Namespace ) : void 
		{
			parseXml( ext, space );
		}
		
		
		
		protected function _handleDtl ( datas : String, node : XML ) : void 
		{
			
			var uri : String;
			
			if( node.namespace() ) uri = node.namespace().uri;
			else uri = null;
			// TODO gerer les prefix ns dans les id de xmlConf et dataToload
			setProperty( new QName( uri, node.@id ) , datas );
//			Logger.info( "bi.conf.Configuration - _onDataToPreloadComplete -- ", new QName( uri, node.@id ) );
//			setProperty( new QName( uri, node.@id.name ), item.data );
		}

		
	
		//_____________________________________________________________________________
		//																 PROXY OVERRIDE

		override flash_proxy function getProperty ( propName : * ) : * 
		{
			var name : QName = new QName( propName );
			
			var prop : ConfProperty = getProperty( propName );
			
			if( !prop ) return null;
			
			var n : Number;
			if( !isNaN( n = parseFloat( prop.value ) ) ) return n;

			if( !prop.hasSimpleContent ) {
				var data : XML = getDatas( name );
				if( data ) return data;	
			}
			
			return prop.value;
		}

		override flash_proxy function setProperty ( propName : *, value : *) : void 
		{
			var name : QName = new QName( propName );
			setProperty( name, value );
		}

		
		
		internal var _pProvider : PropProvider;

		
		private static const TEMP_NAME : String = "__temp__";
		
	}
}


import flash.utils.Dictionary;

//_____________________________________________________________________________
//																   CONFPROPERTY

//	 CCCCC   OOOO  NN  NN FFFFFF    PPPPPP  RRRRR    OOOO  PPPPPP  EEEEEEE RRRRR   TTTTTT YY  YY  
//	CC   CC OO  OO NNN NN FF        PP   PP RR  RR  OO  OO PP   PP EE      RR  RR    TT    YYYY   
//	CC      OO  OO NNNNNN FFFF      PPPPPP  RRRRR   OO  OO PPPPPP  EEEE    RRRRR     TT     YY    
//	CC   CC OO  OO NN NNN FF        PP      RR  RR  OO  OO PP      EE      RR  RR    TT     YY    
//	 CCCCC   OOOO  NN  NN FF        PP      RR   RR  OOOO  PP      EEEEEEE RR   RR   TT     YY




/**
 * @internal
 */
final internal class ConfProperty {
	
	use namespace AS3;
	
	internal function set source ( str : String ) : void {
		if( _locked ) return;
		resolved = false;
		if ( hasSimpleContent || source == null ) _source = str;
		else _source += str;
		if( ! QUICK_PROP_REGEXP.test( _source ) ) value = _source; 
	}


	internal function get source ( ) : String {
		return _source;
	}

	internal function set value ( str : String ) : void {
		resolved = true;
		_value = str;
	}

	internal function get value ( ) : String {
		return _value;
	}

	
	function ConfProperty ( propertyNode : XML ) {
		init(propertyNode);
	}

	internal function invalidate( properties : PropProvider ) : void {
		resolved = nresolved = false;
		for each( var pname : QName in _dependers ) properties.getProperty( pname ).invalidate(properties);
	}

	internal function addDepender ( propName : QName ) : void {
		if( !_dependers ) _dependers = new Array( );
		if( _dependers.indexOf( propName ) == -1 ) _dependers.push( propName );
	}
	
	internal function breakDependancie ( prop : ConfProperty ) : void {
		if( ! _dependers ) return;
		var i : int = _dependers.indexOf( prop.name );
		if( i == -1 ) return;
		_dependers.splice( i, 1 );
		source.replace( S_TOKEN+ prop.name + E_TOKEN, prop.value );
	}

	internal function getDependers () : Array {
		return _dependers;
	}
	
//	internal function getNativeValue() : String {
//		if( ! nresolved ) setNativeValue(str)
//	}
	


	private function init ( d : XML ) : void 
	{
		name = new QName( d.name() );
		var ns : Namespace = d.namespace();
		uri  = ns.uri;
		
		if( hasSimpleContent = d.hasSimpleContent( ) ) {
			source = d.text( );
		} else // TODO Conf optimization - check existance of namespace before clean
			source = cleanNs( d.children( ).toXMLString( ) );
			
		_locked = ( d.@lock == "true" || d.@lock == "1" );
	}
	
	private function cleanNs( input : String ) : String {
		//var r : RegExp = /xmlns(:\w)?="[^"]*"/ig;
//		var r : RegExp = new RegExp( "xmlns(:\\w)?=\"[^\"]*\"", "gi" );
		var r : RegExp = new RegExp( "xmlns(:\\w)?=\""+uri+"\"", "gi" );
		return input.replace( r , "" );
	}

	
	internal var uri 				: String;	
	internal var name 				: QName;	
	internal var resolved 			: Boolean;
	internal var nresolved 			: Boolean;
	internal var hasSimpleContent 	: Boolean;

	
	private var _locked 			: Boolean = false;
	private var _source 			: String;
	private var _value 				: String;
	private var _dependers 			: Array;
}


final internal class PropProvider {

	
	public function PropProvider() {
		_spaces = new Dictionary();
		_pres = new Dictionary();
		_pres[null] = _pres[ "" ] = "";
	}

	internal function setProperty( name : QName, prop : ConfProperty ) : void {
		var space : Dictionary = _spaces[ name.uri ];
		if( ! space ) _spaces[ name.uri ] = space = new Dictionary();
		space[ name.localName ] = prop;
	}

	internal function getProperty( name : QName, strict : Boolean = true ) : ConfProperty {
		var space : Dictionary = _spaces[ name.uri ];
		if( space ) {
			if ( space[ name.localName ] )
				return space[ name.localName ];
			else if ( _spaces[ "" ] && ! strict ) {
				return _spaces[ "" ][ name.localName ];
				
			}
		}
		
			
		return null;
	}
	
	internal function deleteProperty( name : QName ) : void {
		delete _spaces[ name.uri ][ name.localName ];
	}
	
	internal function openNamespace( ns : Namespace ) : void {
		if( ns.prefix == "" ) return;
		if( _pres[ ns.prefix ] != undefined && _pres[ ns.prefix ] != ns.uri ) throw new Error ( "Namaespace "+ns.prefix+" already defined" );
		_pres[ ns.prefix ] = ns.uri;
	}

	internal function namespace( pre : String ) : String {
		return _pres[ pre ];// || emptyNs;
	}
	
	internal function deleteSpace( uri : String ) : void {
		var space : Dictionary = _spaces[ uri ];
		for each (var prop : ConfProperty in space ) {
			var deps : Array = prop.getDependers();
			var dep : QName;
			if( !prop.resolved ) new Solver( prop, this );
			for each ( dep in deps ) getProperty( dep ).breakDependancie( prop );
			delete space[ prop.name ];
		}
		delete _spaces[ uri ];
	}

	internal var _pres : Dictionary;
	internal var _spaces : Dictionary;
}


//_____________________________________________________________________________
//																		 SOLVER
//			 SSSSS  OOOO  LL      V     V EEEEEEE RRRRR   
//			SS     OO  OO LL      V     V EE      RR  RR  
//			 SSSS  OO  OO LL       V   V  EEEE    RRRRR   
//			    SS OO  OO LL        V V   EE      RR  RR  
//			SSSSS   OOOO  LLLLLLL    V    EEEEEEE RR   RR 


/**
 * gere la resolution des variable du conf
 */
internal class Solver {
	
	use namespace AS3;
	
	public function Solver( prop : ConfProperty , properties : PropProvider ) {
		_provider = properties;
		_prop = prop;
	}

	internal function solve() : String {
		var r : String = _prop.value = _prop.source.replace( PROP_REGEXP, _propReplaceFunction );
		
		var dependers : Array = _prop.getDependers( ) ;
		for ( var i : String in dependers )
			_provider.getProperty( dependers[i] ).resolved = false;
		
//		_prop.value;	
		_provider 	= null;
		_prop 		= null;
		
		return r;
	}
	
	
	protected function _propReplaceFunction () : String {
		var local : String = arguments[5];
		var prefix : String = arguments[3];
		var uri : String = ( prefix != "" ) ? _provider.namespace( prefix ) : _prop.uri;
		var name : QName = new QName( uri, local );
		var prop : ConfProperty = _provider.getProperty( name, false );
		//TODO gerer le ns dans la création from scratch
		if( !prop ) _provider.setProperty( name, prop = new ConfProperty( XML("<"+name.localName+"/>") ) );
		prop.addDepender( _prop.name );
		return ( prop.resolved ) ? prop.value : new Solver( prop, _provider ).solve(); 
	}
	
	
	protected var _prop : ConfProperty;
	protected var _provider : PropProvider;
}

/**
 * identique a Solver mais n'ajoute pas de depandance au propriétés, et de prop vide en cas de prop non defini
 */
final internal class LazySolver extends Solver {

	public function LazySolver( prop : ConfProperty , properties : PropProvider ) {
		super( prop, properties );
	}

	override protected function _propReplaceFunction () : String {
		var local : String = arguments[5];
		var prefix : String = arguments[3];
		var uri : String = ( prefix != "" ) ? _provider.namespace( prefix ) : _prop.uri;
		var name : QName = new QName( uri, local );
		var prop : ConfProperty = _provider.getProperty( name, false );
		if( !prop ) return "";
		return ( prop.resolved ) ? prop.value : new Solver( prop, _provider ).solve(); 
	}
}


//_____________________________________________________________________________
//																		 REGEXP
//		RRRRR   EEEEEEE  GGGGG  EEEEEEE X     X PPPPPP  
//		RR  RR  EE      GG      EE        X X   PP   PP 
//		RRRRR   EEEE    GG  GGG EEEE       X    PPPPPP  
//		RR  RR  EE      GG   GG EE        X X   PP      
//		RR   RR EEEEEEE  GGGGG  EEEEEEE X     X PP   q   

internal const PROP_REGEXP 			: RegExp = new RegExp( "(\\$\\{)((\\w*)(::))?(\\w+)(\\})", "gi" );
internal const QUICK_PROP_REGEXP 	: RegExp = new RegExp( "(\\$\\{\\w*(::)?\\w+\\})", "i" );
internal const S_TOKEN 				: String = "${" ;
internal const E_TOKEN 				: String = "}" ;






