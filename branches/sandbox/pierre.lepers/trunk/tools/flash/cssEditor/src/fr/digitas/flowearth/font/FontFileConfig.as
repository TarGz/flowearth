package fr.digitas.flowearth.font {
	import fr.digitas.flowearth.csseditor.data.compiler.buildsProvider;
	import fr.digitas.flowearth.csseditor.event.FontEvent;
	import fr.digitas.flowearth.csseditor.view.fontprofile.FontDetailsManager;
	import fr.digitas.flowearth.csseditor.view.fontprofile.details.RangeProvider;
	import fr.digitas.flowearth.font.FontConfig;
	import fr.digitas.flowearth.process.BuildInfos;
	import fr.digitas.flowearth.process.flex.MxmlcConfiguration;
	import fr.digitas.flowearth.process.flex.MxmlcProcess;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NativeProcessExitEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.Dictionary;	

	/**
	 * @author Pierre Lepers
	 */
	public class FontFileConfig extends FontFileInfo {

		
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
		
		
		override public function getInfoByName( fontName : String ) : FontInfo {
			for each (var fConfig : FontConfig in _fontConfigs) 
				if( fConfig.fontFamily == fontName ) return fConfig;
			return null;
		}

		override public function hasInfoByName( fontName : String ) : Boolean {
			trace( "--" + fontName );
			for each (var fConfig : FontConfig in _fontConfigs) {
				trace( "   "+fConfig.fontFamily );
				if( fConfig.fontFamily == fontName ) return true;
			}
			return false;
		}
		
		

		public function FontFileConfig( ) {
			super( null );
			_fontConfigs = new Vector.<FontConfig>( );
		}
		
		public function openPanel() : void {
			FontDetailsManager.instance.openConfig( this );
		}

		
		
		public function build( ) : BuildInfos {
			
			if( _currentBuildProcess ) {
				_currentBuildProcess.dispose();
				_currentBuildProcess.process.removeEventListener(NativeProcessExitEvent.EXIT, onProcessComplete );
			}
				
			var config : MxmlcConfiguration = getMxmlcConfig( );
			
			MxmlcProcess.log =true;
			_currentBuildProcess = new BuildInfos( MxmlcProcess.run( config ) );
			_currentBuildProcess.process.addEventListener(NativeProcessExitEvent.EXIT, onProcessComplete );
			
			dispatchEvent( new FontConfigEvent( FontConfigEvent.BUILD_START, null ) );
			
			buildsProvider.getHistory().addBuild( _currentBuildProcess );
			
			
			
			return _currentBuildProcess;
		}
		
		public function clone() : FontFileConfig {
			var exp : XML = export();
			var res : FontFileConfig = new FontFileConfig();
			res._import( exp );
			return res;
		}

		
		
		private function onProcessComplete(event : NativeProcessExitEvent) : void {
			if( event.exitCode == 0 )
				dispatchEvent( new FontEvent( FontEvent.FILE_CHANGE, null ) );
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
			output = new File( datas.output.text( ) );
			
			var fc : FontConfig;
			
			while( _fontConfigs.length > 0  )
				removeConfig( _fontConfigs.shift() );
			
			
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


		public function addConfig( config : FontConfig ) : void {
			if( _fontConfigs.indexOf( config ) == - 1 ) {
				_fontConfigs.push( config );
				dispatchEvent( new FontConfigEvent( FontConfigEvent.CONFIG_ADDED , config ) );
				registerConfig( config );
				change( );
			}
		}

		public function removeConfig( config : FontConfig ) : void {
			var index : int = _fontConfigs.indexOf( config );
			if( index > - 1 ) {
				_fontConfigs.splice( index , 1 );
				dispatchEvent( new FontConfigEvent( FontConfigEvent.CONFIG_REMOVED , config ) );
				unRegisterConfig( config );
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
		
		override public function getFontInfos() : Vector.<FontInfo> {
			var res : Vector.<FontInfo> = new Vector.<FontInfo>( _fontConfigs.length, true );
			for (var i : int = 0; i < res.length; i++)
				res[i] = _fontConfigs[i];
			
			return res;
		}
		
		private function registerConfig( config : FontConfig ) : void {
			config.addEventListener( Event.REMOVED , confHandleRemove );
			config.addEventListener( Event.CHANGE , confHandleChange );
		}

		private function unRegisterConfig( config : FontConfig ) : void {
			config.removeEventListener( Event.REMOVED , confHandleRemove );
			config.removeEventListener( Event.CHANGE , confHandleChange );
		}
		
		private function confHandleRemove(event : Event) : void {
			removeConfig( event.currentTarget as FontConfig );
		}

		private function confHandleChange(event : Event) : void {
			change();
		}

		
		
		
		private var _currentBuildProcess : BuildInfos;
		
		private var _className : String;

		private var _fontConfigs : Vector.<FontConfig>;
	}
}
