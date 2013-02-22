package cn.anyah.yahframework.core
{
	import cn.anyah.yahframework.event.SiteEvent;

	import flash.events.EventDispatcher;

	/**
	 * @author flashhawk
	 */
	public class SiteHQ extends EventDispatcher
	{
		private var listeners : Object;
		private var uniqueID : uint = 0;
		private var gotoEventObj : Object;
		private static var _instance : SiteHQ;
		private static var _isBirth : Boolean;

		public function SiteHQ()
		{
			if (!_isBirth)
			{
				_instance = this;
				_isBirth = true;
				super();
				listeners = {};
				listeners[SiteEvent.BEFORE_GOTO] = {};
				listeners[SiteEvent.AFTER_GOTO] = {};
				listeners[SiteEvent.BEFORE_PAGE_PRELOAD] = {};
				listeners[SiteEvent.AFTER_PAGE_PRELOAD] = {};
				listeners[SiteEvent.PAGE_PRELOAD] = {};
				listeners[SiteEvent.PAGE_LOADED] = {};

				listeners[SiteEvent.BEFORE_TRANSITION_IN] = {};
				listeners[SiteEvent.AFTER_TRANSITION_IN] = {};
				listeners[SiteEvent.BEFORE_TRANSITION_OUT] = {};
				listeners[SiteEvent.AFTER_TRANSITION_OUT] = {};
				listeners[SiteEvent.TRANSITION_IN_COMPLETE] = {};
				listeners[SiteEvent.TRANSITION_OUT_COMPLETE] = {};
				listeners[SiteEvent.AFTER_COMPLETE] = {};
			}
			else
			{
				throw new Error("请使用单例获取");
			}
		}

		public static function birth() : SiteHQ
		{
			if (_instance == null) return _instance = new SiteHQ();
			return _instance;
		}

		public static function get instance() : SiteHQ
		{
			if (_instance != null) return _instance;
			throw new Error("SiteHQ 还没初始化!");
		}

		public function addListener(eventName : String, target : Function, onlyOnce : Boolean) : void
		{
			if (listeners[eventName] != null)
			{
				var listener : SiteHQListener = generateListener(eventName, target);
				listener.onlyOnce = onlyOnce;
				addEventListener(eventName, listener.target);
				return;
			}
			else
			{
				trace("SiteHQ Error! addListener: " + eventName + " is not a valid event");
				return;
			}
		}

		public function removeListener(eventName : String, target : Function) : void
		{
			if (listeners[eventName] != undefined)
			{
				for (var id:String in listeners[eventName])
				{
					if (SiteHQListener(listeners[eventName][id]).target == target)
					{
						removeListenerByID(eventName, id);
						break;
					}
				}
			}
			else
			{
				trace("SiteHQ Error! removeListener: " + eventName + " is not a valid event");
			}
		}

		// This method is the beginning of the event chain
		public function goto(pageID : String) : void
		{
			gotoEventObj = {};
			gotoEventObj.pageID = pageID;
			beforeGoto();
		}

		// GOTO BEFORE / AFTER
		public function beforeGoto() : void
		{
			onEvent(SiteEvent.BEFORE_GOTO);
		}

		public function beforeGotoDone() : void
		{
			gotoEventObj.type = SiteEvent.GOTO;
			dispatchSiteEvent();
		}

		public function afterGoto() : void
		{
			onEvent(SiteEvent.AFTER_GOTO);
		}

		public function afterGotoDone() : void
		{
		}

		// ---------------------PAGE PRELOAD---------------------------------------------
		public function beforePagePreload() : void
		{
			onEvent(SiteEvent.BEFORE_PAGE_PRELOAD);
		}

		public function beforePagePreloadDone() : void
		{
			gotoEventObj.type = SiteEvent.PAGE_PRELOAD;
			dispatchSiteEvent();
		}

		public function afterPagePreload() : void
		{
			onEvent(SiteEvent.AFTER_PAGE_PRELOAD);
		}

		public function afterPagePreloadDone() : void
		{
		}

		public function pageLoaded() : void
		{
			onEvent(SiteEvent.PAGE_LOADED);
		}

		public function pageLoadedDone() : void
		{
		}

		// -------------------	PAGE PRELOAD END------------------------------------------
		// --------------------Transition-------------------------------------------------
		public function beforeTransitionIn() : void
		{
			onEvent(SiteEvent.BEFORE_TRANSITION_IN);
		}

		public function  beforeTransitionInDone() : void
		{
		}

		public function afterTransitionIn() : void
		{
			onEvent(SiteEvent.AFTER_TRANSITION_IN);
		}

		public function afterTransitionInDone() : void
		{
		}

		public function beforeTransitionOut() : void
		{
			onEvent(SiteEvent.BEFORE_TRANSITION_OUT);
		}

		public function  beforeTransitionOutDone() : void
		{
		}

		public function afterTransitionOut() : void
		{
			onEvent(SiteEvent.AFTER_TRANSITION_IN);
		}

		public function afterTransitionOutDone() : void
		{
		}

		public function transitionInComplete() : void
		{
			onEvent(SiteEvent.TRANSITION_IN_COMPLETE);
		}

		public function transitionInCompleteDone() : void
		{
			afterComplete();
		}

		public function transitionOutComplete() : void
		{
			onEvent(SiteEvent.TRANSITION_OUT_COMPLETE);
		}

		public function transitionOutCompleteDone() : void
		{
		}

		// ---------------------Transition end---------------------------------------------
		// ---------------------AFTER COMPLETE---------------------------------------------
		public function afterComplete() : void
		{
			onEvent(SiteEvent.AFTER_COMPLETE);
		}

		public function afterCompleteDone() : void
		{
		}

		// --------------------- COMPLETE  end---------------------------------------------
		private function onEvent(eventName : String) : void
		{
			var eventHasListeners : Boolean = false;
			for (var id:String in listeners[eventName])
			{
				if (listeners[eventName][id] != null)
				{
					eventHasListeners = true;
					var listener : SiteHQListener = listeners[eventName][id];
					if (listener.onlyOnce) listener.dispatched = true;
				}
			}
			gotoEventObj.type = eventName;
			if (eventHasListeners) dispatchSiteEvent();
			this[eventName + "Done"]();
			removeOnlyOnceListeners(eventName);
		}

		private function generateListener(eventName : String, target : Function) : SiteHQListener
		{
			// prevent duplicate listeners
			for (var id:String in listeners[eventName])
			{
				if (SiteHQListener(listeners[eventName][id]).target == target)
				{
					removeEventListener(eventName, target);
					return SiteHQListener(listeners[eventName][id]);
				}
			}
			// new listener
			var listener : SiteHQListener = new SiteHQListener();
			listener.event = eventName;
			listener.target = target;
			listeners[eventName][String(++uniqueID)] = listener;
			return listener;
		}

		// REMOVES EVENT LISTENERS BY THEIR UNIQUE ID
		private function removeListenerByID(eventName : String, id : String) : void
		{
			removeEventListener(eventName, SiteHQListener(listeners[eventName][id]).target);
			delete listeners[eventName][id];
		}

		private function removeOnlyOnceListeners(eventName : String) : void
		{
			for (var id:String in listeners[eventName])
			{
				var listener : SiteHQListener = listeners[eventName][id];
				if (listener.onlyOnce && listener.dispatched) removeListenerByID(eventName, id);
			}
		}

		private function dispatchSiteEvent() : void
		{
			dispatchEvent(new SiteEvent(gotoEventObj.type, false, false, gotoEventObj.pageID));
		}
	}
}
