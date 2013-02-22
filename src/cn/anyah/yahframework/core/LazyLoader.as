package cn.anyah.yahframework.core
{
	import br.com.stimuli.loading.BulkLoader;
	import br.com.stimuli.loading.BulkProgressEvent;

	import flash.events.ErrorEvent;
	import flash.system.LoaderContext;

	public class LazyLoader extends BulkLoader
	{
		public static  const INT_TYPES : Array = ["maxTries", "priority"];
		public static  const NUMBER_TYPES : Array = ["weigth"];
		public static  const STRINGED_BOOLEAN : Array = ["preventCache", "pausedAtStart", "checkPolicyFile"];

		public function LazyLoader(name : String = null, numConnections : int = 12, logLevel : int = 4)
		{
			super(name, numConnections, logLevel);
		}

		protected function load(XMLUrl : String, preventCache : Boolean) : void
		{
			//var movieclipContext : LoaderContext = new LoaderContext(true, ApplicationDomain.currentDomain);
			var imageContext : LoaderContext = new LoaderContext(true);
			//var soundContext : SoundLoaderContext = new SoundLoaderContext();
			var tempLoader : BulkLoader = new BulkLoader("temp");
			tempLoader.add(XMLUrl, {id:"assetxml", type:"xml", preventCache:preventCache});
			var assetXmlComplete : Function = function(e : BulkProgressEvent) : void
			{
				var assetXml : XML = tempLoader.getXML("assetxml", true);
				var asset : XMLList = assetXml.asset;
				for (var i : int;i < asset.length();i++) {
					var obj : Object = new Object();
					var attNamesList : XMLList = XMLList(asset[i]).attributes();
					var attName : String;
					for (var j : int = 0; j < attNamesList.length(); j++)
					 {
						attName = String(attNamesList[j].name());
						if (INT_TYPES.indexOf(attName) > 1) {
							obj[attName] = int(String(attNamesList[j]));
						} else if (NUMBER_TYPES.indexOf(attName) > -1) {
							obj[attName] = Number(String(attNamesList[j]));
						} else if (STRINGED_BOOLEAN.indexOf(attName) > -1) {
							obj[attName] = toBoolean(String(attNamesList[j]));
						} else {
							obj[attName] = String(attNamesList[j]);
						}

						if (obj["type"] == BulkLoader.TYPE_IMAGE&&obj["checkPolicyFile"])
							obj[BulkLoader.CONTEXT] = imageContext;
						/*
						if (obj["type"] == BulkLoader.TYPE_MOVIECLIP)
							obj[BulkLoader.CONTEXT] = movieclipContext;
							 * 
							 */
					}
					add(String(asset[i].@src), obj);
				}
				tempLoader.clear();
				tempLoader = null;
				addEventListener(BulkLoader.ERROR, bulkLoadeError);
				addEventListener(BulkProgressEvent.COMPLETE, onComplete, false, 999);
				start();
			};
			tempLoader.addEventListener(BulkProgressEvent.COMPLETE, assetXmlComplete);
			tempLoader.start();
		}

		protected function onComplete(e : BulkProgressEvent) : void
		{
			removeEventListener(BulkLoader.ERROR, bulkLoadeError);
			removeEventListener(BulkProgressEvent.COMPLETE, onComplete);
		}

		protected function bulkLoadeError(e : ErrorEvent) : void
		{
			trace("LoaderBase load error" + e);
		}

		public function dispose() : void
		{
			this.removeAll();
		}

		public static function toBoolean(value : String) : Boolean
		{
			if (value == "true" || value == "1" || value == "yes") {
				return true;
			}
			return false;
		}
	}
}