package cn.anyah.yahframework.templates
{
	import cn.anyah.yahframework.api.IPage;
	import cn.anyah.yahframework.core.SiteView;
	import cn.anyah.yahframework.event.PageEvent;

	import flash.display.MovieClip;
	import flash.events.Event;

	public class AbstractPage extends MovieClip implements IPage
	{
		protected var _depth:String=SiteView.MIDDLE;
		public function AbstractPage()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
		}

		private function onAdd(event : Event) : void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		private function onRemove(event : Event) : void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onRemove);
			destory();
		}
		protected  function init() : void
		{
			
		}
		public  function destory() : void
		{
			
		}
		public function transitionIn() : void
		{
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_IN));
		}

		public function transitionOut() : void
		{
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_OUT));
		}

		public function transitionInComplete() : void
		{
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_IN_COMPLETE));
		}

		public function transitionOutComplete() : void
		{
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_OUT_COMPLETE));
		}
		
		public function get depth() : String
		{
			return _depth;
		}
	}//end AbstractPage
}