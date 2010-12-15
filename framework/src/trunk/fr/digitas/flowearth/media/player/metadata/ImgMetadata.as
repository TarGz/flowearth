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

package fr.digitas.flowearth.media.player.metadata {
	import flash.display.LoaderInfo;
	import flash.system.ApplicationDomain;
	
	import fr.digitas.flowearth.media.player.metadata.Metadata;	

	
	/**
	 * @author Pierre Lepers
	 */
	public class ImgMetadata extends Metadata {
		
		public var actionScriptVersion 	: uint;
		public var applicationDomain 	: ApplicationDomain;
		public var sameDomain 			: Boolean;
		public var parentAllowsChild 	: Boolean;
		public var childAllowsParent 	: Boolean;
		public var contentType 			: String;
		
		
		public function ImgMetadata() {
			super( Metadata.IMG );
			iterable = new Object();
			
		}
		
		public function fill( li : LoaderInfo ) : Boolean {
			try {
				width 				= li.width;
				height 				= li.height;
				applicationDomain 	= li.applicationDomain;
				sameDomain 			= li.sameDomain;
				parentAllowsChild 	= li.parentAllowsChild;
				childAllowsParent 	= li.childAllowsParent;
				contentType 		= li.contentType;
				
				iterable.width 					= width;
				iterable.height 				= height;
				iterable.frameRate 				= framerate;
				iterable.actionScriptVersion 	= actionScriptVersion;
				iterable.applicationDomain 		= applicationDomain;
				iterable.sameDomain 			= sameDomain;
				iterable.parentAllowsChild 		= parentAllowsChild;
				iterable.childAllowsParent 		= childAllowsParent;
				iterable.contentType 			= contentType;
				
				return true;
			}
			catch( e : Error ) {
				return false;
			}
			return true;
		}
	}
}
