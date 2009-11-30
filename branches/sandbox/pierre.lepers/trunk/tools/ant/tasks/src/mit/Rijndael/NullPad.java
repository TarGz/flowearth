package mit.Rijndael;

public class NullPad implements IPad {

	public byte[] doPad(byte[] in) {
		return in;
	}

	public byte[] unPad(byte[] in) {
		return in;
	}

}
