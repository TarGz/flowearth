package {
	import flash.utils.Dictionary;

	import fr.digitas.flowearth.conf.Configuration;

	import avmplus.File;
	
	use namespace AS3;

	/**
	 * @author pierre
	 */
	public class AsBuilder {

		
		public function get className() : String {
			return _fullClassName;
		}

		public function set className(fullClassName : String) : void {
			_fullClassName = fullClassName;
		}

		
		public function AsBuilder( conf : Configuration, command : CommandLine  ) {
			this.command = command;
			this.conf = conf;
		}

		public function generate( sourcePath : String ) : void {
			_init();
			
			var asFileStr : String = TEMPLATE.replace(REGEXP, _propReplaceFunction);
			
			if( sourcePath.charAt(sourcePath.length - 1) != '/')
				sourcePath += "/";
			var folder : String = sourcePath + getPackage().replace(/\./g, "/") + "/";
			
			try {
				File.write(folder + getClassName() + ".as", asFileStr);
			} catch( e : Error ) {
				trace("unable to create : " + folder + getClassName() + ".as");
			}
			
			var nss : Array = getNsDeclarations();
			var nsFile : String;

			for each (var nsd : NsDeclaration in nss) {
				nsFile = nsd.getFileString().replace(REGEXP, _propReplaceFunction);
				try {
					File.write(folder + nsd.ns.prefix + ".as", nsFile);
				} catch( e : Error ) {
					trace("unable to create : " + folder + nsd.ns.prefix + ".as");
				}
			}
		}

		
		
		protected function _propReplaceFunction() : String {
			
			var local : String = arguments[5];
			var prefix : String = arguments[3];
			return _repMap[ local ];
		}

		
		private function _init() : void {
			_repMap = new Dictionary();
			
			_repMap[ TOK_NL ] = getLineBreak();
			_repMap[ TOK_PACKAGE ] = getPackage();
			_repMap[ TOK_CNAME ] = getClassName();
			_repMap[ TOK_PROPDECL ] = getPropDeclarations();
			_repMap[ TOK_ALLQN ] = stringifyQns();
			_repMap[ TOK_IMPORTS ] = importNamespaces();
		}

		private function getLineBreak() : String {
			return "\n";
			/* Redtamarin implementation
				var os : String = Capabilities.os;
				var _crlf : String;
				switch( os ) {
					case "Macintosh":
						_crlf = "\n";
						break;
	                    
					case "Linux":
						_crlf = "\r";
						break;
	                    
					case "Windows":
					default:
						_crlf = "\r\n";
				}
			*/
		}

		private function getPackage() : String {
			if (_fullClassName.lastIndexOf(".") == -1 ) return "";
			return _fullClassName.substr(0, _fullClassName.lastIndexOf("."));
		}

		private function getClassName() : String {
			if (_fullClassName.lastIndexOf(".") == -1 ) return _fullClassName;
			return _fullClassName.substr(_fullClassName.lastIndexOf(".") + 1);
		}
		

		private function getNsDeclarations() : Array {
			
			var nss : Array = conf.getNamespaces();
			var res : Array = [];
			for each (var ns : Namespace in nss) {
				if( ns.prefix != "" )
					res.push(new NsDeclaration(ns));	
			}
			
			
			return res;
		}

		private function getPropDeclarations() : String {
			
			// solve all;
			
			var allQns : Array = getAllQnames();
			
			for each (var qn : QName in allQns) {
				conf.getString(qn);
			}
			
			
			var nss : Array = conf.getNamespaces();
			
			var res : String = "";
			var names : Array;
			var deb : String;
			for each (var ns : Namespace in nss) {
				names = conf.getNames(ns.uri);
				var nsStr : String = ( ns.prefix != "" ) ? ns.prefix : "public";
				
				for each (var qn : QName in names ) {
					trace( qn.localName );
					if( conf.isSimpleProp(qn) ) {
						deb = "		" + nsStr + " var " + qn.localName + " : String = \"";
						res += deb + escapeProp(conf.getString(qn), deb.length - 3) + "\";${t_nl}";
					} else {
						deb = "		" + nsStr + " var " + qn.localName + " : XML = ";
						res += deb + "\n" + conf.getDatas(qn) + ";${t_nl}";
					}
				}
			}
			
			
			return res.replace(REGEXP, _propReplaceFunction);
		}

		private function getAllQnames() : Array {
			
			var nss : Array = conf.getNamespaces();
			
			var res : Array = [];
			var names : Array;
			for each (var ns : Namespace in nss) {
				names = conf.getNames(ns.uri);
				res = res.concat( names );
			}
			
			
			return res;
		}
		
		
		private function stringifyQns() : String {
			if( !command.generateQNamesAccess ) return "";
			
			var res : String = "		public function getPropertiesNames() : Array {\n";
			res += "			return _allQns_;\n";
			res += "		}\n\n";
			res += "		private const _allQns_ : Array = 	[\n";
			
			var all : Array = getAllQnames();
			var allStr : Array = [];
			for each (var qn : QName in all) {
				allStr.push( "\n											new QName( \""+qn.uri+"\", \""+qn.localName+"\" )" );
			}
			
			res += allStr.join( "," );
			res += "\n											];";
			
			return res;
		}

		private function importNamespaces() : String {
			var nss : Array = getNsDeclarations();
			var nsFile : String;
			var res : String = "";
			for each (var nsd : NsDeclaration in nss) {
				res += nsd.getImportString().replace(REGEXP, _propReplaceFunction) + "\n";
			}
			return res;
		}
		

		private function escapeProp( str : String, indent : int ) : String {
			var indStr : String = "		";
			while( indent-- > 0 ) indStr += " ";
			str = str.replace(/"/g, "\\\"");
			str = str.replace(/^(.*)$/gm, indStr + "\"$1\\n\"+");
			
			str = str.substr(1 + indStr.length, str.length - 5 - indStr.length);
			
			return str;
		}

		
		private var conf : Configuration;
		
		private var command : CommandLine;

		private var _fullClassName : String = "fr.digitas.flowearth.conf.Conf";

		private var _repMap : Dictionary;

		public static var TEMPLATE : String = "";
		
		TEMPLATE += "package ${t_package} { ${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "	public const ${t_cname} : _Configuration_ = new _Configuration_();${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "}${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "${t_imports}${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "class _Configuration_ {${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "${t_propdecl}${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "${t_allqn}${t_nl}";
		TEMPLATE += "${t_nl}";
		TEMPLATE += "}";

		private static const TOK_NL : String = "t_nl";
		private static const TOK_PACKAGE : String = "t_package";
		private static const TOK_CNAME : String = "t_cname";
		private static const TOK_PROPDECL : String = "t_propdecl";
		private static const TOK_ALLQN: String = "t_allqn";
		private static const TOK_IMPORTS: String = "t_imports";
	}
	
	
	internal const REGEXP : RegExp = new RegExp("(\\$\\{)((\\w*)(::))?(\\w+)(\\})", "gi");

	internal class NsDeclaration {

		
		private var _ns : Namespace;

		public function NsDeclaration( ns : Namespace ) {
		
			_ns = ns;
		}

		public function getFileString() : String {
			
			var TEMPLATE : String = "";
			
			TEMPLATE += "package ${t_package} { ${t_nl}";
			TEMPLATE += "${t_nl}";
			TEMPLATE += "	public namespace " + ns.prefix + " = \"" + ns.uri + "\";";
			TEMPLATE += "${t_nl}";
			TEMPLATE += "}";
			
			return TEMPLATE;
		}

		public function getImportString() : String {
			
			return "import ${t_package}."+ns.prefix+";";
		}

		public function get ns() : Namespace {
			return _ns;
		}
	}
}
