package cn.anyah.yahframework.core
{
	import br.com.stimuli.loading.BulkProgressEvent;

	public class SitePreloader extends LazyLoader
	{
		private static var _instance : SitePreloader;
		private static var _isBirth : Boolean;
		public function SitePreloader()
		{
			if (!_isBirth) {
				_instance = this;
				super("SitePreloader");
				_isBirth = true;
			} else {
				throw new Error("请使用单例获取");
			}
		}

		public static function birth() : SitePreloader
		{
			if (_instance == null) return _instance = new SitePreloader();
			return _instance;
		}

		public static function get instance() : SitePreloader
		{
			if (_instance != null) return _instance;
			throw new Error("SitePreloader 还没初始化!");
		}

		public function preload() : void
		{
			var assetXMLUrl : String = String(SiteModel.xml.main.@assetxml);
			if (assetXMLUrl == "") {
				_instance.dispatchEvent(new BulkProgressEvent(BulkProgressEvent.COMPLETE));
				return;
			}
			var preventCache : Boolean=toBoolean(String(SiteModel.xml.main.@preventCache));
			load(assetXMLUrl, preventCache);
		}
	}
}