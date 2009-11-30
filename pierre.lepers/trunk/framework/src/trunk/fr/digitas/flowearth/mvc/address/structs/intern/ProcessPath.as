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

package fr.digitas.flowearth.mvc.address.structs.intern {
	import fr.digitas.flowearth.core.IDisposable;	
	import fr.digitas.flowearth.mvc.address.structs.INodeSystem;
	import fr.digitas.flowearth.mvc.address.structs.Path;	

	/**
	 * Path running in specific <code>INodeSystem</code>
	 * internal use
	 * 
	 * if relative, treated as a Path object
	 * if absolute, root node solved with given specific system 
	 * 
	 * @author Pierre Lepers
	 */
	public class ProcessPath extends Path implements IDisposable {

		public function ProcessPath( system : INodeSystem, path : String = "/" ) {
			super( path );
			_system = system;
		}
		
		public function dispose() : void {
			_system = null;
		}
		
	}
	
}
