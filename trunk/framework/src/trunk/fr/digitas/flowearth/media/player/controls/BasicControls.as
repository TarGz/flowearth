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

package fr.digitas.flowearth.media.player.controls {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.event.NumberEvent;
	import fr.digitas.flowearth.ui.controls.SeekBar;
	import fr.digitas.flowearth.ui.controls.SimpleButton;
	import fr.digitas.flowearth.ui.controls.Slider;
	import fr.digitas.flowearth.ui.controls.ToggleButton;
	import fr.digitas.flowearth.ui.text.Label;
	
	import fr.digitas.flowearth.media.player.MediaPlayer;
	import fr.digitas.flowearth.media.player.controls.MediaControls;
	import fr.digitas.flowearth.media.player.event.PlayProgressEvent;

	
	/**
	 * Bar de control basique pour le <code>MediaPlayer</code>, avec des elements de controls facultatifs
	 * 
	 * @author Pierre Lepers
	 */
	public class BasicControls extends MediaControls {
		
		
		//_____________________________________________________________________________
		//																	   ELEMENTS
		
		public var background : Sprite;
		
		/**
		 * boutton play/pause du control @see ToggleButton
		 */
		public function get playButton() : ToggleButton {
			return _playButton;
		}
		/** @private */
		public function set playButton( pb : ToggleButton ) : void {
			if( _playButton ) _playButton.removeEventListener( ToggleButton.TOGGLE, onTogglePlay );
			_playButton = pb;
			if( _playButton ) _playButton.addEventListener( ToggleButton.TOGGLE, onTogglePlay );
		}
		
		/**
		 * boutton rewind du control ( seek la video à 0 ) @see SimpleButton
		 */
		public function get rewindButton() : SimpleButton {
			return _rewindButton;
		}
		/** @private */
		public function set rewindButton( rw : SimpleButton ) : void {
			if( _rewindButton ) _rewindButton.removeEventListener( MouseEvent.CLICK, onRewind );
			_rewindButton = rw;
			if( _rewindButton ) _rewindButton.addEventListener( MouseEvent.CLICK, onRewind );
		}
		
		/**
		 * SeekBar du control @see SeekBar
		 */
		public function get seekbar ( ) :  SeekBar {
			return _seekbar;
		}
		/** @private */
		public function set seekbar ( sb : SeekBar ) : void {
			if( _seekbar ) {
				_seekbar.removeEventListener( Event.CHANGE, onSeek );
				_seekbar.removeEventListener( Slider.STOP_SLIDE, onStopSeek );
				_seekbar.removeEventListener( Slider.START_SLIDE, onStartSeek );
			}
			_seekbar = sb;
			if( _seekbar ) _seekbar.addEventListener( Slider.START_SLIDE, onStartSeek );
		}
		
		/**
		 * slider de volume @see Slider
		 */
		public function get volumebar() : Slider {
			return _volumebar;
		}
		/** @private */
		public function set volumebar( vb : Slider ) : void {
			if( _volumebar ) _volumebar.removeEventListener( Event.CHANGE, onVolume );
			_volumebar = vb;
			if( _volumebar ) _volumebar.addEventListener( Event.CHANGE, onVolume );
		}
		
		
		/**
		 * bouton mute @see ToggleButton
		 */
		public function get volumeButton() : ToggleButton {
			return _volumeButton;
		}
		/** @private */
		public function set volumeButton( vb : ToggleButton ) : void {
			if( _volumeButton ) _volumeButton.removeEventListener( ToggleButton.TOGGLE, onMute );
			_volumeButton = vb;
			if( _volumeButton ) _volumeButton.addEventListener( ToggleButton.TOGGLE, onMute);
		}
		
		/**
		 * time info
		 */
		
		public function get timeInfoView () : Label {
			return _timeInfoView;
		}

		public function set timeInfoView (tiv : Label) : void {
			_timeInfoView = tiv;
		}

		
		/**
		 * FullScreen Button
		 */
		
		public function get fullscreenButton() : ToggleButton {
			return _fullScreenButton;
		}
		/** @private */
		public function set fullscreenButton( fs : ToggleButton ) : void {
			if( _fullScreenButton ) _fullScreenButton.removeEventListener( ToggleButton.TOGGLE, onStageModeChange );
			_fullScreenButton = fs;
			if( _fullScreenButton ) _fullScreenButton.addEventListener( ToggleButton.TOGGLE, onStageModeChange );
		}
		
		
		
		//_____________________________________________________________________________
		//																   CONSTRUCTEUR
		
		public function BasicControls() {
			super( );
		}
		
		//_____________________________________________________________________________
		//																	UI Handlers
		
		protected function onTogglePlay( e : BoolEvent ) : void {
			playing( e.flag );
		}
		
		protected function onRewind( e : MouseEvent ) : void {
			seek(0);
		}
		
		protected function onMute( e : BoolEvent ) : void {
			if( _registeredPlayer != null ) if( _registeredPlayer.volume != 0 ) _mutedVolume = _registeredPlayer.volume;
//			if( e.flag &&  _registeredPlayer != null ) if( _registeredPlayer.volume != 0 ) _mutedVolume = _registeredPlayer.volume;
			setVolume( e.flag ? 0 : _mutedVolume );
		}
		
		protected function onSeek( e : NumberEvent ) : void {
			seek( e.value );
		}
		
		protected function onVolume( e : NumberEvent ) : void {
			setVolume( e.value );
		}
		
		protected function onStartSeek( e : Event ) : void {
			if( _registeredPlayer )_postSeekPlayState = _registeredPlayer.play;
			playing( false );
			if( _seekbar ) _seekbar.addEventListener( Event.CHANGE, onSeek );
			if( _seekbar ) _seekbar.addEventListener( Slider.STOP_SLIDE, onStopSeek );
			if( _registeredPlayer ) _registeredPlayer.removeEventListener( MediaPlayer.PLAY_PROGRESS, onPlayProgress );
		}		
		
		protected function onStopSeek( e : Event ) : void {
			playing( _postSeekPlayState );
			if( _seekbar ) _seekbar.removeEventListener( Event.CHANGE, onSeek );
			if( _seekbar ) _seekbar.removeEventListener( Slider.STOP_SLIDE, onStopSeek );
			if( _registeredPlayer ) _registeredPlayer.addEventListener( MediaPlayer.PLAY_PROGRESS, onPlayProgress );
		}
		
		protected function onStageModeChange( e : Event ) : void
		{
			stageChangeMode();
		}
		
		
		//_____________________________________________________________________________
		//																		   INIT
		
		override public function registerPlayer(player : MediaPlayer ) : void {
			if( _registeredPlayer ){
				_registeredPlayer.removeEventListener( MediaPlayer.PLAY				, onPlay );
				_registeredPlayer.removeEventListener( MediaPlayer.BUFFER			, onBuffer );
				_registeredPlayer.removeEventListener( MediaPlayer.PLAY_PROGRESS	, onPlayProgress );
				_registeredPlayer.removeEventListener( MediaPlayer.LOAD_PROGRESS	, onLoadProgress );
				_registeredPlayer.removeEventListener( MediaPlayer.LOAD_COMPLETE	, onLoadComplete );
				_registeredPlayer.removeEventListener( MediaPlayer.VOLUME			, onVolumeChange );
				reset();
			}
			_registeredPlayer = player;
			if( player ) {
				initialize( player );
				player.addEventListener( MediaPlayer.PLAY			, onPlay );
				player.addEventListener( MediaPlayer.BUFFER			, onBuffer );
				player.addEventListener( MediaPlayer.PLAY_PROGRESS	, onPlayProgress );
				player.addEventListener( MediaPlayer.LOAD_PROGRESS	, onLoadProgress );
				player.addEventListener( MediaPlayer.LOAD_COMPLETE	, onLoadComplete );
				player.addEventListener( MediaPlayer.VOLUME			, onVolumeChange );
			}
		}
				

		private function initialize(player : MediaPlayer) : void {
			_mutedVolume = ( player.volume != 0 ) ? player.volume : .75 ;
			if( _playButton ) 	playButton.toggled = player.play;
			if( _seekbar )	{
				seekbar.loadProgress = player.loadProgress;
				seekbar.playProgress = player.playProgress;
				seekbar.setBuffer( player.buffer );
			}
			if( _volumebar )	volumebar.value = player.volume;
			if( _volumeButton ) volumeButton.toggled = (player.volume == 0);
		}

		private function reset() : void {
			if( _playButton ) 	playButton.toggled = false;
			if( _seekbar )	{
				seekbar.playProgress = 0;
				seekbar.loadProgress = 0;
				seekbar.setBuffer( false );
			}
		}
		
		//_____________________________________________________________________________
		//														  PLAYER MODEL HANDLING
		
		protected function onPlay( e : BoolEvent ) : void {
			if( _playButton ) _playButton.toggled = e.flag;
		}

		protected function onBuffer( e : BoolEvent ) : void {
			if( _seekbar ) _seekbar.setBuffer( e.flag );
		}
		
		protected function onVolumeChange( event : NumberEvent ) : void {
			if( _volumebar )	volumebar.value = _registeredPlayer.volume;
			if( _volumeButton ) volumeButton.toggled = (_registeredPlayer.volume == 0);
		}
		
		protected function onPlayProgress( e : PlayProgressEvent ) : void {
			if( _seekbar ) _seekbar.playProgress = e.position/e.duration;
			if( _timeInfoView ) _timeInfoView.text = _registeredPlayer.timeInfo.getFormattedString();
		}
		
		protected function onLoadProgress( e : ProgressEvent ) : void {
			if( _seekbar ) _seekbar.loadProgress = e.bytesLoaded/e.bytesTotal ;
		}
		
		protected function onLoadComplete( e : Event ) : void {
			if( _seekbar ) _seekbar.loadProgress = 1;
		}
		
		
		//_____________________________________________________________________________
		//																	UI ELEMENTS
		protected var _playButton		: ToggleButton;
		protected var _rewindButton 	: SimpleButton;
		protected var _volumeButton		: ToggleButton;
		protected var _fullScreenButton	: ToggleButton;
		protected var _timeInfoView 	: Label;
		protected var _seekbar 			: SeekBar;
		protected var _volumebar 		: Slider;
		
		
		protected var _registeredPlayer : MediaPlayer;
		
		protected var _mutedVolume : Number;
		protected var _postSeekPlayState : Boolean;
	}
}
