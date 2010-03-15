////////////////////////////////////////////////////////////////////////////////
//
//  ADOBE SYSTEMS INCORPORATED
//  Copyright 2006-2007 Adobe Systems Incorporated
//  All Rights Reserved.
//
//  NOTICE: Adobe permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

package bi.ant;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.Vector;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DynamicAttribute;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.taskdefs.ExecTask;
import org.apache.tools.ant.types.Commandline.Argument;

import bi.ant.types.Font;

public final class FontProviderWrapper extends Task implements DynamicAttribute {
	private static final int DEFAULT = 0;
	// private static final int EXPRESS_INSTALLATION = 1;
	// private static final int NO_PLAYER_DETECTION = 2;

	private static final String[] templates = new String[] { "fontprovider" };

	private static final String TEMPLATE_DIR = "/templates/";
	private static final String EXTENSION = ".as.tpl";

    private static final String PROVIDER_INTERFACE = "fr/digitas/flowearth/text/fonts/IFontsProvider.as";
    
    private ExecTask _compilTask;
    
    private String swf;

	private String className;
	private String compilerPath;
	private Boolean keepGenerated = false;

	private Vector<Font> fonts = new Vector<Font>();

	private int template = DEFAULT;
	
	

	public FontProviderWrapper() {
		
	}

	public void execute() throws BuildException {
		
		int flexVersion = getCompilerVersion();
		
		log( flexVersion+"" );
		// Check for requirements.
		if (swf == null) {
			throw new BuildException(
					"The <html-wrapper> task requires the 'swf' attribute.",
					getLocation());
		}
		
		String output = getOutput();

		InputStream inputStream = getInputStream();
		
		File outputDir;
		outputDir = new File(output);
		File asFile = null;
			
		if (inputStream != null) {
			BufferedReader bufferedReader = null;
			PrintWriter printWriter = null;
			String path = null;

			try {
				bufferedReader = new BufferedReader(new InputStreamReader(
						inputStream));

				
				if( ! outputDir.exists() )
					outputDir.mkdirs();
				
				
				if (outputDir.exists() && outputDir.isDirectory()) {
					path = output + File.separatorChar + getClassPath();
				} else {
					String base = getProject().getBaseDir()
							.getAbsolutePath();
					outputDir = new File(base + File.separatorChar + output);
					if (outputDir.exists() && outputDir.isDirectory()) {
						path = base + File.separatorChar + output
								+ File.separatorChar + getClassPath();
					} else {
						throw new BuildException(
								"output directory does not exist: "
										+ output);
					}
				}
				
				asFile = new File( path );
				asFile.getParentFile().mkdirs();
				
				printWriter = new PrintWriter( new FileWriter( asFile ) );

				String line;

				while ((line = bufferedReader.readLine()) != null) {
					printWriter.println(substitute(line, flexVersion ));
				}
				
				
			} catch (IOException ioException) {
				System.err.println("Error outputting resource : " + path);
				ioException.printStackTrace();
			} finally {
				try {
					bufferedReader.close();
					printWriter.close();
				} catch (Exception exception) {
				}
			}
			
			
			compile( asFile , outputDir);
		} else {
			throw new BuildException("Missing resources", getLocation());
		}
		
		
		if( !keepGenerated ) {
			deleteDirectory( outputDir );
		}
			
		
	}
	
	private void outputResources(String resourceDir, String[] resources)
    {
        BufferedReader bufferedReader = null;
        PrintWriter printWriter = null;
        
        String output = getOutput();
        File outputDir;
		outputDir = new File(output);
		
		if( ! outputDir.exists() )
			outputDir.mkdirs();
		
        for (int i = 0; i < resources.length; i++)
        {
            try
            {
                InputStream inputStream = getClass().getResourceAsStream(resourceDir + resources[i]);
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                String path = null;

                if (output != null)
                {
                	outputDir = new File(output);
                    if (outputDir.exists() && outputDir.isDirectory())
                    {
                        path = output + File.separatorChar + resources[i];
                    }
                    else
                    {
                        String base = getProject().getBaseDir().getAbsolutePath();
                        outputDir = new File(base + File.separatorChar + output);
                        if (outputDir.exists() && outputDir.isDirectory())
                        {
                            path = base + File.separatorChar + output + File.separatorChar + resources[i];
                        }
                        else
                        {
                            throw new BuildException("output directory does not exist: " + output);
                        }
                    }
                }
                else
                {
                    path = resources[i];
                }

                File file = new File(path);
                file.getParentFile().mkdirs();

                printWriter = new PrintWriter(new FileWriter(file));
                
                String line;

                while ((line = bufferedReader.readLine()) != null)
                {
                    printWriter.println(line);
                }
            }
            catch (IOException ioException)
            {
                System.err.println("Error outputting resource: " + resources[i]);
                ioException.printStackTrace();
            }
            finally
            {
                try
                {
                    bufferedReader.close();
                    printWriter.close();
                }
                catch (Exception exception)
                {
                }
            }
        }
    }

