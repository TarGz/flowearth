package {
	
	
	/**
	 * @author pierre
	 */
	public class HelpPrinter {

		public static function print() : void {
			
			var nl : String = "\n";
			
			var help : String = "";
			
			help += "Confitur"+nl;
			help += "Executable tool for Configuration system (fr.digitas.flowearth.conf.Configuration)"+nl;
			help += "author Pierre Lepers (pierre[dot]lepers[at]gmail[dot]com)"+nl;
			help += "powered by Tamarin"+nl;
			help += "version 1.0"+nl;
			help += "usage : "+nl;
			
			help += " -dir <dir>: base directory. Used to solve relative paths into conf and/or relativ input conf files (-in)"+nl;
			help += " -in : input conf xml file (multiple -in arguments allowed)"+nl;
			help += " -report <filename> : emit a list of solved conf properties"+nl;
			help += " -sp <dir> : source path in witch generate classes"+nl;
			help += " -class <name> : the full qualified class name"+nl;
			help += " -qn : provide an access method to all qn prop's in generated class"+nl;
			
			trace(help );
		}

		
	}
}
