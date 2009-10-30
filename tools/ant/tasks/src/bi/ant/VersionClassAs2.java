package bi.ant;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.Properties;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.util.FileUtils;

public class VersionClassAs2 extends Task {

	private static final String DEFAULT_PROPERTY_NAME = "build.number";
	/** The default filename to use if no file specified. */
	private static final String DEFAULT_FILENAME = DEFAULT_PROPERTY_NAME;

	private static final FileUtils FILE_UTILS = FileUtils.getFileUtils();

	
	
	
	
	public void execute() throws BuildException {

		File savedFile = buildFile; // may be altered in validate

		validate();

		final Properties properties = loadProperties();
		buildNumber = getBuildNumber(properties);

		
		
		
		FileOutputStream output = null;
		
		try {
			
			output = new FileOutputStream(classFile);
			
			saveClass( output );
			
			output.close();
			
		} 
		catch (final IOException ioe) 
		{
	        final String message = "Error while writing " + classFile;
	
	        throw new BuildException(message, ioe);
	    }
		
		

	}

	
	private void saveClass(FileOutputStream output) throws IOException{
		PrintWriter writer  = new PrintWriter( new OutputStreamWriter( output, "UTF8" ) );
		
		writer.println("package bi {");
		writer.println(" /**");
		writer.println(" * Classe autog�n�r� par la tacheAnt du framework");
		writer.println(" * ");
		writer.println(" * @author AntTask");
		writer.println(" */");
		writer.println("class "+className+" {");
		writer.println("");
		writer.println("		static public var major : Number = "+major+";");
		writer.println("		static public var minor : Number = "+minor+";");
		writer.println("		static public var build : Number = "+buildNumber+";");
		writer.println("");
		writer.println("	}");
		writer.println("}");
		
		writer.flush ();
		
		
		
	}

	
	
	public void setMajor(int major) {
		this.major = major;
	}

	public void setMinor(int minor) {
		this.minor = minor;
	}

	public void setBuildfile(final File file) {
		buildFile = file;
	}

	public void setClassfile(final File file) {
		classFile = file;
	}

	public void setClassname(String className) {
		this.className = className;
	}

	private File buildFile;
	private File classFile;
	private int major;
	private int minor;
	private int buildNumber;
	private String className = "Version";

	private Properties loadProperties() throws BuildException {
		FileInputStream input = null;

		try {
			final Properties properties = new Properties();

			input = new FileInputStream(buildFile);
			properties.load(input);
			return properties;
		} catch (final IOException ioe) {
			throw new BuildException(ioe);
		} finally {
			if (null != input) {
				try {
					input.close();
				} catch (final IOException ioe) {
					log("error closing input stream " + ioe, Project.MSG_ERR);
				}
			}
		}
	}

	private int getBuildNumber(final Properties properties)
			throws BuildException {
		final String buildNumber = properties.getProperty(
				DEFAULT_PROPERTY_NAME, "0").trim();

		// Try parsing the line into an integer.
		try {
			return Integer.parseInt(buildNumber);
		} catch (final NumberFormatException nfe) {
			final String message = buildFile
					+ " contains a non integer build number: " + buildNumber;
			throw new BuildException(message, nfe);
		}
	}

	private void validate() throws BuildException {
		if (null == buildFile) {
			buildFile = FILE_UTILS.resolveFile(getProject().getBaseDir(),
					DEFAULT_FILENAME);
		}

		if (!buildFile.exists()) {
			try {
				FILE_UTILS.createNewFile(buildFile);
			} catch (final IOException ioe) {
				final String message = buildFile
						+ " doesn't exist and new file can't be created.";
				throw new BuildException(message, ioe);
			}
		}

		if (!buildFile.canRead()) {
			final String message = "Unable to read from " + buildFile + ".";
			throw new BuildException(message);
		}

	}
}
