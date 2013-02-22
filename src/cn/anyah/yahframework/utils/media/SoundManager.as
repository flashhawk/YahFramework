package cn.anyah.yahframework.utils.media
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;

	import com.greensock.*;
	import com.greensock.easing.*;
	import com.greensock.plugins.*;
	TweenPlugin.activate([VolumePlugin]);

	public class SoundManager
	{
		private static var _instance : SoundManager;
		private static var _isBirth : Boolean;
		private var _soundsDict : Dictionary;

		public function SoundManager()
		{
			if(!_isBirth)
			{
				_instance = this;
				_isBirth = true;
				_soundsDict = new Dictionary();
			}
			else
			{
				throw new Error("请使用单例获取");
			}
		}

		public static function birth() : SoundManager
		{
			if (_instance == null) return _instance = new SoundManager();
			return _instance;
		}

		public static function get instance() : SoundManager
		{
			if(_instance != null)return _instance;
			throw new Error("还没初始化!");
		}

		public function register($sound : Sound,$soundID : String) : void
		{
			if(_soundsDict[$soundID] )return;
			var sndObj : Object = new Object();
			sndObj.id = $soundID;
			sndObj.sound = $sound;
			sndObj.channel = new SoundChannel();
			sndObj.position = 0;
			sndObj.paused = true;
			sndObj.volume = 1;
			sndObj.startTime = 0;
			sndObj.loops = 0;
			_soundsDict[$soundID] = sndObj;
		}

		public function unRegister(soundID : String) : void
		{
			if( _soundsDict[soundID])
			{
				 _soundsDict[soundID].channel=null;
				 _soundsDict[soundID]=null;
				delete _soundsDict[soundID];
			}
		}

		public function play($soundID : String,$volume : Number = 1,$startTime : Number = 0, $loops : int = 0) : void
		{
			if( _soundsDict[$soundID] != null )
			{
				var snd : Object = this._soundsDict[$soundID];
				snd.volume=$volume;
				snd.startTime=$startTime;
				snd.loops=$loops;
				//TODO 如果播放事件音乐怎么办
				if (snd.paused)
				{
					snd.channel = snd.sound.play($startTime, $loops, new SoundTransform($volume));
					snd.paused = false;
				}
			}
			else
			{
				trace("SoundManager.play '" + $soundID + "' not exist");
			}
		}
		
		public function playOnce($soundID : String,$volume : Number = 1) : void
		{
			if( _soundsDict[$soundID] != null )
			{
				var snd : Object = this._soundsDict[$soundID];
				snd.volume=$volume;
				snd.channel = snd.sound.play(0, 0, new SoundTransform($volume));
			}
			else
			{
				trace("SoundManager.play '" + $soundID + "' not exist");
			}
		}

		public function stop($soundID : String) : void
		{
			if( _soundsDict[$soundID] != null )
			{
				var snd : Object = this._soundsDict[$soundID];
				snd.paused = true;
				snd.channel.stop();
				//snd.position = snd.channel.position;
				snd.position = 0;
			}
			else
			{
				trace("SoundManager.stop '" + $soundID + "' not exist");
			}
		}

		public function pause($soundID : String) : void
		{
			if(_soundsDict[$soundID] != null)
			{
				var snd : Object = this._soundsDict[$soundID];
				snd.paused = true;
				snd.volume= snd.channel.soundTransform.volume;
				snd.position = snd.channel.position;
				snd.channel.stop();
			}
			else
			{
				trace("SoundManager.pause '" + $soundID + "' not exist");
			}
		}
		public function resume($soundID : String):void
		{
			
			if(_soundsDict[$soundID] != null)
			{
				var snd : Object = this._soundsDict[$soundID];
				if (snd.paused)
				{
					snd.channel = snd.sound.play(snd.position, snd.loops, new SoundTransform(snd.volume));
					snd.paused = false;
				}
			}
			else
			{
				trace("SoundManager.resume '" + $soundID + "' not exist");
			}
		}
		public function pauseAll() : void
		{
			for each(var sndObj:Object in _soundsDict)
			{
				if(!sndObj.pause)
				{
					pause(sndObj.id);
				}
			}
		}

		public function muteAll() : void
		{
			for each(var sndObj:Object in _soundsDict)
			{
				setVolume(sndObj.id, 0);
			}
		}

		public function unmuteAll() : void
		{
			for each(var sndObj:Object in _soundsDict)
			{
				var snd : Object = this._soundsDict[sndObj.id];
				var curTransform : SoundTransform = snd.channel.soundTransform;
				curTransform.volume = snd.volume;
				snd.channel.soundTransform = curTransform;
			}
		}

		public function setVolume($soundID : String,$volume : Number) : void
		{
			if( _soundsDict[$soundID] != null )
			{
				var snd : Object = this._soundsDict[$soundID];
				var curTransform : SoundTransform = snd.channel.soundTransform;
				curTransform.volume = $volume;
				snd.channel.soundTransform = curTransform;
			}
			else
			{
				trace("SoundManager.setVolume '" + $soundID + "' not exist");
			}
		}

		public function stopAll() : void
		{
			for each(var sndObj:Object in _soundsDict)
			{
				stop(sndObj.id);
			}
		}
		public function fade($soundID : String, $targVolume : Number, $fadeLength : Number = 1,$onComplete:Function=null) : void
		{
			var fadeChannel : SoundChannel = _soundsDict[$soundID].channel;
			TweenLite.to(fadeChannel, $fadeLength, {volume: $targVolume,onComplete:$onComplete});
		}
		public function getVolume($soundID : String) : Number
		{
			if(_soundsDict[$soundID] != null)
			return _soundsDict[$soundID].channel.soundTransform.volume;
			trace("SoundManager.getVolume '" + $soundID + "' not exist");
			return NaN;
		}

		public function getPosition($soundID : String) : Number
		{
			if(_soundsDict[$soundID] != null)
			return this._soundsDict[$soundID].channel.position;
			trace("SoundManager.getPosition '" + $soundID + "' not exist");
			return NaN;
		}

		public function getDuration($soundID : String) : Number
		{
			if(_soundsDict[$soundID] != null)
			return _soundsDict[$soundID].sound.length;
			trace("SoundManager.getDuration '" + $soundID + "' not exist");
			return NaN;
		}

		
		public function getObject($soundID : String) : Sound
		{
			if(_soundsDict[$soundID] != null)
			return _soundsDict[$soundID].sound;
			trace("SoundManager.getObject '" + $soundID + "' not exist");
			return null;
		}
		
		//新加
		public function getSound($soundID : String) : Sound
		{
			if(_soundsDict[$soundID] != null)
			return _soundsDict[$soundID].sound;
			trace("SoundManager.getObject '" + $soundID + "' not exist");
			return null;
		}
		public function getSoundChannel($soundID : String):SoundChannel
		{
			if(_soundsDict[$soundID] != null)
			return _soundsDict[$soundID].channel;
			trace("SoundManager.getSoundChannel '" + $soundID + "' not exist");
			return null;
		}
		//********************************************************************

		public function isPaused($soundID : String) : Boolean
		{
			if(_soundsDict[$soundID] != null)
			return this._soundsDict[$soundID].paused;
			trace("SoundManager.isPaused '" + $soundID + "' not exist");
			return true;
		}

		public function get sounds() : Array
		{
			var _sounds : Array = new Array();
			for each(var sndObj:Object in _soundsDict)
			{
				_sounds.push(sndObj.sound);
			}
			return _sounds;
		}

		public function get soundIDArray() : Array
		{
			var _soundIDArray : Array = new Array();
			for (var id:String in _soundsDict)
			{
				_soundIDArray.push(id);
			}
			return _soundIDArray;
		}

		public function clear() : void
		{
			stopAll();
			_soundsDict = new Dictionary();
		}
	}
}

