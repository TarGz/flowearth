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
	import fr.digitas.flowearth.bi_internal;
	import fr.digitas.flowearth.mvc.address.structs.INode;
	import fr.digitas.flowearth.mvc.address.structs.IPath;
	import fr.digitas.flowearth.utils.VariablesTools;
	
	import flash.net.URLVariables;
	
	use namespace bi_internal;

	/**
	 * Base class for IPath object.
	 * handle path structure manipulation.
	 * doesn't manage reference to INode
	 * 
	 * @author Pierre Lepers
	 */
	public class AbstractPath implements IPath {

		//_____________________________________________________________________________
		//															   STRING CONSTANTS
		public static const SEPARATOR : String = '/';
		public static const PARAM_SEP : String = '?';
		public static const DEVICE_SEP : String = ':';
		public static const BACK_STRING : String = '..';
		public static const REL_STRING : String = '.';

		//_____________________________________________________________________________
		//																TYPES CONSTANTS
		public static const RELATIV : int = 0x00;
		public static const ABSOLUT : int = 0x01;

		
		
		
		/** @inheritDoc */
		public function AbstractPath(  ) {
		}
		
		bi_internal function precompile( segs : Array, device : String, types : int, bcount : int, path : String = null ) : void {
			_segments = [].concat( segs );
			_device = device;
			_types = types;
			_rbackCount = bcount;
			_path = path;
			if( !_path )_normalize();
		}

		
		
		/**
		 * return the canonical form of this path
		 */
		public function toString() : String {
			var res : String = _device ? _device + DEVICE_SEP + SEPARATOR : "";
			res += _path;
			if( _params ) res += PARAM_SEP + _params.toString( );
			return res;
		}

		/** @inheritDoc */
		public function segments() : Array {
			if( ! _segments ) _segments = _buildSegments( );
			return _segments;
		}

		/** @inheritDoc */
		public function nodes(until : INode = null) : Array/*INode*/ {
			// abstract, need nodeSystem
			return null;
		}

		/** @inheritDoc */
		public function toNode() : INode {
			// abstract, need nodeSystem
			return null;
		}

		/** @inheritDoc */
		public function nodeExist() : Boolean {
			// abstract, need nodeSystem
			return false;
		}

		/** @inheritDoc */
		public function append(path : IPath) : IPath {
			// abstract, need instanciation
			return null;
		}

		/** @inheritDoc */
		public function isRoot() : Boolean {
			// abstract, need nodeSystem
			return false;
		}

		/** @inheritDoc */
		public function getPath() : String {
			return _path;
		}

		/** @inheritDoc */
		public function getDevice() : String {
			return _device;
		}

		/** @inheritDoc */
		public function getParams() : URLVariables {
			return _params;
		}

		/** @inheritDoc */
		public function clone() : IPath {
			// abstract, need instanciation
			return null;
		}

		
		/** @inheritDoc */
		public function equals( path : IPath ) : Boolean {
			if( path.isAbsolute( ) != isAbsolute( ) ) return false;
			if( path.getDevice( ) != _device ) return false;
			if( path.getPath( ) != getPath( ) ) return false;
			if( ! VariablesTools.equals( path.getParams( ) , _params ) ) return false;
			return true;
		}

		/** @inheritDoc */
		public function diff( other : IPath ) : INode {
			// TODO stub
			return null;
		}

		/** @inheritDoc */
		public function appendDefaults() : IPath {
			// TODO stub
			return null;
		}

		/** @inheritDoc */
		public function cleanup() : IPath {
			// TODO stub
			return null;
		}

		/** @inheritDoc */
		public function contain( path : IPath ) : Boolean {
			if( ! isAbsolute( ) || ! path.isAbsolute( ))
				return false;
			if( _device != path.getDevice( ) ) return false;
			
			var psegs : Array = path.segments( );
			var l : int = psegs.length;
			var sl : int = _segments.length;
			if( l<sl ) return false;
			
			while( --sl > -1 )
				if( _segments[ sl ] != psegs[ sl ] ) return false;
			
			return true;
		}

		/** @inheritDoc */
		public function isAbsolute() : Boolean {
			return ( _types & 0x01 ) == 1;
		}

		/** @inheritDoc */
		public function makeAbsolute(parent : IPath) : IPath {
			if( isAbsolute( ) ) return clone( );
			if( ! parent.isAbsolute( ) )
				throw new Error( "IPath - makeAbsolute : given parameter must be absolute given : " + parent.toString( ) );
			return parent.append( this );
		}

		/** @inheritDoc */
		public function makeRelative(parent : IPath) : IPath {
			// abstract, need instanciation
			return null;
		}

		protected function makeRelativeString(parent : IPath) : String {
			if( ! isAbsolute( ) || ! parent.isAbsolute( ))
				throw new Error( "IPath - makeRelative : both paths should be absolute." );
			
			if( _device != parent.getDevice( ) ) return null;
			
			var psegs : Array = parent.segments( );
			var l : int = psegs.length;
			var sl : int = _segments.length;
			var _p : String = REL_STRING + SEPARATOR;
			var ci : int = -1;
			
			
			
			while( ++ci < l && ci < sl && psegs[ci] == _segments[ci] ) true;
			while( -- l >= ci )	_p += BACK_STRING + SEPARATOR;
			while( ++ l < sl )	_p += _segments[l] + SEPARATOR;
			
			return _p;
		}

		
		protected function _split() : void {
			var pSplit : Array = _path.split( PARAM_SEP );
			_path = pSplit[0];
			
			if( pSplit.length > 1 ) 
				_params = new URLVariables( pSplit[1] );
			
			var dSplit : Array = pSplit[0].split( DEVICE_SEP );
			
			if( dSplit.length == 2 ) {
				_path = dSplit[1];
				_device = dSplit[0];
			}
			
			var sis : int = 0;
			var sie : int = _path.length-1;
			while( _path.charAt( sis ) == SEPARATOR ) sis++;
			while( _path.charAt( sie ) == SEPARATOR ) sie--;
			if( sie < sis ) _path = "";
			else _path = _path.substring( sis, sie+1 );
			
		}

		
		protected function _buildSegments() : Array {
			if( _path == "" ) {
				_types |= ABSOLUT;
				return [];
			}
			var a : Array = _path.split( SEPARATOR );
			var ind : int;
			_rbackCount = 0;
			
			if( a[0] != REL_STRING || _device ) {
				_types |= ABSOLUT;
			}

			while( ( ind = a.indexOf( REL_STRING ) ) > - 1 )
				a.splice( ind , 1 );
				

			while( ( ind = a.indexOf( BACK_STRING ) ) > - 1 ) {
				if( ind == 0 ) {
					_rbackCount ++;
					a.shift( );
				}
				else a.splice( ind - 1 , 2 );
			}
			
			if ( _rbackCount > 0 ) {
				_types &= RELATIV;
				if( _device != null ) 	throw new Error( " path error, device found for relative path" + toString( ) );
			}
				
			return a;
		}

		
		protected function _normalize() : void {
			_path = _segments.join( SEPARATOR );
			for (var i : int = 0; i < _rbackCount ; i ++)
				_path = BACK_STRING + SEPARATOR + _path;
			if( ! isAbsolute( ) && _rbackCount == 0 )
				_path = REL_STRING + SEPARATOR + _path;
		}
		
		protected function _checkAbsolute() : void {
			if( !isAbsolute() )
				throw new Error( "Path - the method is only implemented on absolute path" );
		}

		protected function _solve(path : String) : void {
			_path = path;
			_split( );
			_segments = _buildSegments( );
			_normalize( );
		}

		
		protected var _path : String;

		protected var _device : String;

		protected var _params : URLVariables;

		protected var _types : int = 0;
		
		protected var _segments : Array;

		bi_internal var _rbackCount : int;
	}
}
