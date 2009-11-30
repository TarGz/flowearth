package bi.ant.crypto;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import pulpcore.util.crypt.ARC4;

public class ARC4Crypt extends CryptFiles {

	@Override
	public void encryptFile(FileOutputStream output, byte[] input)
			throws UnsupportedEncodingException {

		
		try {
			ARC4 crypter = new ARC4( _key );
			output.write(_bom);
			crypter.crypt(input);
			output.write(input);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}

}
