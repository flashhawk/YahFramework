package cn.anyah.yahframework.components 
{
	import flash.events.MouseEvent;

	import cn.anyah.yahframework.components.tabmenu.AbstractTabMenuItem;

	import flash.display.FrameLabel;
	import flash.events.Event;

	public class FrameStatedButton extends AbstractTabMenuItem 
	{
		public static const UP : String = "upState";
		public static const OVER : String = "overState";
		public static const SELECTED : String = "selectedState";
		private static const FRAME_UP : String = "_up";
		private static const FRAME_OVER : String = "_over";
		private static const FRAME_SELECTED : String = "_selected";
		private static var FRAME_UP_NUM : int = 1;
		private static var FRAME_OVER_NUM : int = 2;
		private static var FRAME_SELECTED_NUM : int = 3;
		private var _ratioMode:Boolean = false;
		private var _selected : Boolean = false;

		public function FrameStatedButton()
		{
			stop();
			mouseChildren = false;
			addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			if(totalFrames < 3)
				throw new Error("帧数不合法，应该大于等于3帧");
			var labels : Array = currentLabels;
			if(labels.length > 0 && labels.length < 3)
			{
				throw new Error("帧标签不合法，应该大于等于3个帧标签");
			}
			else
			{
				for (var i : uint = 0;i < labels.length;i++) 
				{
					var label : FrameLabel = labels[i];
					if(label.name == FRAME_UP)
						FRAME_UP_NUM = label.frame;
					if(label.name == FRAME_OVER)
						FRAME_OVER_NUM = label.frame;
					if(label.name == FRAME_SELECTED)
						FRAME_SELECTED_NUM = label.frame;	
				}
			}
			if(!isLocked)
			{
				buttonMode = true;
				mouseEnabled = true;
				addLsn();
			}
		}

		private function addLsn() : void
		{
			addEventListener(MouseEvent.ROLL_OVER, _roll_over);
			addEventListener(MouseEvent.ROLL_OUT, _roll_out);
			addEventListener(MouseEvent.CLICK, _click);		
		}

		private function removeLsn() : void
		{
			removeEventListener(MouseEvent.ROLL_OVER, _roll_over);
			removeEventListener(MouseEvent.ROLL_OUT, _roll_out);
			removeEventListener(MouseEvent.CLICK, _click);
		}

		public function goSelected() : void
		{
			_selected = true;
			gotoAndStop(FRAME_SELECTED_NUM);
			dispatchEvent(new Event(SELECTED));
		}

		public function goUp() : void
		{
			_selected = false;
			gotoAndStop(FRAME_UP_NUM);		
			dispatchEvent(new Event(UP));		
		}

		public function goOver() : void
		{
			gotoAndStop(FRAME_OVER_NUM);
			dispatchEvent(new Event(OVER));	
		}

		private function _click(event : MouseEvent) : void 
		{
			if(!_ratioMode)return;
			if(_selected)
				goUp();
			else
				goSelected();
		}

		private function _roll_out(event : MouseEvent) : void 
		{
			if(_selected)return;
			goUp();
		}

		private function _roll_over(event : MouseEvent) : void 
		{
			if(_selected)return;
			goOver();
		}
		
		public function get selected() : Boolean
		{
			return _selected;
		}

		//Override AbstractTabMenuItem
		
		public override function reset() : void
		{
			unlock();
			goUp();
		}

		public override  function select() : void
		{
			lock();
			goSelected();
		}

		public override  function lock() : void
		{
			super.lock();
			mouseChildren = mouseEnabled = buttonMode = false;
			removeLsn();
		}

		public override function unlock() : void
		{
			super.unlock();
			mouseChildren = mouseEnabled = buttonMode = true;
			addLsn();
		}

		public function get ratioMode() : Boolean
		{
			return _ratioMode;
		}

		public function set ratioMode(rm : Boolean) : void
		{
			_ratioMode = rm;
		}
		
	}
}
