package cn.anyah.yahframework.api
{
	import cn.anyah.yahframework.templates.AbstractPage;

	public interface IMiniSite
	{
		function beforeGoto(target : Function, onlyOnce : Boolean = false) : void;

		function afterGoto(target : Function, onlyOnce : Boolean = false) : void;

		function beforePagePreload(target : Function, onlyOnce : Boolean = false) : void;

		function afterPagePreload(target : Function, onlyOnce : Boolean = false) : void;

		function pagePreload(target : Function, onlyOnce : Boolean = false) : void;

		function pageLoaded(target : Function, onlyOnce : Boolean = false) : void;

		function afterComplete(target : Function, onlyOnce : Boolean = false) : void;

		function beforeTransitionIn(target : Function, onlyOnce : Boolean = false) : void;

		function afterTransitionIn(target : Function, onlyOnce : Boolean = false) : void;

		function beforeTransitionOut(target : Function, onlyOnce : Boolean = false) : void;

		function afterTransitionOut(target : Function, onlyOnce : Boolean = false) : void;

		function transitionInComplete(target : Function, onlyOnce : Boolean = false) : void;

		function transitionOutComplete(target : Function, onlyOnce : Boolean = false) : void;

		function removeBeforeGoto(target : Function) : void;

		function removeAfterGoto(target : Function) : void;

		function removeBeforePagePreload(target : Function) : void;

		function removeAfterPagePreload(target : Function) : void;

		function removePagePreload(target : Function) : void;

		function removePageLoaded(target : Function) : void;

		function removeBeforeTransitionIn(target : Function) : void;

		function removeAfterTransitionIn(target : Function) : void;

		function removeBeforeTransitionOut(target : Function) : void

		function removeAfterTransitionOut(target : Function) : void;

		function removeTransitionInComplete(target : Function) : void;

		function removeTransitionOutComplete(target : Function) : void;

		function removeAfterComplete(target : Function) : void;

		function getCurrentPage() : AbstractPage;

		function getCurrentPageId() : String;
		function getGotoPageId() : String;

		function getSiteXml() : XML;

		function goto(pageID : String) : void;

		function lock() : void;

		function unlock() : void;
	}
}