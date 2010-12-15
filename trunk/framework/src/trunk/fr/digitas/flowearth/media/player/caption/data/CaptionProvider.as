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

package fr.digitas.flowearth.media.player.caption.data {

	
	/**
	 * Contient une liste de CaptionData
	 * 
	 * @author vanneaup
	 */
	public class CaptionProvider
	{

		public function CaptionProvider( captionDataArray:Array )
		{
			_captionDataArray = captionDataArray;
		}
		
		public function getCaptionByTime(time:Number) : CaptionData
		{
			_currentTime = time*1000;
			
			_captionDataArray.some(someFilter);
			return _currentCaption;
		}

		private var _captionDataArray:Array;
		private var _currentTime:int;
		private var _currentCaption : CaptionData;
		
		private function someFilter(element : CaptionData, index : int, array : Array) : Boolean
		{
			var checkValue:Boolean = _currentTime > element.beginTimeMilliSecond && _currentTime < element.endTimeMilliSecond;
			if(checkValue)_currentCaption = element;
			else _currentCaption = null;
			return checkValue;
		}
		
	}
}
