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

package fr.digitas.flowearth.media.player.loader {
	import flash.utils.Dictionary;	
	
	import fr.digitas.flowearth.media.player.loader.FlvLoader;
	
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;	

	public dynamic class ProxyClient extends Proxy {
		
		
		public function ProxyClient( loader : FlvLoader ) {
			_loader = loader;
			_dHandlers = new Dictionary( );
			defaultHandler = _defaultHandler;
		}

		public function addHandler( name : String, callBack : Function ) : void {
			_dHandlers[ name ] = callBack;
		}
		
		public var defaultHandler : Function;
		
		public function _defaultHandler( infoObj : Object ) : void {
			
		}
		
		override flash_proxy function callProperty( methodName : *, ... args ) : * {
			trace( "fr.digitas.flowearth.media.player.loader.ProxyClient - callProperty -- ", methodName, args );
			if( ! _loader.hasOwnProperty( methodName ) ) return;
	        if( ! ( _loader[ methodName ] is Function ) ) return;
			return _loader[ methodName ].apply( _loader, args );
		}

		override flash_proxy function getProperty(name : *) : * {
	        if( ! _loader.hasOwnProperty( name ) ) {
				if( _dHandlers[ name ] != undefined ) return _dHandlers[ name ];
				return defaultHandler as Object;
			}
			return _loader[name];
		}

		override flash_proxy function setProperty(name : *, value : *) : void {
	        if( ! _loader.hasOwnProperty( name ) ) return;
			_loader[name] = value;
		}

		internal function dispose() : void {
			_loader = null;
		}
		
		
		private var _loader : FlvLoader;

		private var _dHandlers : Dictionary;

	}
}
