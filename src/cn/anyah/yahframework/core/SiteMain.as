package cn.anyah.yahframework.core
{
	import br.com.stimuli.loading.BulkProgressEvent;

	import cn.anyah.yahframework.api.Site;
	import cn.anyah.yahframework.event.SiteEvent;
	import cn.anyah.yahframework.utils.SWFWheel;
	import cn.anyah.yahframework.utils.net.CacheBuster;

	import flash.events.Event;

	/**
	 * @author flashhawk
	 */
	public class SiteMain extends SiteView
	{
		protected var model : SiteModel;
		protected var controller : SiteController;
		// protected var view : SiteView;
		protected var siteXMLUrl : String = "site.xml";

		public function SiteMain()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		protected function onAddedToStage(event : Event) : void
		{
			SWFWheel.initialize(stage);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			if (stage.stageWidth == 0 || stage.stageHeight == 0) addEventListener(Event.ENTER_FRAME, onWaitForWidthAndHeight);
			else {
				initSite();
				startSite();
			}
		}

		private function onWaitForWidthAndHeight(event : Event) : void
		{
			if (stage.stageWidth > 0 && stage.stageHeight > 0) {
				removeEventListener(Event.ENTER_FRAME, onWaitForWidthAndHeight);
				initSite();
				startSite();
			}
		}

		protected  function initSite() : void
		{
			SitePreloader.birth();
			SitePreloader.instance.addEventListener(BulkProgressEvent.COMPLETE, onSitePreloadComplete);
			SitePreloader.instance.addEventListener(BulkProgressEvent.PROGRESS, onSitePreload);

			CacheBuster.isOnline = (stage.loaderInfo.url.indexOf("http") == 0);
			use namespace site_internal;
			Site.impl = SiteImpl.birth();
			model = new SiteModel();
			model.addEventListener(Event.COMPLETE, onSiteModelComplete);
			// view = new SiteView();
			// addChild(view);
		}

		protected  function startSite() : void
		{
			model.load(siteXMLUrl);
		}

		protected function init() : void
		{
			controller = new SiteController(this);
			SiteHQ.birth();
			SiteHQ.instance.addEventListener(SiteEvent.GOTO, controller.onGoto);
			SitePreloader.instance.preload();
		}

		protected function onSitePreload(event : BulkProgressEvent) : void
		{
		}

		protected function onSitePreloadComplete(event : BulkProgressEvent) : void
		{
		}

		protected function onSiteModelComplete(event : Event) : void
		{
			init();
		}
	}
}
