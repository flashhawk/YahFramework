package cn.anyah.yahframework.core
{
	import br.com.stimuli.loading.BulkProgressEvent;

	import cn.anyah.yahframework.templates.AbstractPage;

	public class PageLoader extends LazyLoader
	{
		private static var _instance : PageLoader;
		private static var _isBirth : Boolean;
		private var _currentPageID : String = "";
		private var _gotoPageID : String = "";
	

		public function PageLoader()
		{
			if (!_isBirth) {
				_instance = this;
				super("PageLoader");
				_isBirth = true;
			} else {
				throw new Error("请使用单例获取");
			}
		}

		public static function birth() : PageLoader
		{
			if (_instance == null) return _instance = new PageLoader();
			return _instance;
		}

		public static function get instance() : PageLoader
		{
			if (_instance != null) return _instance;
			throw new Error("PageLoader 还没初始化!");
		}

		public function loadPageById(pageID : String) : void
		{
			dispose();
			_gotoPageID = pageID;
			var assetXMLUrl : String = String(SiteModel.xml.main.pages.page.(@id == pageID).@assetxml);
			var preventCache : Boolean = toBoolean(String(SiteModel.xml.main.pages.page.(@id == pageID).@preventCache));
			load(assetXMLUrl, preventCache);
		}

		override protected function onComplete(e : BulkProgressEvent) : void
		{
			super.onComplete(e);
			_currentPageID = _gotoPageID;
		}

		public function getCurrentPage() : AbstractPage
		{
			return AbstractPage(getContent("page"));
		}

		public function get getCurrentPageId() : String
		{
			return _currentPageID;
		}
	}
}