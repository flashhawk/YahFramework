package cn.anyah.yahframework.event
{
	import flash.events.Event;
	
	public class PageEvent extends Event
	{
		public static const TRANSITION_OUT:String = "transitionOut";
		public static const TRANSITION_IN:String = "transitionIn";
		public static const TRANSITION_OUT_COMPLETE:String = "transitionOutComplete";
		public static const TRANSITION_IN_COMPLETE:String = "transitionInComplete";
		
		public function PageEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		public override function clone():Event
		{
			return new PageEvent(type, bubbles, cancelable);
		}
		public override function toString():String
		{
			return formatToString("PageEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}