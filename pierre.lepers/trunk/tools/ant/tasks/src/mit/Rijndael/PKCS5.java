package mit.Rijndael;

public class PKCS5 implements IPad {
  public PKCS5() {};		// Static methods only

  public byte [] doPad(byte [] in) {
    int len = in.length;
    int padlen = 16 - (len % 16);
    byte [] ret = new byte [len + padlen];
    System.arraycopy(in, 0, ret, 0, len);
    for (int i = 0; i < padlen; i++) {
      ret[len+i] = (byte) padlen;
    }
    return (ret);
  }

  public byte [] unPad(byte [] in) {
    int len = in.length;
    int padlen = in[len-1];
    byte [] ret = new byte [len-padlen];
    System.arraycopy(in, 0, ret, 0, len-padlen);
    return (ret);
  }
}
