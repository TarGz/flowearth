package bi.ant.crypto;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.InvalidParameterException;

import com.sun.org.apache.xerces.internal.impl.dv.util.Base64;

import mit.Rijndael.CBC;
import mit.Rijndael.PKCS5;

public class AESCrypt extends CryptFiles {

	public void encryptFile(FileOutputStream output, byte[] input)
			throws UnsupportedEncodingException {

		try {
			CBC crypter = new CBC(_key, true, _iv, new PKCS5());
			// decrypter = new CBC( _key, false, _iv );

			output.write(_bom);
			byte[] enc = crypter.CBCcrypt(input);
			
			System.err.println(enc.length / 16);
			output.write( postEncoding( enc ) );
		} catch (InvalidParameterException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (InvalidKeyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		try {
			output.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
