package asunit.errors {
	
	public class InvocationTargetError extends Error {
		
		public function InvocationTargetError(message:String) {
			super(message);
			name = "InvocationTargetError";
		}
	}
}