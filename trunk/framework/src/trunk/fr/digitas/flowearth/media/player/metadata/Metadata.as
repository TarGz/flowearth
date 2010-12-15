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
	
	
	/**
	 * Classe de base pour les object metadata fournis par MediaPlayer
	 * @see FlvMetadata
	 * @see SwfMetadata
	 * @author Pierre Lepers
	 */
	public class Metadata {
		
		
		public static const FLV 	: String = "flv";
		public static const SWF 	: String = "swf";
		public static const IMG 	: String = "img";
		public static const SOUND 	: String = "sound";
		
		
		public var width			:Number = 0;
		public var height			:Number = 0;
		public var framerate		:Number = 0;
		
		/**
		 * type de sous-classe de Metadata (FlvMetadata, SwfMetadata ...)
		 * @see Metadata#FLV
		 * @see Metadata#SWF
		 * @see Metadata#SOUND
		 */
		public function get type() : String {
			return _type;	
		}
		
		public function Metadata( type : String ) {
			_type = type;			
		}
		
		/**
		 * fourni un Object dynamic pour permetre de faire un for..in
		 */
		public var iterable : Object;
		
		private var _type : String;
	}
}
