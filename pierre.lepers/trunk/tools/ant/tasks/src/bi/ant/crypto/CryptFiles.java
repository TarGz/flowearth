package bi.ant.crypto;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.InvalidParameterException;
import java.util.Iterator;
import java.util.Vector;

import mit.Rijndael.CBC;
import mit.Rijndael.PKCS5;

import org.apache.tools.ant.BuildException;
import org.apache.tools.ant.DirectoryScanner;
import org.apache.tools.ant.Task;
import org.apache.tools.ant.types.FileSet;

public class CryptFiles extends Task {

	private Vector filesets = new Vector();
	public byte[] _key;
	public byte[] _iv;
	public byte[] _bom;
	private File _dir;
	private boolean _useBase64 = false;
	
	
	
	
	public void setKey(String key) {
		_key = new byte[128];
		try {
			_key = key.getBytes( "UTF8" );
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void setIv(String iv) {
		this._iv = new byte[128];
		try {
			_iv = iv.getBytes( "UTF8" );
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void setBom(String bom) {
		this._bom = new byte[32];
		try {
			_bom = bom.getBytes( "UTF8" );
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void setUseBase64( boolean flag ) {
		_useBase64 = flag;
	}

	public void setDir(String dir) {
		_dir = new File( dir );
	}
	
	public void addFileset(FileSet fileset) {
		filesets.add(fileset);
	}

	protected void validate() {
		if (filesets.size() < 1)
			throw new BuildException("fileset not set");
	}
	
	public void encryptFile ( FileOutputStream output, byte[] input  ) 
														throws UnsupportedEncodingException {
															
														}
														
	
	public void execute() {
		
		
		
		System.out.println( "key : " + _key.length );
		
		validate(); // 1
		String foundLocation = null;

		for (Iterator itFSets = filesets.iterator(); itFSets.hasNext();) { // 2
			FileSet fs = (FileSet) itFSets.next();
			DirectoryScanner ds = fs.getDirectoryScanner(getProject()); // 3
			String[] includedFiles = ds.getIncludedFiles();
			for (int i = 0; i < includedFiles.length; i++) {
				
				File base = ds.getBasedir(); // 5
				File cleanFile = new File(base, includedFiles[i]);
				File cryptFile = new File(_dir, includedFiles[i] );
				System.out.println( cleanFile.getAbsolutePath() );
				System.out.println( cryptFile.getAbsolutePath() );
				
				try {
					cryptFile.createNewFile();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				FileOutputStream output = null;

				try {
					
					byte[] bytes = new byte[ (int) cleanFile.length() ]; // assume < 2gb
					RandomAccessFile raf = new RandomAccessFile( cleanFile, "r" );
					raf.readFully( bytes );
					raf.close();
					
					output = new FileOutputStream( cryptFile );
					
					encryptFile( output, bytes );

					output.close();

				} catch (final IOException ioe) {
					final String message = "Error while writing " + cleanFile;

					throw new BuildException(message, ioe);
				}

			}
		}

	}
	
	protected byte[] postEncoding( byte[] enc ) {
		
		if( _useBase64 ) {
			
			String str = Base64.encode( enc );
			
			return str.getBytes();
			
		}
		return enc;
	
	}


}
