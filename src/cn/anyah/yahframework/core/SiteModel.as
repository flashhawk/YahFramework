package cn.anyah.yahframework.core
{
	import cn.anyah.yahframework.utils.net.CacheBuster;


	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class SiteModel extends EventDispatcher
	{
		private static var _xml : XML;
		private var loader : URLLoader;

		public function SiteModel()
		{
			super();
		}

		public function load(path : String) : void
		{
			var request : URLRequest = new URLRequest(CacheBuster.create(path));
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, onLoadComplete);
			loader.load(request);
		}

		private function onLoadComplete(e : Event) : void
		{
			_xml = XML(e.target.data);
			parseSite();
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function parseSite() : void
		{
			
		}

		public static function get xml() : XML
		{
			return _xml;
		}
	}
}