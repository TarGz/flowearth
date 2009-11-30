package flash.utils {

	public class Proxy extends Object {

		flash_proxy function deleteProperty(name) : Boolean {
			return true;
		}

		flash_proxy function isAttribute(name) : Boolean {
			return true;
		}

		flash_proxy function callProperty(...name) {
		}

		flash_proxy function nextNameIndex(index : int) : int {
			return 0;
		}

		flash_proxy function nextName(index : int) : String {
			return null;
		}

		flash_proxy function getDescendants(name) {
		}

		flash_proxy function getProperty(name) {
		}

		flash_proxy function nextValue(index : int) {
		}

		flash_proxy function setProperty(name, value) : void {
		}

		flash_proxy function hasProperty(name) : Boolean {
			return true;
		}
	}
	
	public namespace flash_proxy = "http://www.adobe.com/2006/actionscript/flash/proxy";
}
