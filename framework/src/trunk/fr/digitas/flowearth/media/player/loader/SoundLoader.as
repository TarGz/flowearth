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

package fr.digitas.flowearth.media.player.loader 
{
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.event.NumberEvent;
	import fr.digitas.flowearth.media.player.display.IMediaDisplay;
	import fr.digitas.flowearth.media.player.loader.MediaLoader;
	import fr.digitas.flowearth.media.player.MediaPlayer;
	import fr.digitas.flowearth.media.player.request.MediaRequest;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	/**
	 * Load sounds for MediaPlayer
	 * @author Romain Prache
	 */
	public class SoundLoader extends MediaLoader
	{
		/* VAR */
		private var sound 			: Sound;
		private var soundChannel	: SoundChannel;
		private var seek			: Number;
		private var st				: SoundTransform;
		
		
		/* SoundLoader */
		public function SoundLoader( player : MediaPlayer )
		{
			super( player );
			
			soundChannel = new SoundChannel();
			soundChannel.soundTransform = new SoundTransform(_player.volume);
			sound = new Sound();
			seek = 0;
		}
		
		/* Display */
		override public function set display(value:IMediaDisplay):void 
		{
			var empty : Sprite = new Sprite();
			super.display = value;
		}
		
		/* Loading & Progress */
		override public function load(req:MediaRequest):void 
		{			
			super.load(req);
			
			sound.addEventListener(Event.COMPLETE, handleComplete);
			sound.addEventListener(ProgressEvent.PROGRESS, handleProgress);
						
			sound.load(request.urlRequest);
		}
		
		private function handleProgress(e:ProgressEvent):void 
		{
			loadProgress( e.bytesLoaded, e.bytesTotal );
		}
		
		
		private function handleComplete(e:Event):void 
		{
			sound.removeEventListener(Event.COMPLETE, handleComplete);
			st = new SoundTransform(_player.volume);
			soundChannel = sound.play(0,0,st);
		}
		
		override protected function dispatchPlayProgress(e:Event):void 
		{
			super.dispatchPlayProgress(e);
			
			if ( soundChannel && sound)
			{
				playProgress(soundChannel.position / 1000, sound.length / 1000);
				seek = soundChannel.position;
				
				// complete
				if ( ( int(soundChannel.position) == int(sound.length) ) && sound.length > 0 )
				{
					sound.removeEventListener(ProgressEvent.PROGRESS, handleProgress);
					playComplete();
				}
			}
		}
		
		/* Play, Seek & Volume */
		override protected function onPlay(e:BoolEvent):void 
		{
			super.onPlay(e);
			
			trace("Play: " + e.flag);
			
			if (e.flag)
			{				
				soundChannel.stop();
				st = new SoundTransform(_player.volume);
				soundChannel = sound.play(seek, 0, st);
				
			} else {
				
				soundChannel.stop();
			}
			
		}
		
		override protected function onSeek(e:NumberEvent):void 
		{
			seek = e.value * sound.length;			
		}
		
		override protected function onVolume(e:NumberEvent):void 
		{			
			super.onVolume(e);
			_player.volume = e.value;
			soundChannel.soundTransform = new SoundTransform( e.value );
		}
		
		/* Dispose */
		override public function dispose():void 
		{
			super.dispose();
						
			soundChannel.stop();
			
			sound.removeEventListener(Event.COMPLETE, handleComplete);
			sound.removeEventListener(ProgressEvent.PROGRESS, handleProgress);
			
			soundChannel = null;
			sound = null;
		}
	}

}