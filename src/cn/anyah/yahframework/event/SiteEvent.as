package cn.anyah.yahframework.event
{
	import flash.events.Event;

	public class SiteEvent extends Event
	{
		public static const GOTO : String = "goto";
		public static const BEFORE_GOTO : String = "beforeGoto";
		public static const AFTER_GOTO : String = "afterGoto";
		public static const BEFORE_PAGE_PRELOAD : String = "beforePagePreload";
		public static const AFTER_PAGE_PRELOAD : String = "afterPagePreload";
		public static const PAGE_PRELOAD : String = "pagePreload";
		public static const PAGE_LOADED : String = "pageLoaded";
		public static const AFTER_COMPLETE : String = "afterComplete";
		public static const BEFORE_TRANSITION_OUT : String = "beforeTransitionOut";
		public static const AFTER_TRANSITION_OUT : String = "afterTransitionOut";
		public static const BEFORE_TRANSITION_IN : String = "beforeTransitionIn";
		public static const AFTER_TRANSITION_IN : String = "afterTransitionIn";
		public static const TRANSITION_OUT_COMPLETE : String = "transitionOutComplete";
		public static const TRANSITION_IN_COMPLETE : String = "transitionInComplete";
		
		public static const LOADING_IN_COMPLETE:String="loadingInComplete";
		public static const LOADING_OUT_COMPLETE:String="loadingOutComplete";
		
		public var pageID : String;

		public function SiteEvent(type : String, bubbles : Boolean, cancelable : Boolean, pageID : String)
		{
			this.pageID = pageID;
			super(type, bubbles, cancelable);
		}

		public override function clone() : Event
		{
			return new SiteEvent(type, bubbles, cancelable, pageID);
		}

		public override function toString() : String
		{
			return formatToString("SiteEvent", "type", "bubbles", "cancelable", "eventPhase", "pageID");
		}
	}
}