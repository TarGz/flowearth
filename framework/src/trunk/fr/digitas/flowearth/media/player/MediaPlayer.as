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

package fr.digitas.flowearth.media.player {
	import flash.events.TextEvent;
	import fr.digitas.flowearth.media.player.event.CuePointDataEvent;	
	import fr.digitas.flowearth.media.player.cuePoint.CuePointData;	
	
	import flash.display.Sprite;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import fr.digitas.flowearth.event.BoolEvent;
	import fr.digitas.flowearth.event.NumberEvent;
	import fr.digitas.flowearth.media.player.caption.ICaptionView;
	import fr.digitas.flowearth.media.player.controls.IMediaControls;
	import fr.digitas.flowearth.media.player.display.IMediaDisplay;
	import fr.digitas.flowearth.media.player.event.MetaDataEvent;
	import fr.digitas.flowearth.media.player.event.PlayProgressEvent;
	import fr.digitas.flowearth.media.player.loader.MediaLoader;
	import fr.digitas.flowearth.media.player.metadata.Metadata;
	import fr.digitas.flowearth.media.player.metadata.TimeInfo;
	import fr.digitas.flowearth.media.player.request.MediaRequest;	

	/**
	 * <p>dispatché lorsque le player est mis en lecture (true) ou en pause (false)</p>
	 * @see MediaPlayer#PLAY
	 */[Event(name="play", type="bi.event.BoolEvent")]
	 
	/**
	 * <p>dispatché lorsque la tete de lecture est deplacé</p>
	 * @see MediaPlayer#SEEK
	 */[Event(name="seek", type="bi.event.NumberEvent")]
	 
	/**
	 * <p>dispatché lorsque le volume est modifié.</p>
	 * @see MediaPlayer#VOLUME
	 */[Event(name="volume", type="bi.event.NumberEvent")]
	 
	/**
	 * <p>dispatché lorsque l'etat du buffer change</p>
	 * @see MediaPlayer#BUFFER
	 */[Event(name="buffer", type="bi.event.BoolEvent")]
	 
	/**
	 * <p>dispatché lors du remplissage du buffer </p>
	 * @see MediaPlayer#BUFFER_PROGRESS
	 */[Event(name="buffer_progress", type="bi.media.player.event.PlayProgressEvent")]
	 
	/**
	 * <p>dispatché pendant la progression du loading du media</p>
	 * @see MediaPlayer#LOAD_PROGRESS
	 */[Event(name="loadProgress", type="flash.events.ProgressEvent")]
	 
	/**
	 * <p>dispatché pendant la progression du loading du media</p>
	 * @see MediaPlayer#LOAD_COMPLETE
	 */[Event(name="loadComplete", type="flash.events.Event")]
	 
	/**
	 * <p>dispatche a chaque enterFrame si le media est en lecture</p>
	 * @see MediaPlayer#PLAY_PROGRESS
	 */[Event(name="playProgress", type="bi.media.player.event.PlayProgressEvent")]
	 
	/**
	 * <p>dispatche a chaque enterFrame si le media est en lecture</p>
	 * @see MediaPlayer#PLAY_COMPLETE
	 */[Event(name="playComplete", type="flash.events.Event")]
	 
	/**
	 * <p>dispatché quand les metadata du media sont dispos</p>
	 * @see MediaPlayer#METADATA
	 */[Event(name="metadata", type="bi.media.player.event.MetaDataEvent")]
	 
	/**
	 * <p>dispatché quand le loader change</p>
	 * @see MediaPlayer#LOADER_CHANGE
	 */[Event(name="loaderChange", type="flash.events.Event")]
	 
	/**
	 * <p>dispatché quand le controls change</p>
	 * @see MediaPlayer#CONTROLS_CHANGE
	 */[Event(name="controlsChange", type="flash.events.Event")]
	 
	/**
	 * <p>dispatché quand le display change</p>
	 * @see MediaPlayer#DISPLAY_CHANGE
	 */[Event(name="displayChange", type="flash.events.Event" )]
	 
	 /**
	 * <p>centralise les erreur specifiques ( catch ) de loading (IO_ERROR, HTTP_STATUS, NET_STATUS etc) et les redispatche dans un ErrorEvent global</p>
	 * @see MediaPlayer#ERROR
	 */[Event(name="playerError", type="flash.events.ErrorEvent" )]	
	 
	 /**
	 * <p>centralise les status </p>
	 * @see MediaPlayer#STATUS
	 */[Event(name="playerStatus", type="flash.events.StatusEvent" )]	
	
	/**
	 * Player de flv, swf, images...
	 * @author Pierre Lepers
	 */
	public class MediaPlayer extends Sprite {
		
		
		//_____________________________________________________________________________
		//																		 EVENTS
		
		// Controls
		public static const PLAY 			: String = "play";
		public static const SEEK 			: String = "seek";
		public static const VOLUME 			: String = "volume";
		public static const BUFFER 			: String = "buffer";
		public static const BUFFER_PROGRESS : String = "buffer_progress";
		public static const STAGE_MODE		: String = "stage_change_mode";
		
		// Loader
		public static const LOAD_COMPLETE 	: String = "loadComplete";
		public static const LOAD_PROGRESS 	: String = "loadProgress";
		public static const PLAY_COMPLETE 	: String = "playComplete";
		public static const PLAY_PROGRESS 	: String = "playProgress";
		public static const METADATA 		: String = "metadata";
		public static const CUEPOINT 		: String = "cuepoint";
		public static const ERROR 			: String = "playerError";
		public static const STATUS 			: String = "playerStatus";
		
		// internal
		public static const LOADER_CHANGE 		: String = "loaderChange";
		public static const CONTROLS_CHANGE 	: String = "controlsChange";
		public static const DISPLAY_CHANGE 		: String = "displayChange";
		
		//_____________________________________________________________________________
		//																GETTER / SETTER
		
		/**
		 * Controleur du player ( IMediaControls )
		 */
		public function get controls() : IMediaControls {
			return _controls;
		}
		
		/*** @private */
		public function set controls( ctrl : IMediaControls ) : void {
			if( _controls == ctrl ) return;
			if( _controls ) _unregisterControls( _controls ); 
			if( ctrl ) _registerControls( ctrl );
			_controls = ctrl;
			dispatchEvent( new Event( CONTROLS_CHANGE ) );
		}
		
		
		/**
		 * IMediaDisplay dans lequel est affiché le media (
		 */
		public function get display() : IMediaDisplay {
			return _display;
		}
		
		/*** @private */
		public function set display( disp : IMediaDisplay ) : void {
			if( _display == disp ) return;
			if( _display ) _unregisterDisplay( _display ); 
			if( disp ) _registerDisplay( disp );
			_display = disp;
			if( _loader ) _loader.display = disp;
			dispatchEvent( new Event( DISPLAY_CHANGE ) );
		}
		
		
		/**
		 * IMediaDisplay dans lequel est affiché le media (
		 */
		public function get caption () : ICaptionView {
			return _caption;
		}
		
		/*** @private */
		public function set caption( cap : ICaptionView ) : void {
			if( _caption == cap ) return;
			if( _caption ) _unregisterCaption( _caption ); 
			_caption = cap;
			if( _caption ) _registerCaption( cap );
		}
		
		/**
		 * fourni des information sur la progression et la durée du media en cours
		 */
		public var timeInfo : TimeInfo;
		
		/**
		 * defini le MediaLoader actuel du player
		 */
		public function get loader() : MediaLoader {
			return _loader;
		}
		
		/*** @private */
		internal function setLoader( ldr : MediaLoader, request : MediaRequest = null ) : void {
			if( _loader == ldr ) return;
			if( _loader ) _unregisterLoader( _loader ); 
			_loader = ldr;
			if( ldr ) {
				_registerLoader( ldr );
				if( _display ) _loader.display = display;
				ldr.load( request );
			}
			dispatchEvent( new Event( LOADER_CHANGE ) );
		}
		
		//_____________________________________________________________________________
		//																	CONTRUCTEUR
		
		public function MediaPlayer() {
			timeInfo = new TimeInfo( );
		}
		
		
		//_____________________________________________________________________________
		//																		 PUBLIC
		
		/**
		 * Definit le mode de lecture du player
		 */
		 public function set playMode( mode : String ) : void 
		{
			switch (mode)
			{
				case MediaPlayerPlayMode.NONE :
					autoPlay = false;
					autoRewind = false;
					loop = false;
					break;
				case MediaPlayerPlayMode.AUTOPLAY :
					autoPlay = true;
					autoRewind = false;
					loop = false;
					break;
				case MediaPlayerPlayMode.LOOP :
					autoPlay = false;
					autoRewind = true;
					loop = false;
					break;
				case MediaPlayerPlayMode.AUTOPLAY_AUTOREWIND :
					autoPlay = true;
					autoRewind = true;
					loop = false;
					break;
				case MediaPlayerPlayMode.AUTOPLAY_LOOP :
					autoPlay = true;
					autoRewind = false;
					loop = true;
					break;
				case MediaPlayerPlayMode.AUTOREWIND :
					autoPlay = false;
					autoRewind = true;
					loop = false;
					break;
			}
			
			_playMode = mode;
		}

		public function get playMode( ) : String 
		{
			return _playMode;
		}
		
		private var _playMode : String;
		
		
		/**
		 * indique si le player doit jouer le media en boucle
		 * @default false;
		 */
		public var loop : Boolean = false;
		
		
		/**
		 * indique si le player doit lancer la lecture du media automatiquement
		 * @default true;
		 */
		public var autoPlay : Boolean = true;
		
		/**
		 * indique si le player doit faire un seek(0) a la fin du stream ( cas particulier du flv  )
		 * TODO voir a l'etendre a d'autre MediaLoader
		 * @default true;
		 */
		public var autoRewind : Boolean = true;
		
		
		/**
		 * ouvre un media
		 * @param request media a jouer
		 * @see MediaRequest
		 * @see FlvRequest
		 */
		public function load( request : MediaRequest ) : void {
			_resetModel();
			var LoaderClass : Class = request.loaderClass;
			setLoader( new LoaderClass( this ) as MediaLoader, request );
			
		}		
		
		
		/**
		 * ferme le media en cours
		 */
		public function close() : void {
			setLoader( null );
		}

		
		/**
		 * ferme le loader , deconnecte les elements display et controls
		 */
		public function dispose() : void {
			setLoader( null );
			controls = null;
			display = null;
		}
		
		
		
		//_____________________________________________________________________________
		//																		  MODEL

		
		/**
		 * etat de lecture , joue ou met en pause la lecture
		 */
		public function set play( flag : Boolean ) : void {
			if( _play == flag ) return;
			_play = flag;
			dispatchEvent( new BoolEvent( PLAY, flag ) );
		}
		
		/** @private */
		public function get play( ) : Boolean {
			return _play;
		}
		
		/**
		 * volume du player , entre 0 et 1
		 * @default 1
		 */
		public function set volume (  val  :  Number ) : void {
			if( _volume == val ) return;
			_volume =  val ;
			dispatchEvent( new NumberEvent( VOLUME, _volume ) );
		}
		
		/** @private */
		public function get volume ( ) : Number {
			return _volume;
		}
		
		
		/**
		 * etat de buffering du player
		 */
		public function get buffer ( ) : Boolean {
			return _buffer;
		}
		
		
		/**
		 * object <code>Metadata</code> du media en cours
		 */
		public function get metadata ( ) : Metadata {
			return _metadata;
		}
		/**
		 * object <code>CuePointData</code> du media en cours
		 */
		public function get cuepoint( ) : CuePointData {
			return _cuepoint;
		}
		
		/**
		 * deplace la tete de lecture. le valeur doit etre comprise entre 0 et 1.
		 */
		public function seek( val : Number ) : void {
			dispatchEvent( new NumberEvent( SEEK , val ) );	
		}
		
		/**
		 * position de la tete de lecture du media, en pourcent ( valeur entre 0 et 1 )
		 */
		public function get playProgress() : Number {
			return _playProgress;	
		}
		
		/**
		 * progression du chargement du media en pourcent (valeur entre 0 et 1 )
		 */
		public function get loadProgress() : Number {
			return _loadProgress;	
		}
		
		
		/** @private */
		internal function setBuffer ( flag :  Boolean ) : void {
			if( _buffer == flag ) return;
			_buffer = flag;
			dispatchEvent( new BoolEvent( BUFFER, flag ) );
		}
		
		/** @private */
		internal function setBufferProgress ( l : Number, t : Number  ) : void {
			dispatchEvent( new PlayProgressEvent( MediaPlayer.BUFFER_PROGRESS, l, t ) );
		}
		
		/** @private */
		internal function setMetadatas ( md : Metadata ) : void {
			if( _metadata == md ) return;
			_metadata = md;
			if( md ) dispatchEvent( new MetaDataEvent( METADATA, md ) );
		}
		/** @private */
		internal function setCuePointData ( cue : CuePointData ) : void {
			if( _cuepoint == cue ) return;
			_cuepoint = cue;
			if( cue ) dispatchEvent(new CuePointDataEvent(CUEPOINT, cue));
		}
		
		/** @private */
		internal function setPlayProgress ( pos : Number, dur : Number ) : void {
			timeInfo.update(pos, dur);
			_playProgress = pos / dur;
			dispatchEvent( new PlayProgressEvent( MediaPlayer.PLAY_PROGRESS, pos, dur ) );
		}
		
		/** @private */
		internal function setLoadProgress ( l : int, t : int ) : void {
			_loadProgress = l / t;
			dispatchEvent( new ProgressEvent( MediaPlayer.LOAD_PROGRESS, false, false, l, t ) );
		}
		
		//_____________________________________________________________________________
		//																	   PRIVATES
		
		private function _resetModel() : void {
			play = true;
			_metadata 	= null;
			_cuepoint	= null;
			setPlayProgress(0, 1);
			setLoadProgress(0, 1);
		}
		
		
		private function _registerControls( ctrl : IMediaControls ) : void {
			ctrl.addEventListener( PLAY, 		_onPlay );
			ctrl.addEventListener( SEEK, 		_onSeek );
			ctrl.addEventListener( VOLUME, 		_onVolume );
			ctrl.addEventListener( STAGE_MODE, 	onStageDisplayStateChange);
			ctrl.registerPlayer( this );
		}
		
		private function _unregisterControls( ctrl : IMediaControls ) : void {
			ctrl.removeEventListener( PLAY, 		_onPlay );
			ctrl.removeEventListener( SEEK, 		_onSeek );
			ctrl.removeEventListener( VOLUME, 		_onVolume );
			ctrl.removeEventListener( STAGE_MODE, 	onStageDisplayStateChange);
			ctrl.registerPlayer( null );
		}
		
		
		private function _registerDisplay( disp : IMediaDisplay ) : void {
		}
		
		private function _unregisterDisplay( disp : IMediaDisplay ) : void {
		}


		private function _registerCaption( caption : ICaptionView ) : void {
			caption.registerPlayer( this );
		}
		
		private function _unregisterCaption( caption : ICaptionView ) : void {
			caption.registerPlayer( null );
		}
		
		
		private function _registerLoader( ldr : MediaLoader ) : void {
			ldr.addEventListener( PLAY			   	, _onPlay);
			ldr.addEventListener( BUFFER		   	, _onBuffer);
			ldr.addEventListener( BUFFER_PROGRESS  	, _onBufferProgress);
			ldr.addEventListener( METADATA		  	, _onMetadata);
			ldr.addEventListener(CUEPOINT			, _onCuePointData);
			ldr.addEventListener( PLAY_PROGRESS	   	, _onPlayProgress);
			ldr.addEventListener( PLAY_COMPLETE	   	, _onPlayComplete);
			ldr.addEventListener( LOAD_PROGRESS	   	, _onLoadProgress);
			ldr.addEventListener( LOAD_COMPLETE	   	, _onLoadComplete);
			ldr.addEventListener( ERROR			   	, _onLoadError );
			ldr.addEventListener( STATUS		   	, _onLoadStatus );
		}		
		
		
		private function _unregisterLoader( ldr : MediaLoader ) : void {
			ldr.removeEventListener( PLAY			  	, _onPlay);
			ldr.removeEventListener( BUFFER			 	, _onBuffer);
			ldr.removeEventListener( BUFFER_PROGRESS	, _onBufferProgress);
			ldr.removeEventListener( METADATA		  	, _onMetadata);
			ldr.removeEventListener( CUEPOINT		  	, _onCuePointData);
			ldr.removeEventListener( PLAY_PROGRESS	  	, _onPlayProgress);
			ldr.removeEventListener( PLAY_COMPLETE	  	, _onPlayComplete);
			ldr.removeEventListener( LOAD_PROGRESS	  	, _onLoadProgress);
			ldr.removeEventListener( LOAD_COMPLETE	  	, _onLoadComplete);
			ldr.removeEventListener( ERROR				, _onLoadError);
			ldr.removeEventListener( STATUS				, _onLoadStatus );
			ldr.dispose( );
		}
		

		
		//_____________________________________________________________________________
		//													 LOADER & CONTROLS HANDLING
		
	

		private function _onPlay( e : BoolEvent ) : void {
			play = e.flag;
		}
		
		private function _onSeek( e : NumberEvent ) : void {
			seek( e.value );
		}
		
		private function _onVolume( e : NumberEvent ) : void {
			volume = e.value;
		}

		private function _onBuffer( e : BoolEvent ) : void {
			setBuffer( e.flag );
		}
		
		private function _onBufferProgress( e : PlayProgressEvent ) : void {
			setBufferProgress( e.position, e.duration );
		}

		private function _onMetadata( e : MetaDataEvent ) : void {
			setMetadatas( e.metadata );
		}
		private function _onCuePointData( e : CuePointDataEvent ) : void {
			setCuePointData( e.cuePoint );
		}
		
		private function _onPlayProgress( e : PlayProgressEvent ) : void {
			setPlayProgress( e.position, e.duration );
		}

		private function _onPlayComplete( e : Event ) : void {
			
//			Logger.debug("flag : " + e.);

			if( !loop )
				play = false;
			
			dispatchEvent( e );
		}		
		
		private function _onLoadProgress( e : ProgressEvent ) : void {
			setLoadProgress(e.bytesLoaded, e.bytesTotal);
		}

		private function _onLoadComplete( e : Event ) : void {
			setLoadProgress(1,1);
			dispatchEvent( e );
		}

		private function _onLoadStatus( e : Event ) : void {
			dispatchEvent( e );
		}
		
		private function _onLoadError( e : ErrorEvent ) : void {
			dispatchEvent( new ErrorEvent( MediaPlayer.ERROR, false, false, e.text ) );
		}

		//_____________________________________________________________________________
		//     											  ON STAGE DISPLAY STATE CHANGE

		
		protected function onStageDisplayStateChange( e : TextEvent ) : void
		{
			/**
			 * Override requested for customization
			 */
			 
			trace(e); 
	
		}
		
		
		
		//_____________________________________________________________________________
		//																	MODEL STATE
		
		protected var _play 			: Boolean = true;
		protected var _buffer 			: Boolean;
		protected var _metadata 		: Metadata;
		protected var _cuepoint 		: CuePointData;
		protected var _volume 			: Number = 1;
		protected var _playProgress 	: Number = 0;
		protected var _loadProgress 	: Number = 0;
		
		//_____________________________________________________________________________
		//																	   ELEMENTS
		
		protected var _controls : IMediaControls;
		protected var _display 	: IMediaDisplay;
		protected var _caption 	: ICaptionView;
		protected var _loader 	: MediaLoader;
	}
}

