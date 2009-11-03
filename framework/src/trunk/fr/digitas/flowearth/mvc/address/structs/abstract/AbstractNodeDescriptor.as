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

package fr.digitas.flowearth.mvc.address.structs.abstract {
	import fr.digitas.flowearth.core.IIterator;
	import fr.digitas.flowearth.core.Iterator;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;	

	/**
	 * Basic implementation of <code>INodeDescriptor</code>
	 * 
	 * @author Pierre Lepers
	 */
	public class AbstractNodeDescriptor implements INodeDescriptor {
		
		
		public function getChilds() : IIterator {
			return new Iterator( _childs );
		}
		
		public function getId() : String {
			return _id;
		}
		
		public function getDefaultId() : String {
			return _defaultId;
		}
		
		protected var _id : String;
		
		protected var _defaultId : String;
		
		protected var _childs : Array/*INodeDescriptor*/; 
	}
}
