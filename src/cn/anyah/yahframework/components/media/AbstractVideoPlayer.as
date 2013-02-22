package cn.anyah.yahframework.components.media 
{
	import flash.display.Sprite;
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;

	public class AbstractVideoPlayer extends Sprite implements IVideoPlayer
	{
		protected var _ns : NetStream = null;
		protected var _nc : NetConnection = null;
		protected var _isReady : Boolean = false;
		protected var _video : Video = null;
		protected var _videoSource : String = "";
		protected var _videoWidth : int = 0;
		protected var _videoHeight : int = 0;

		public function AbstractVideoPlayer(videoFile : String,videoWidth : int,videoHeight : int)
		{
			if(videoFile == "" || videoWidth == 0 || videoHeight == 0)
				throw new Error("!");
			_videoSource = videoFile;
			_videoWidth = videoWidth;
			_videoHeight = videoHeight;
			_video = new Video();
			_video.width = _videoWidth;
			_video.height = _videoWidth;
			addChild(_video);
			addEventListener(Event.ADDED_TO_STAGE, _init);
			addEventListener(Event.REMOVED_FROM_STAGE, _remove);
		}

		private function _init(e : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, _init);
			_nc = new NetConnection();
			_nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_nc.connect(null);
		}

		private function _remove(e : Event) : void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, _remove);
			destroy();
		}

		private function netStatusHandler(event : NetStatusEvent) : void 
		{
			switch (event.info.code) 
			{
				case "NetConnection.Connect.Success":
					_ns = new NetStream(_nc);
					_ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
					_ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
					ready();
					break;
                case "NetStream.Play.StreamNotFound":
                    trace("Unable to locate video: " + _videoSource);
                    break;
			}
			netStatus(event);
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void 
		{
			securityError(event);
		}

		private function asyncErrorHandler(event : AsyncErrorEvent) : void 
		{
		}

		protected function ready() : void
		{
		}

		protected function destroy() : void
		{
		}

		protected function netStatus(e : NetStatusEvent) : void
		{
		}

		protected function securityError(e : SecurityErrorEvent) : void
		{
		}

		public function play() : void
		{
			if(!_isReady)return;
		}

		public function stop() : void
		{
			if(!_isReady)return;
		}

		public function pause() : void
		{
			if(!_isReady)return;
		}

		public function seek(ms : Number) : void
		{
			if(!_isReady)return;
		}

		public function get source() : String
		{
			return _videoSource;
		}

		public function set source(file : String) : void
		{
			_videoSource = file;
		}

		public function set videoWidth(w : int) : void
		{
			_videoWidth = w;
			_video.width = _videoWidth;
		}

		public function get videoWidth() : int
		{
			return _videoWidth;
		}

		public function set videoHeight(h : int) : void
		{
			_videoHeight = h;
			_video.height = _videoHeight;
		}

		public function get videoHeight() : int
		{
			return _videoHeight;
		}
	}
}
