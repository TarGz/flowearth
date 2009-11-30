package mit.Rijndael;

import java.security.*;
import java.util.Random;

public final class CBC {
	boolean doEncrypt;
	private byte[] iv;
	Object sessionkey;
	private IPad pad;

	public CBC(byte[] key, boolean doEncrypt, byte[] iv, IPad pad )
			throws InvalidKeyException {
		this.doEncrypt = doEncrypt;
		this.iv = iv;
		if( pad != null ) this.pad = pad;
		else pad = new PKCS5();
		
		sessionkey = Rijndael_Algorithm.makeKey(key);
	}

	public byte[] CBCcrypt(byte[] in) throws InvalidParameterException {

		if (iv == null) {
			throw new InvalidParameterException("null iv");
		}

		iv = (byte[]) iv.clone();
		if (doEncrypt)
			in = pad.doPad( in );

		int inlen = in.length;
		int blocks = in.length / 16;

		byte[] out = new byte[in.length];
		int i;
		int b;
		for (b = 0; b < blocks; b++) {
			if (doEncrypt) {
				for (i = 0; i < 16; i++)
					iv[i] ^= in[b * 16 + i];
				byte[] temp = Rijndael_Algorithm
						.blockEncrypt(iv, 0, sessionkey);
				System.arraycopy(temp, 0, iv, 0, 16);
				System.arraycopy(temp, 0, out, b * 16, 16);
			} else {
				byte[] temp = Rijndael_Algorithm.blockDecrypt(in, b * 16,
						sessionkey);
				for (i = 0; i < 16; i++)
					out[b * 16 + i] = (byte) (temp[i] ^ iv[i]);
				System.arraycopy(in, b * 16, iv, 0, 16);
			}
		}

		if (!doEncrypt)
			out = pad.unPad(out);

		return (out);
	}
}
