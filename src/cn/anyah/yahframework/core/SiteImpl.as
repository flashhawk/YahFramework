package cn.anyah.yahframework.core
{
	import cn.anyah.yahframework.api.IMiniSite;
	import cn.anyah.yahframework.event.SiteEvent;
	import cn.anyah.yahframework.templates.AbstractPage;

	/**
	 * @author flashhawk
	 */
	public class SiteImpl implements IMiniSite
	{
		private static var _instance : SiteImpl;
		private static var _isBirth : Boolean;

		public function SiteImpl()
		{
			if (!_isBirth)
			{
				_instance = this;
				_isBirth = true;
			}
			else
			{
				throw new Error("请使用单例获取");
			}
		}

		public static function birth() : SiteImpl
		{
			if (_instance == null) return _instance = new SiteImpl();
			return _instance;
		}

		public static function get instance() : SiteImpl
		{
			if (_instance != null) return _instance;
			throw new Error("SiteImpl 还没初始化!");
		}

		
		public function beforeGoto(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.BEFORE_GOTO, target, onlyOnce);
		}

		public function removeBeforeGoto(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.BEFORE_GOTO, target);
		}

		public function afterGoto(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.AFTER_GOTO, target, onlyOnce);
		}

		public function removeAfterGoto(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.AFTER_GOTO, target);
		}

		public function beforePagePreload(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.BEFORE_PAGE_PRELOAD, target, onlyOnce);
		}

		public function removeBeforePagePreload(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.BEFORE_PAGE_PRELOAD, target);
		}

		public function afterPagePreload(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.AFTER_PAGE_PRELOAD, target, onlyOnce);
		}

		public function removeAfterPagePreload(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.AFTER_PAGE_PRELOAD, target);
		}

		public function pagePreload(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.PAGE_PRELOAD, target, onlyOnce);
		}

		public function removePagePreload(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.PAGE_PRELOAD, target);
		}

		public function pageLoaded(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.PAGE_LOADED, target, onlyOnce);
		}

		public function removePageLoaded(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.PAGE_PRELOAD, target);
		}

		public function beforeTransitionIn(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.BEFORE_TRANSITION_IN, target, onlyOnce);
		}

		public function removeBeforeTransitionIn(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.BEFORE_TRANSITION_IN, target);
		}

		public function afterTransitionIn(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.AFTER_TRANSITION_IN, target, onlyOnce);
		}

		public function removeAfterTransitionIn(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.AFTER_TRANSITION_IN, target);
		}

		public function beforeTransitionOut(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.BEFORE_TRANSITION_OUT, target, onlyOnce);
		}

		public function removeBeforeTransitionOut(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.BEFORE_TRANSITION_OUT, target);
		}

		public function afterTransitionOut(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.AFTER_TRANSITION_OUT, target, onlyOnce);
		}

		public function removeAfterTransitionOut(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.AFTER_TRANSITION_OUT, target);
		}

		public function afterComplete(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.AFTER_COMPLETE, target, onlyOnce);
		}

		public function removeAfterComplete(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.AFTER_COMPLETE, target);
		}

		public function transitionInComplete(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.TRANSITION_IN_COMPLETE, target, onlyOnce);
		}

		public function transitionOutComplete(target : Function, onlyOnce : Boolean = false) : void
		{
			SiteHQ.instance.addListener(SiteEvent.TRANSITION_OUT_COMPLETE, target, onlyOnce);
		}

		public function removeTransitionInComplete(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.TRANSITION_IN_COMPLETE, target);
		}

		public function removeTransitionOutComplete(target : Function) : void
		{
			SiteHQ.instance.removeListener(SiteEvent.TRANSITION_OUT_COMPLETE, target);
		}

		public function getCurrentPage() : AbstractPage
		{
			return SiteController.currentPage;
		}

		public function getCurrentPageId() : String
		{
			return SiteController.currentPageId;
		}
		
		public function getGotoPageId() : String
		{
			return SiteController.gotoPageID;
		}

		public function getSiteXml() : XML
		{
			return SiteModel.xml;
		}

		public function goto(pageID : String) : void
		{
			SiteHQ.instance.goto(pageID);
		}

		public function lock() : void
		{
			SiteView.lock();
		}

		public function unlock() : void
		{
			SiteView.unlock();
		}
	}
}
