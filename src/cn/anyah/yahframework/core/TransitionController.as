package cn.anyah.yahframework.core 
{
	import cn.anyah.yahframework.api.IPage;
	import cn.anyah.yahframework.event.PageEvent;

	import flash.events.EventDispatcher;

	/**
	 * @author flashhawk
	 */
	public class TransitionController extends EventDispatcher 
	{
		public var nextPageID:String;
		public function TransitionController() 
		{
			super();
		}
		
		internal function pageOut(page:IPage):void
		{
			page.addEventListener(PageEvent.TRANSITION_OUT_COMPLETE, onTransitionOutComplete);
			page.transitionOut();
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_OUT));
		}

		private function onTransitionOutComplete(event : PageEvent) : void 
		{
			dispatchEvent(event.clone());
		}

		internal function pageIn(page:IPage):void
		{
			page.addEventListener(PageEvent.TRANSITION_IN_COMPLETE, onTransitionInComplete);
			page.transitionIn();
			dispatchEvent(new PageEvent(PageEvent.TRANSITION_IN));
		}

		private function onTransitionInComplete(event : PageEvent) : void 
		{
			dispatchEvent(event.clone());
		}
	}
}
