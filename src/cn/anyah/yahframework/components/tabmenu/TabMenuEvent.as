package cn.anyah.yahframework.components.tabmenu
{
	import flash.events.Event;

	public class TabMenuEvent extends Event
	{
		public static const ITEM_ROLL_OUT : String = "itemRollOut";
		public static const ITEM_ROLL_OVER : String = "itemRollOver";
		public static const ITEM_CLICKED : String = "itemClicked";
		public static const ITEM_CHANGED : String = "itemChanged";
		public static const ALL : String = "itemMagicEvent";
		public var data : *;
		public var id : String;
		public var index : int;

		public function TabMenuEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public override function clone() : Event
		{
			var tm : TabMenuEvent = new TabMenuEvent(type, bubbles, cancelable);
			tm.data = this.data;
			tm.id = this.id;
			tm.index = this.index;
			return tm;
		}

		public override function toString() : String
		{
			return "[ TabMenuEvent type : " + type + " , id : " + id + " , index : " + index + " , data : " + data + " ]";
		}
	}
}