	private void compile(File asFile, File sourcePath) {
		// TODO Auto-generated method stub
		
		
		getCompileTask().setExecutable( compilerPath );
		
		
		Argument arg;
		arg = getCompileTask().createArg();
		arg.setLine( "-sp '"+sourcePath.getAbsolutePath().replace( '\\', '/')+"'" );
		arg = getCompileTask().createArg();
		arg.setLine( "-o '"+swf+"'" );
		arg = getCompileTask().createArg();
		arg.setLine( "-- '"+asFile.getAbsolutePath().replace( '\\', '/')+"'" );
		
		
		
		getCompileTask().execute();
		
	}
	private int getCompilerVersion() {
		ExecTask vtask = (ExecTask) getProject().createTask( "exec" );
		vtask.setExecutable( compilerPath );
		vtask.setOutputproperty( "fpw_mxmlc_version" );
		
		Argument arg;
		arg = vtask.createArg();
		arg.setLine( "-version" );
		
		vtask.execute();
		
		log( getProject().getProperty("fpw_mxmlc_version" ) );
		
		String v = getProject().getProperty("fpw_mxmlc_version" );
		
		v = v.replaceAll( "Version ", "" );
		
		return Integer.parseInt( v.split( "\\." )[0] );
	}

	private InputStream getInputStream() {
		InputStream inputStream = null;

		switch (template) {
		case DEFAULT: {
			inputStream = getClass().getResourceAsStream(
					TEMPLATE_DIR + templates[0] + EXTENSION );
			
			outputResources( 	"/"+templates[0] + "/",
								new String[] { PROVIDER_INTERFACE }
			);

			break;
		}

		}

		return inputStream;
	}



	public void setDynamicAttribute(String name, String value) {
		
		throw new BuildException(
				"The <createFont> task doesn't support the \"" + name
						+ "\" attribute.", getLocation() );
		
	}

	public void setCompiler(String compilerPath) {
		this.compilerPath = compilerPath;
	}

	public void addConfiguredFont( Font font ) {
		font.setProject( getProject() );
		fonts.add( font );
		if( font == null ) 
			throw new BuildException(
					"aieaie", getLocation());
		log( "-------------" );
		log( font.fontFamily );
		log( font.fontWeight );
		log( font.getUnicodeRange() );
	}

	public Argument createArg() {
        return getCompileTask().createArg();
    }
	
	public void setClassName(String className) {
		this.className = className;
	}


	public void setSwf(String swf) {
		// Doctor up backslashes to fix bug 193739.
		this.swf = swf.replace('\\', '/');
		File swfFile = new File( swf );
		if( ! swfFile.isAbsolute() )
			this.swf = getProject().getBaseDir().getAbsolutePath()+File.separatorChar+this.swf;
		
	}

	public void setKeepGenerated(Boolean flag) {
		this.keepGenerated = flag;
	}

	public void setTemplate(String template) {
		if (template.equals(templates[0])) {
			this.template = DEFAULT;
		} else {
			throw new BuildException(
					"The 'template' attribute must be one of '" + templates[0]
							+ "', '" + templates[0] + "', '" + templates[0]
							+ "'.", getLocation());
		}
	}



	private String substitute(String input, int fv) {
		String result = input.replaceAll("\\$\\{fptpl_package\\}", getPackage() );
		result = result.replaceAll("\\$\\{fptpl_classname\\}", getClassName() );
		result = result.replaceAll("\\$\\{fptpl_fontsDecl\\}", getFontsDecl( fv ) );
		result = result.replaceAll("\\$\\{fptpl_fontsList\\}", getFontsList() );
		
		return result;
	}
	
	private String getFontsDecl( int fv ) {
		Iterator<Font> iter = fonts.iterator();
		Font font;
		String res = "";
		while( iter.hasNext() ) {
			font = iter.next();
			res += font.getOutput( fv );
		}
		// TODO Auto-generated method stub
		return res;
	}

	private String getFontsList() {
		Iterator<Font> iter = fonts.iterator();
		Font font;
		String res = "";
		while( iter.hasNext() ) {
			font = iter.next();
			res += font.getClassName() + ",";
		}
		// TODO Auto-generated method stub
		if( res.length() == 0 ) return res;
		return res.substring( 0, res.length() - 1 );
	}

	private String getOutput() {
		File swfFile = new File( swf );
		return swfFile.getParent()+File.separatorChar+"_generated";
	}
	
	private String getFullClassName() {
		if( className != null ) return className;
		return fonts.firstElement().getClassName() + "_provider";
	}

	private String getPackage() {
		String cname = getFullClassName();
		if( cname.lastIndexOf( "." ) < 0 ) return "";
		return cname.substring( 0, cname.lastIndexOf( "." ) );
	}

	private String getClassName() {
		String cname = getFullClassName();
		return cname.substring( cname.lastIndexOf( "." )+1 );
	}

	private String getClassPath() {
		String name = getFullClassName();
		name = name.replaceAll("\\.", "/" );
		name = name+".as";
		return name;
	}
	
	private boolean deleteDirectory(File path) {
	    if( path.exists() ) {
	      File[] files = path.listFiles();
	      for(int i=0; i<files.length; i++) {
	         if(files[i].isDirectory()) {
	           deleteDirectory(files[i]);
	         }
	         else {
	           files[i].delete();
	         }
	      }
	    }
	    return( path.delete() );
	  }
	
	private ExecTask getCompileTask() {
		if( _compilTask == null )
			_compilTask = (ExecTask) getProject().createTask( "exec" );
		
		return _compilTask;
	
	}

}
