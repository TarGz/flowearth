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


package fr.digitas.flowearth.mvc.address.struct {
	import fr.digitas.flowearth.mvc.address.structs.abstract.AbstractNodeDescriptor;
	import fr.digitas.flowearth.mvc.address.structs.descriptor.INodeDescriptor;						

	/**
	 * @author Pierre Lepers
	 */
	public class BaseDescriptor extends AbstractNodeDescriptor {

		
		public function BaseDescriptor( datas : XML ) {
			_parse( datas );
		}
		
		private function _parse(datas : XML) : void {
			_childs = new Array/*INodeDescriptor*/( );
			
			if( datas == null ) return;
			
			_id = datas.@id;
			
			if( datas.@default.length() )
				_defaultId = datas.@default;

			
			for each ( var nodeData : XML in datas.node )
				_childs.push( new BaseDescriptor( nodeData ) );
		}
		
		
		public function setId( id : String ) : void {
			_id = id;
		}

		public function setDefaultId( id : String ) : void {
			_defaultId = id;
		}
		
		public function getChildsArray() : Array {
			return _childs;	
		}
		
		INodeDescriptor;
		
	}
}
