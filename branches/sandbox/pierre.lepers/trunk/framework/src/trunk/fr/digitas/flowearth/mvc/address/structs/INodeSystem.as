/* ***** BEGIN LICENSE BLOCK *****
 * Copyright (C) 2007-2009 Digitas France
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * The Initial Developer of the Original Code is
 * Digitas France Flash Team
 *
 * Contributor(s):
 *   Digitas France Flash Team
 *
 * ***** END LICENSE BLOCK ***** */

package fr.digitas.flowearth.mvc.address.structs {

	/**
	 * Store a list of node considered as device ( root nodes of node's trees )
	 * Used by IPath to solve reference to a node
	 * 
	 * @author Pierre Lepers
	 */
	public interface INodeSystem {
		
		/**
		 * return the corresponding to the given device id
		 * return the default device if null is passed as parameter
		 * return null if the device id doesn't exist
		 */
		function getDevice( device : String = null ) : INode;

		/**
		 * check if a node exist for the given id
		 */
		function hasDevice( device : String ) : Boolean;
		
		/**
		 * return the path to use for solve relative path ("./a/b")
		 */
		function getDefaultPath() : IPath;
		
		/**
		 * device to use if no device provided in a IPath ("/a/b")
		 */
		function getDefaultDevice() : INode;
		
	}
}
