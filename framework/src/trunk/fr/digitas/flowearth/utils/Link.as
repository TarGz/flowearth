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




package fr.digitas.flowearth.utils {
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.Path;

	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.navigateToURL;

	/**
	 * @author Pierre Lepers
	 */
	public class Link {

		public var target : String = "_blank";

		public function get type () : String {
			return _type;
		}

		public function get src () : String {
			return _src;
		}

		public function get label () : String {
			return _label;
		}

		/**
		 * if Link type is internal, return the corresponding node. return null for other types.
		 * @return INode the node corresponding to the internal link.
		 */
		public function get node () : INode {
			if( _type == INT )
				return new Path( src, params ).toNode( );
			return null;
		}

		/**
		 * Provide simple way to navigate into pages
		 * 
		 * links defined in xml datas has the given format :
		 * <pre>
		 * 		&lt;link type="int|ext" target="_blank|_self|_parent|..."&gt;url&lt;/link&gt;
		 * 		<link type="int">
		 *			<src><![CDATA[]]></src>
		 *			<text><![CDATA[]]></text>
		 *		</link>
		 * </pre>
		 * 
		 * type describe the kind of link
		 * - int : internal navigation into site tree , no html page reload, only swfAdress and internal flash SiteTree is modified
		 * - ext : a classic url navigation
		 * 
		 * target
		 * 	used only with ext type, classic html link target default value is '_blank'
		 * 	
		 * src : 
		 * 	-if int, site tree path description (node's ids separated by '/'
		 * 	-if ext, classic url
		 */
		public function Link ( desc : XML ) {
			_parse( desc );
		}

		/**
		 * not implemented yet for internal link
		 */
		public function get params () : URLVariables {
			return _params;
		}

		/**
		 * not implemented yet for internal links
		 */
		public function set params (params : URLVariables) : void {
			_params = params;
		}

		
		public function navigate () : void {
			
			
			if( _type == EXT ) {
				var req : URLRequest = new URLRequest( src );
				req.data = _params;
				navigateToURL( req, target );
			} 
			else if( _type == INT ) {
				var path : Path = new Path( src, params );
				path.toNode( ).activate( path.getParams() );
			} else {
				throw new ArgumentError( "fr.digitas.flowearth.utils.Link 'type' value is not valid : " + _type );
			}
		}

		
		private function _parse ( desc : XML ) : void {
			_type = desc.@type;
			target = desc.@target;
			_src = desc.src.text( );
			if( desc.label.length( ) > 0 )
				_label = desc.label.text( );

			if( _src == "" )
				throw new ArgumentError( "fr.digitas.flowearth.utils.Link 'src' node must be defined in xml format" );
		}

		private var _type : String;

		private var _src : String;

		private var _label : String;

		private var _params : URLVariables;

		public static const INT : String = "int";
		public static const EXT : String = "ext";
	}
}
