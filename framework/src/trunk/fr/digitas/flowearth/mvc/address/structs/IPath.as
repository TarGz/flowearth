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
	import flash.net.URLVariables;				

	/**
	 * Object allow to target an element in a INode's structure
	 * 
	 * @author Pierre Lepers
	 */
	public interface IPath {
		
		function toString() : String;
		
		/**
		 * return an array of string corresponding to list of child nodees id's
		 * @return Array an array of string
		 */
		function segments() : Array;

		function nodes( until : INode = null ) : Array/*INode*/;

		function toNode () : INode;
		
		/**
		 * 
		 */
		function nodeExist() : Boolean;
		
		/**
		 * add given path to the end of this one and return the resulted new path.
		 * device value of this path is keep. If given path's device is ignored and will always be considered as relative ( to this one )
		 * @param path IPath the path to append 
		 * @return IPath the result of concatenation. The implementation type of the result is the same as IPath  object on which the function is called.
		 */
		function append(path : IPath) : IPath;

		function isRoot() : Boolean;
		
		/**
		 * return the canonical representation of a IPath (structure canonicalized, without device and params )
		 */
		function getPath() : String;
		
		/**
		 * return the device of this path
		 * device is used to target the root node of a node's structure n order to solve the path
		 * An absolut path without device (null value) will target the default device of a INodeSystem
		 */
		function getDevice() : String;
		
		/**
		 * return the parameters of this path. null if no parameters are defined
		 */
		function getParams() : URLVariables;
		
		/**
		 * return a copy of this path
		 */
		function clone() : IPath;

		function equals( path : IPath ) : Boolean;
		
		/**
		 * compare Two path and return the deeper common node
		 */
		function diff( other : IPath ) : INode;
		
		function appendDefaults() : IPath;
		
		function cleanup() : IPath;
		
		/**
		 * return true if this path contain the given path
		 * return false if both paths hasve not the same device and if both path aren't absolute
		 * this method don't care about existance of INodes corresponding to path
		 */
		function contain( path : IPath ) : Boolean;
		
		/**
		 * return true if path is absolut. 
		 * An absolut path can provide corresponding node in nodeSystem without ambiguity instead of an relative path
		 */
		function isAbsolute() : Boolean;
		
		/**
		 * return an absolut representation of this path using the given parameter as base path
		 * if( path is still absolute, parameter is not used and return copy of this path
		 * this method don't care about existance of INodes corresponding to path
		 * @throws Error if given param is not absolute
		 */
		function makeAbsolute( parent : IPath ) : IPath;
		
		/**
		 * return a representation of this path relative to the given param
		 * return null if paths has not common node (different devices)
		 * this method don't care about existance of INodes corresponding to path
		 * 
		 * @throws Error if path still relative
		 * @throws Error if given param is not absolute
		 */
		function makeRelative( parent : IPath ) : IPath;
		
	}
}
