package cn.anyah.yahframework.core
{
	import flash.events.EventDispatcher;
	
	public class SiteHQListener extends EventDispatcher
	{
		public var event:String;
		public var target:Function;
		public var onlyOnce:Boolean;
		public var dispatched:Boolean;
		function SiteHQListener()
		{
			super();
		}
		
	}
}
