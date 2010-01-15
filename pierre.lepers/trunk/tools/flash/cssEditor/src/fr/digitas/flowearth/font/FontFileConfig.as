package fr.digitas.flowearth.font {
	import flash.desktop.NativeProcess;	
	
	import fr.digitas.flowearth.process.flex.MxmlcProcess;	
	import fr.digitas.flowearth.csseditor.view.fontprofile.details.RangeProvider;
	import fr.digitas.flowearth.font.FontConfig;
	import fr.digitas.flowearth.font.FontConfig;
	import fr.digitas.flowearth.process.flex.MxmlcConfiguration;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;		

	/**
	 * @author Pierre Lepers
	 */
	public class FontFileConfig extends EventDispatcher {

		public function get output() : File {
			return _output;
		}

		public function set output(output : File) : void {
			_output = output;
			change( );
		}

		public function get className() : String {
			return _className;
		}
		
		public function set className(className : String) : void {
			_className = className;
			change( );
		}

		public function FontFileConfig( ) {
			_fontConfigs = new Vector.<FontConfig>( );
		}

		public function build( ) : BuildInfos {
			
			if( _currentBuildProcess ) 
				_currentBuildProcess.dispose();
				
			var config : MxmlcConfiguration = getMxmlcConfig( );
			
			MxmlcProcess.log =true;
			_currentBuildProcess = new BuildInfos( MxmlcProcess.run( config ) );
			
			dispatchEvent( new FontConfigEvent( FontConfigEvent.BUILD_START, null ) );
			
			return _currentBuildProcess;
			
		}

		
		
		
		public function getMxmlcConfig() : MxmlcConfiguration {
			
			var tempDir : File = File.createTempDirectory( );
			
			// .as File

			var pkage : Array = _className.split( "." );
			var cname : String = _className;
			var pkageName : String = "";
			if( pkage.length > 1 ) {
				cname = pkage[ pkage.length - 1 ];
				pkage.pop( );
				pkageName = pkage.join( "." );
				var pkagePath : String = pkage.join( File.separator );
				var pkageFile : File = tempDir.resolvePath( pkagePath );
				pkageFile.createDirectory( );
			} else {
				pkageFile = tempDir;
			}
			
			var templateFile : File = new File( "app:/deploy/includes/templates/fontprovider.as.tpl" );
			
			var fs : FileStream = new FileStream( );
			fs.open( templateFile , FileMode.READ );
			var templateStr : String = fs.readUTFBytes( fs.bytesAvailable );
			fs.close( );
			
			var allDeclarations : Vector.<FontDeclaration> = new Vector.<FontDeclaration>( );
			for each (var font : FontConfig in _fontConfigs ) 
				allDeclarations = allDeclarations.concat( font.getDeclarations( ) );
			
			
			templateStr = templateStr.replace( /\$\{fptpl_package\}/g , pkageName );
			templateStr = templateStr.replace( /\$\{fptpl_classname\}/g , cname );
			templateStr = templateStr.replace( /\$\{fptpl_fontsList\}/g , getFontList( allDeclarations ) );

			templateStr = templateStr.replace( /\$\{fptpl_fontsDecl\}/g , getFontOuputs( allDeclarations ) );
			
			var classFile : File = pkageFile.resolvePath( cname + ".as" );
			var classFs : FileStream = new FileStream( );
			classFs.open( classFile , FileMode.WRITE );
			
			classFs.writeUTFBytes( templateStr );
			
			classFs.close( );
			
			var config : MxmlcConfiguration = new MxmlcConfiguration( );
			
			config.mainClass = classFile.nativePath;
			config.output = output.nativePath;
			config.addSource( tempDir.nativePath );
			config.addSource( File.applicationDirectory.resolvePath( "deploy/includes/asSources" ).nativePath );
			
			return config;
		}

		
		public function export() : XML {
			var result : XML = <config/>;
			
			result.appendChild( <cname>{_className}</cname> );
			result.appendChild( <output>{_output.nativePath}</output> );
			
			var fcsdatas : XML = <fonts/>;
			
			for each (var fc : FontConfig in _fontConfigs) {
				fcsdatas.appendChild( fc.export( ) );
			}
			
			result.appendChild( fcsdatas );
			return result;
		}

		public function _import(datas : XML) : void {
			className = datas.cname.text( );
			_output = new File( datas.output.text( ) );
			
			var fc : FontConfig;
			for each (var fdata : XML in datas.fonts.font ) {
				fc = new FontConfig( fdata );
				addConfig( fc );
			}
		}

		
		
		
		private function getFontOuputs( desc : Vector.<FontDeclaration> ) : String {
			var fontd : FontDeclaration;
			var res : String = "";
			for each (fontd in desc ) {
				res += fontd.embedCmd;
			}
			
			return res;
		}

		
		private function getFontList( desc : Vector.<FontDeclaration> ) : String {
			var fontd : FontDeclaration;
			var res : String = "";
			for each (fontd in desc ) 
				res += fontd.className + ",";
			
			return res;
		}

		private function change() : void {
			dispatchEvent( new Event( Event.CHANGE ) );
		}

		public function addConfig( config : FontConfig ) : void {
			if( _fontConfigs.indexOf( config ) == - 1 ) {
				_fontConfigs.push( config );
				dispatchEvent( new FontConfigEvent( FontConfigEvent.CONFIG_ADDED , config ) );
				change( );
			}
		}

		public function removeConfig( config : FontConfig ) : void {
			var index : int = _fontConfigs.indexOf( config );
			if( index > - 1 ) {
				_fontConfigs.splice( index , 1 );
				dispatchEvent( new FontConfigEvent( FontConfigEvent.CONFIG_REMOVED , config ) );
				change( );
			}
		}

		public function addTrueType(ttf : File) : void {
			var config : FontConfig = new FontConfig( );
			config.sourceFile = ttf;
			config.fontFamily = ttf.name.split( "." )[0];
			config.setUnicodeRange( new RangeProvider( null ).getFullRange( ) );
			
			addConfig( config );
		}

		public function getConfigs() : Vector.<FontConfig> {
			return _fontConfigs.concat( );
		}

		
		
		
		private var _currentBuildProcess : BuildInfos;
		
		private var _output : File;

		private var _className : String;

		private var _fontConfigs : Vector.<FontConfig>;
	}
}
