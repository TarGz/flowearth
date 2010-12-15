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
	 * Contient les info de progression et de durée d'un media joué par le <code>MediaPlayer</code>.
	 * Utilisé par BasicControls pour afficher les chiffres de progression
	 * 
	 * @author Pierre Lepers
	 * @see MediaPlayer#timeInfo
	 */
	public class TimeInfo {
		
		/**
		 * Permet de customiser le formattage.
		 * defini la fonction a utiliser pour formatter les infos de progression et de durée.
		 * 
		 * @example  
		 * <listing version="3.0" > 
		 *	var timeInfo : TimeInfo = player.timeInfo;
		 *	timeInfo.formater = customFormater;
		 *	</br></br>
		 *	function customFormater( ph : uint, pm : uint, ps : uint, dh : uint, dm : uint, ds : uint ) : String {
		 *		return pm+":"+ps+"/"+dm+":"+ds;
		 *	}
		 * </listing>
		 */
		public var formater : Function;
		
		/**
		 * position de la tete de lecture, en secondes
		 */
		public function get position() : Number {
			return _position;
		}
		
		/**
		 * durée du media, en secondes
		 */
		public function get duration() : Number {
			return _duration;
		}
		
		public function TimeInfo() {
			
		}
		
		/**
		 * Renvoi la chaine formatée par le <code>formater</code>.
		 * <p> TimeInfo possede un formater par defaut <p>
		 * <listing version="3.0" > 
		 *	private function defaultFormater( ph : uint, pm : uint, ps : uint, dh : uint, dm : uint, ds : uint ) : String {
		 *		var p : String =  String( ((ph>0) ? ph+":" : "" )    +     (( pm<10 && ph>0 )? "0"+pm : pm    )    + ":" +     (( ps<10 )? "0"+ps : ps) );	
		 *		var d : String =  String( ((dh>0) ? dh+":" : "" )    +     (( dm<10 && dh>0 )? "0"+dm : dm    )    + ":" +     (( ds<10 )? "0"+ds : ds) );
		 *	
		 *		return p+" / "+d;
		 *	}
		 * </listing> 
		 * @return La chaine formatée
		 * @see TimeInfo#formater
		 */
		public function getFormattedString() : String {
			var fmt : Function = formater || defaultFormater;
			
			var ps : uint = _position % 60;
			var pm : uint = ( _position - ps ) / 60;
			var ph : uint = ( _position - ps - pm*60 ) / 3600;

			var ds : uint = _duration % 60;
			var dm : uint = ( _duration - ds ) / 60;
			var dh : uint = ( _duration - ds - dm*60 ) / 3600;
		
			return fmt( ph, pm, ps, dh, dm, ds );
		}
		
		/*** @private */
		public function update( position : Number, duration : Number ) : void {
			_position = position;
			_duration = duration;
		}
		
		private function defaultFormater( ph : uint, pm : uint, ps : uint, dh : uint, dm : uint, ds : uint ) : String {
			var p : String =  String( ((ph>0) ? ph+":" : "" )    +     (( pm<10 && ph>0 )? "0"+pm : pm    )    + ":" +     (( ps<10 )? "0"+ps : ps) );	
			var d : String =  String( ((dh>0) ? dh+":" : "" )    +     (( dm<10 && dh>0 )? "0"+dm : dm    )    + ":" +     (( ds<10 )? "0"+ds : ds) );
			
			return p+" / "+d;
		} 
		
		private var _position : Number;
		private var _duration : Number;
	}
}
