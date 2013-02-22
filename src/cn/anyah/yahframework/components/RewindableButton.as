package cn.anyah.yahframework.components 
{
	import cn.anyah.yahframework.components.tabmenu.AbstractTabMenuItem;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;

	public class RewindableButton extends AbstractTabMenuItem 
	{
		private static const REWINDABLE_MEANS : String = "mcb";
		private static const MCB_FORWARD : int = 1;
		private static const MCB_BACKWARD : int = -1;
		private static const MCB_DEFAULT_HITAREA_NAME : String = "mcb_hitarea";
		private var _mcb_hitArea : DisplayObject = null;
		private var _mcb_enabled : Boolean = true;
		private var _mcb_dir : int = MCB_FORWARD;
		private var _mcb_listeners : Array = new Array();
		private var _mcb_over_channel : SoundChannel;
		private var _mcb_over_sound : Sound;
		private var _mcb_out_channel : SoundChannel;
		private var _mcb_out_sound : Sound;
		private var _mcb_sound_enabled:Boolean = true;

		public function RewindableButton()
		{
			stop();
			addEventListener(Event.ADDED_TO_STAGE, mcb_init);
		}

		public function mcb_addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void
		{
			mcb_addListener({type:type, listener:listener, useCapture:useCapture, priority:priority, useWeakReference:useWeakReference});
			_mcb_hitArea.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public function mcb_removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void
		{
			mcb_removeListener({type:type, listener:listener, useCapture:useCapture});
			_mcb_hitArea.removeEventListener(type, listener, useCapture);
		}

		private function mcb_addListener(lsnObj : Object) : void
		{
			_mcb_listeners.push(lsnObj);
		}

		private function mcb_removeListener(lsnObj : Object) : void
		{
			for(var i : int = 0;i < _mcb_listeners.length;i++)
			{
				var lsn : Object = _mcb_listeners[i];
				if(lsn == null)continue;
				if(lsn.type == lsnObj.type && lsn.listener == lsnObj.listener && lsn.useCapture == lsnObj.useCapture)
				{
					_mcb_listeners.splice(i, 1);
				}
			}			
		}

		private function mcb_transferListeners(area : DisplayObject) : void
		{
			var __mcb_listeners : Array = _mcb_listeners;
			for(var i : int = 0;i < __mcb_listeners.length;i++)
			{
				var lsn : Object = __mcb_listeners[i];
				area.addEventListener(lsn.type, lsn.listener, lsn.useCapture, lsn.priority, lsn.useWeekReference);
				_mcb_hitArea.removeEventListener(lsn.type, lsn.listener, lsn.useCapture);
			}
			_mcb_listeners = __mcb_listeners;
		}

		private function mcb_init(e : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, mcb_init);
			mcb_hitArea = DisplayObject(getChildByName(MCB_DEFAULT_HITAREA_NAME)) == null ? this : DisplayObject(getChildByName(MCB_DEFAULT_HITAREA_NAME));
			mcb_enabled = _mcb_enabled;
		}

		private function mcb_mouseHandler(e : MouseEvent) : void
		{
			_mcb_hitArea.removeEventListener(Event.ENTER_FRAME, mcb_render);
			switch(e.type)
			{
				case MouseEvent.ROLL_OVER:
					mcb_over(_mcb_sound_enabled);
					break;
				case MouseEvent.ROLL_OUT:
					mcb_out(_mcb_sound_enabled);
					break;				
			}
		}
		
		private function mcb_over(withSnd:Boolean=true):void
		{
			removeEventListener(Event.ENTER_FRAME, mcb_render);
			_mcb_dir = MCB_FORWARD;
			if(withSnd)
			{
				mcb_playOverSound();
				mcb_stopOutSound();
			}
			addEventListener(Event.ENTER_FRAME, mcb_render);			
		}
		
		private function mcb_out(withSnd:Boolean=true):void
		{
			removeEventListener(Event.ENTER_FRAME, mcb_render);
			_mcb_dir = MCB_BACKWARD;
			if(withSnd)
			{
				mcb_playOutSound();
				mcb_stopOverSound();
			}
			addEventListener(Event.ENTER_FRAME, mcb_render);			
		}

		private function mcb_render(e : Event) : void
		{
			gotoAndStop(currentFrame + _mcb_dir);
			switch(_mcb_dir)
			{
				case MCB_FORWARD:
					if(currentFrame == totalFrames)
						removeEventListener(Event.ENTER_FRAME, mcb_render);
					break;
				case MCB_BACKWARD:
					if(currentFrame == 1)
						removeEventListener(Event.ENTER_FRAME, mcb_render);
					break;				
			}
		}

		private function mcb_playOverSound() : void
		{
			if(_mcb_over_sound == null)return;
			if(_mcb_over_channel != null)
				_mcb_over_channel.stop();
			_mcb_over_channel = _mcb_over_sound.play();
		}

		private function mcb_stopOverSound() : void
		{
			if(_mcb_over_sound == null || _mcb_over_channel == null)return;
			_mcb_over_channel.stop();
		}
		
		private function mcb_playOutSound() : void
		{
			if(_mcb_out_sound == null)return;
			if(_mcb_out_channel != null)
				_mcb_out_channel.stop();
			_mcb_out_channel = _mcb_out_sound.play();
		}

		private function mcb_stopOutSound() : void
		{
			if(_mcb_out_sound == null || _mcb_out_channel == null)return;
			_mcb_out_channel.stop();
		}

		public function get mcb_hitArea() : DisplayObject
		{
			return _mcb_hitArea;
		}

		public function set mcb_hitArea(area : DisplayObject) : void
		{
			if(_mcb_hitArea == area)return;
			mcb_transferListeners(area);
			_mcb_hitArea = area;
		}

		public function get mcb_enabled() : Boolean
		{
			return _mcb_enabled;
		}

		public function set mcb_enabled(b : Boolean) : void
		{
			_mcb_enabled = b;
			if(_mcb_hitArea==null)return;
			Sprite(_mcb_hitArea).buttonMode = b;
			Sprite(_mcb_hitArea).mouseEnabled = b;
			Sprite(_mcb_hitArea).mouseChildren = b;
			if(_mcb_enabled)
			{
				mcb_addEventListener(MouseEvent.ROLL_OVER, mcb_mouseHandler);
				mcb_addEventListener(MouseEvent.ROLL_OUT, mcb_mouseHandler);
			}
			else
			{
				mcb_removeEventListener(MouseEvent.ROLL_OVER, mcb_mouseHandler);
				mcb_removeEventListener(MouseEvent.ROLL_OUT, mcb_mouseHandler);
			}
		}

		public function get mcb_over_sound() : Sound
		{
			return _mcb_over_sound;
		}

		public function set mcb_over_sound(snd : Sound) : void
		{
			_mcb_over_sound = snd;
		}
		
		public function get mcb_out_sound() : Sound
		{
			return _mcb_out_sound;
		}

		public function set mcb_out_sound(snd : Sound) : void
		{
			_mcb_out_sound = snd;
		}

		public function get mcb_sound_enabled():Boolean
		{
			return _mcb_sound_enabled;
		}
		
		public function set mcb_sound_enabled(b:Boolean):void
		{
			_mcb_sound_enabled = b;
		}
		
		//Override AbstractTabMenu
		
		public override function reset() : void
		{
			unlock();
			mcb_out(false);
		}

		public override  function select() : void
		{
			lock();
			mcb_over(false);
		}

		public override  function over() : void
		{
			//self over
			trace("mcb roll over");
		}

		public override  function out() : void
		{
			//self out
			trace("mcb roll out");
		}

		public override  function click() : void
		{
			//self click
			trace("mcb click");
		}

		public override  function lock() : void
		{
			mcb_enabled = false;
		}

		public override function unlock() : void
		{
			mcb_enabled = true;
		}
	}
}
