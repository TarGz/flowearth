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
	import fr.digitas.flowearth.media.player.metadata.Metadata;			

	
	/**
	 * Contient les meta d'un flv loadé par FlvLoader (MediaPlayer)
	 * @see MediaPlayer#metadata
	 * @see FlvLoader
	 * @author Pierre Lepers
	 */
	dynamic public class FlvMetadata extends Metadata {
		
		
		
		public var canSeekToEnd		:Boolean;
		public var audiocodecid		:Number;
		public var audiodelay		:Number;
		public var audiodatarate	:Number;
		public var videocodecid		:Number;
		public var videodatarate	:Number;
		public var duration			:Number;
		
		
		public function FlvMetadata( infoObject : Object ) {
			super( Metadata.FLV );

			canSeekToEnd 	= infoObject.canSeekToEnd;
			audiocodecid 	= infoObject.audiocodecid;
			audiodelay 		= infoObject.audiodelay;
			audiodatarate 	= infoObject.audiodatarate;
			videocodecid 	= infoObject.videocodecid;
			videodatarate 	= infoObject.videodatarate;
			framerate 		= infoObject.framerate;
			width 			= infoObject.width;
			height 			= infoObject.height;
			duration 		= infoObject.duration;
			
			iterable = infoObject;
		}
		
		public function toString() : String {
			var res : String = "";
			res += "canSeekToEnd --> " 	+ canSeekToEnd 	+ "\n";	
			res += "audiocodecid --> " 	+ audiocodecid 	+ "\n";	
			res += "audiodelay --> " 	+ audiodelay 	+ "\n";	
			res += "audiodatarate --> " + audiodatarate + "\n";	
			res += "videocodecid --> " 	+ videocodecid 	+ "\n";	
			res += "framerate --> " 	+ framerate 	+ "\n";	
			res += "videodatarate --> " + videodatarate + "\n";	
			res += "height --> " 		+ height 		+ "\n";	
			res += "width --> " 		+ width 		+ "\n";	
			res += "duration --> " 		+ duration;
			return res;
		}
		
		
		
	}
}

















