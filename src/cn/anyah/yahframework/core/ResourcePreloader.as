package cn.anyah.yahframework.core 
{

    /**
	 * ...
	 * @author FLASHHAWK
	 */
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;
	import br.com.stimuli.loading.loadingtypes.LoadingItem;

	public class ResourcePreloader extends EventDispatcher
	{
		private var _sourceList : XMLList;
		private var _bulkLoader : BulkLoader;
		private static var _instance : ResourcePreloader;
		private static var _isBirth : Boolean;

		public function ResourcePreloader(list : XMLList) 
		{
			if(!_isBirth)
			{
				_sourceList = list;
				_bulkLoader = new BulkLoader("ResourcePreloader");
				_instance = this;
				_isBirth = true;
				super();
			}
			else
			{
				throw new Error("请使用单例获取");
			}
		}

		public static function birth(list : XMLList) : ResourcePreloader
		{
			if (_instance == null) return _instance = new ResourcePreloader(list);
			return _instance;
		}

		public static function get instance() : ResourcePreloader
		{
			if(_instance != null)return _instance;
			throw new Error("ResourcePreloader 还没初始化!");
		}

		public function start() : void
		{
			for (var i : int = 0;i < _sourceList.length();i++)
			{
				var url : String = _sourceList[i].@src;
				_bulkLoader.add(url, { id:"s" + i, type:"binary"});
				_bulkLoader.get("s" + i).addEventListener(Event.COMPLETE, onItemLoaded);
				_bulkLoader.addEventListener(BulkProgressEvent.PROGRESS, onProgress);
				_bulkLoader.addEventListener(BulkLoader.ERROR, bulkLoadeError);
				_bulkLoader.addEventListener(BulkProgressEvent.COMPLETE, onAllComplete);
				trace(url + " preLoading...");
			}
			_bulkLoader.start(1);
		}

		private function bulkLoadeError(e : ErrorEvent) : void
		{
			//trace(e);
		}

		private function onProgress(e : BulkProgressEvent) : void
		{
			//trace(e._percentLoaded);
		}

		private function onAllComplete(e : BulkProgressEvent) : void
		{
			_bulkLoader.clear();
			trace("all preLoad finish");
		}

		private function onItemLoaded(e : Event) : void
		{
			var item : LoadingItem = LoadingItem(e.currentTarget);
			item.destroy();
			//_bulkLoader.remove(item.id);
			trace(item.id + " preload finish");
			//trace(e.currentTarget);
		}

		public function pause() : void
		{
			_bulkLoader.pauseAll();
			trace("pauseing");
		}

		public function resume() : void
		{
			_bulkLoader.resumeAll();
			trace("resume");
		}
	}
}
