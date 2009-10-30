package bi.ant;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.taskdefs.Sleep;
import org.apache.tools.ant.types.FileSet;
import org.apache.tools.ant.types.LogLevel;

public class FlashExe extends Task {

	private String exePath;

	private String opropName;

	private String epropName;

	private boolean failOnError = true;

	private boolean logError = false;
	
	private boolean logOutput = false;
	
	private long timeout = 60000L;
	
	private Vector<FileSet> filesets;

	public FlashExe() {
		filesets = new Vector<FileSet>();
		flasList = new ArrayList<String>();
	}

	public void setExepath ( String exepath ) {
		exePath = exepath;
	}

	public void addFileset ( FileSet fileset ) {
		filesets.add(fileset);
	}
	
	/**
	 * name of ant property filled with flash IDE output
	 * 
	 * @param propName
	 */
	public void setOutputProp ( String propName ) {
		this.opropName = propName;
	}

	public void setErrorProp ( String propName ) {
		this.epropName = propName;
	}

	public void setFailonerror ( boolean flag ) {
		failOnError = flag;
	}

	public void setLogerror ( boolean flag ) {
		logError = flag;
	}

	public void setLogoutput ( boolean flag ) {
		logOutput = flag;
	}

	@Override
	public void execute () throws BuildException {

		if (filesets.size() == 0)
			throw new BuildException("No files to compile");

		if (exePath == null)
			exePath = getProject().getProperty("FLASH_EXE");

		if (exePath == null)
			throw new BuildException(
					"You should specify exepath attribute or define a property called FLASH_EXE");

		buildList();
		runList();

	}

	private void buildList () {

		for (int i = 0; i < filesets.size(); i++) {
			FileSet fs = (FileSet) filesets.elementAt(i);
			DirectoryScanner ds = fs.getDirectoryScanner(getProject());
			File fromDir = fs.getDir(getProject());
			String srcFiles[] = ds.getIncludedFiles();

			for (int j = 0; j < srcFiles.length; j++) {
				File src = new File(fromDir, srcFiles[i]);
				flasList.add(src.getAbsolutePath());
			}

		}

	}

	private void runList () {

		try {
			for (Iterator<String> it = flasList.iterator(); it.hasNext();) {
				String fromFile = (String) it.next();
				File output = File.createTempFile("flash_output", ".txt");
				File errors = File.createTempFile("flash_errors", ".txt");
				output.delete();
				errors.delete();
				File jsflFile = File.createTempFile("flash_exe", ".jsfl");
				FileWriter jsflWriter = new FileWriter(jsflFile);
				
				writeJsfl( new PrintWriter( jsflWriter ) , fromFile, output.getAbsolutePath(), errors.getAbsolutePath() );
				
				jsflWriter.close();
				
				
				Runtime rt = Runtime.getRuntime();
				String[] cmds = new String[2];
				cmds[0] = exePath;
				cmds[1] = jsflFile.getAbsolutePath();
				
				Process process = rt.exec( cmds );
				
					
				long t = System.currentTimeMillis();
				while (!output.exists() && !errors.exists()) {
					Sleep sleepTask = new Sleep();
					sleepTask.doSleep( 100L );
					if (System.currentTimeMillis() - t >  timeout )
						throw new BuildException("timeout end");
				}
				String result = "";
				String execOutput = "";
				BufferedReader br = new BufferedReader(new FileReader(output));

				
				while ((execOutput = br.readLine()) != null)
					result = (new StringBuilder(String.valueOf(result)))
							.append(
									(new String(execOutput.getBytes(), "UTF-8"))
											.toString()).append("\n")
							.toString();
				br.close();
				
				String eresult = "";
				String eexecOutput = "";
				BufferedReader ebr = new BufferedReader(new FileReader(errors));
				
				int numError = 0;
				int numWarning = 0;
				
				while ((eexecOutput = ebr.readLine()) != null) {
					if( eexecOutput.startsWith( "**Warning**" ) )
						numWarning += 1;
					if( eexecOutput.startsWith( "**Error**" ) )
						numError += 1;
					eresult = (new StringBuilder(String.valueOf(eresult)))
							.append(
									(new String(eexecOutput.getBytes(), "UTF-8"))
											.toString()).append("\n")
							.toString();
				}
				
				ebr.close();
				
				if( opropName != null )
					getProject().setProperty( opropName, result );

				if( epropName != null )
					getProject().setProperty( epropName, eresult );

				if( logOutput )
					log( result , LogLevel.INFO.getLevel() );

				if( logError )
					log( eresult , LogLevel.ERR.getLevel() );
				
				
				if (numError > 0) {
					if (failOnError)
						throw new BuildException( eresult );
				}
				
				output.delete();
				errors.delete();
				jsflFile.delete();
			}

		} catch (Exception e) {
			throw new BuildException(e.getMessage());
		}

	}
	
	private void writeJsfl( PrintWriter writer, String flapath, String outputpath, String errorspath ) {
		
		
		InputStream inputStream = getClass().getResourceAsStream( "/templates/flashexe.tpl.jsfl" );

		if (inputStream != null) {
			BufferedReader bufferedReader = null;

			try {
				bufferedReader = new BufferedReader(new InputStreamReader(
						inputStream));
				

				String line;

				while ((line = bufferedReader.readLine()) != null) {
					
					line = line.replaceAll("\\$\\{flapath\\}", flapath.replace( '\\', '/'));
					line = line.replaceAll("\\$\\{outputpath\\}", outputpath.replace( '\\', '/'));
					line = line.replaceAll("\\$\\{errorspath\\}", errorspath.replace( '\\', '/'));
					
					writer.println( line );
				}
			} catch (IOException ioException) {
				System.err.println("Error outputting resource : ");
				ioException.printStackTrace();
			} finally {
				try {
					bufferedReader.close();
					writer.close();
				} catch (Exception exception) {
				}
			}
		} else {
			throw new BuildException( "template introuvable /includes/templates/flashexe.tpl.jsfl" );
		}
	}

	private List<String> flasList;
}
