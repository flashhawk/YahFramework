package cn.anyah.yahframework.core
{
	import br.com.stimuli.loading.BulkProgressEvent;

	import cn.anyah.yahframework.event.PageEvent;
	import cn.anyah.yahframework.event.SiteEvent;
	import cn.anyah.yahframework.templates.AbstractPage;

	import flash.events.Event;

	public class SiteController
	{
		private var transitionController : TransitionController;
		private var siteView : SiteView;
		private static var _currentPageID : String = "";
		private static var _gotoPageID : String = "";
		private static var _currentPage : AbstractPage;
		private static var isTransitioning : Boolean = false;
		private static var isLoading : Boolean = false;

		public function SiteController(siteView : SiteView) : void
		{
			this.siteView = siteView;
			transitionController = new TransitionController();

			SiteHQ.birth();
			PageLoader.birth();
			PageLoader.instance.addEventListener(BulkProgressEvent.PROGRESS, onLoadingPage);
			PageLoader.instance.addEventListener(BulkProgressEvent.COMPLETE, preloadComplete);

			transitionController.addEventListener(PageEvent.TRANSITION_OUT_COMPLETE, transitionOutComplete);
			transitionController.addEventListener(PageEvent.TRANSITION_IN_COMPLETE, transitionInComplete);
		}

		public function onGoto(event : SiteEvent) : void
		{
			if (isLoading || isTransitioning) return;
			_gotoPageID=event.pageID;
			if (PageLoader.instance.getCurrentPageId == "")
			{
				SiteHQ.instance.beforePagePreload();
				//PageLoader.instance.loadPageById(event.pageID);
				var loadingIncomplete:Function=function(e:Event):void
				{
					PageLoader.instance.loadPageById(event.pageID);
					SiteHQ.instance.afterPagePreload();
					siteView.removeEventListener(SiteEvent.LOADING_IN_COMPLETE, loadingIncomplete);
					loadingIncomplete=null;
				};
				siteView.addEventListener(SiteEvent.LOADING_IN_COMPLETE,loadingIncomplete);
				siteView.showLoading();
				isLoading = true;
				//SiteHQ.instance.afterPagePreload();
			}
			else
			{
				transitionController.nextPageID = event.pageID;
				SiteHQ.instance.beforeTransitionOut();
				transitionController.pageOut(PageLoader.instance.getCurrentPage());
				
				SiteHQ.instance.afterTransitionOut();
				isTransitioning = true;
			}
			SiteHQ.instance.afterGoto();
		}

		private function transitionInComplete(event : PageEvent) : void
		{
			SiteHQ.instance.transitionInComplete();
			//SiteHQ.instance.afterComplete();
			isTransitioning = false;
		}

		private function transitionOutComplete(event : PageEvent) : void
		{
			SiteHQ.instance.transitionOutComplete();
			siteView.removePage(PageLoader.instance.getCurrentPage());
			SiteHQ.instance.beforePagePreload();
			//PageLoader.instance.loadPageById(event.target.nextPageID);
			var loadingIncomplete:Function=function(e:Event):void
			{
				PageLoader.instance.loadPageById(event.target.nextPageID);
				SiteHQ.instance.afterPagePreload();
				siteView.removeEventListener(SiteEvent.LOADING_IN_COMPLETE, loadingIncomplete);
				loadingIncomplete=null;
			};
			siteView.addEventListener(SiteEvent.LOADING_IN_COMPLETE,loadingIncomplete);
			siteView.showLoading();
			isLoading = true;
			//SiteHQ.instance.afterPagePreload();
		}

		private function onLoadingPage(event : BulkProgressEvent) : void
		{
			if (SiteView.loading != null)
			{
				SiteView.loading.loadedRate = event.weightPercent;
			}
		}

		private function preloadComplete(event : BulkProgressEvent) : void
		{
			SiteHQ.instance.pageLoaded();
			siteView.addEventListener(SiteEvent.LOADING_OUT_COMPLETE, loadingOutComplete);
			siteView.removeLoading();
		}

		private function loadingOutComplete(e : Event) : void
		{
			isLoading = false;
			siteView.addPage(PageLoader.instance.getCurrentPage());
			SiteHQ.instance.beforeTransitionIn();
			transitionController.pageIn(PageLoader.instance.getCurrentPage());
			SiteHQ.instance.afterTransitionIn();
			_currentPage = PageLoader.instance.getCurrentPage();
			_currentPageID = PageLoader.instance.getCurrentPageId;
		}

		static public function get currentPageId() : String
		{
			return _currentPageID;
		}

		static public function get currentPage() : AbstractPage
		{
			return _currentPage;
		}

		static public function get gotoPageID() : String
		{
			return _gotoPageID;
		}
	}
}