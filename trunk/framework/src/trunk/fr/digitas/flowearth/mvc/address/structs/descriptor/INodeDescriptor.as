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

package fr.digitas.flowearth.mvc.address.structs.descriptor {
	import fr.digitas.flowearth.core.IIterator;				

	/**
	 * Basic description of an INode.
	 * 
	 * @author Pierre Lepers
	 */
	public interface INodeDescriptor {

		/**
		 * return childs (INodeDescriptor) of this node
		 */
		function getChilds() : IIterator /*INodeDescriptor*/; 

		/**
		 * the id of the node
		 */
		function getId() : String;

		/**
		 * the id of the child that should be activate if no child explicitely active, null if no default id defined
		 */
		function getDefaultId() : String;
	}
}
