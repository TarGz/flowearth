package mit.Rijndael;

public interface IPad {
	
	byte [] doPad( byte [] in );

	byte [] unPad( byte [] in );
}
