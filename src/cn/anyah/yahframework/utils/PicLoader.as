package cn.anyah.yahframework.utils
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	/**
	 * @author flashhawk
	 */
	public class PicLoader extends Loader
	{
		private var _url : String;
		private var   _w : Number;
		private var   _h : Number;
		private var _isCenter : Boolean;
		private var _isExtend : Boolean;

		/**
		 *@param url 图片路径；
		 *@param w load完成后被定义的宽度
		 *@param h load完成后被定义的高度
		 *@param isCenter 图片是否在load容器中居中
		 *@param isExtend 图片是否被拉伸
		 */
		public function PicLoader()
		{
			initLsn(this.contentLoaderInfo);
		}

		public function loadPic(url : String,w : Number = -1,h : Number = -1,isCenter : Boolean = false,isExtend : Boolean = false) : void
		{
			_url = url;
			_w = w;
			_h = h;
			_isCenter = isCenter;
			_isExtend = isExtend;
			var request : URLRequest = new URLRequest(_url);
			this.load(request, new LoaderContext(true));
		}

		private function initLsn(dispatcher : IEventDispatcher) : void
		{
			with (dispatcher)
			{
				addEventListener (Event.COMPLETE, completeHandler);
				addEventListener(Event.INIT, initHandler);
				addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				addEventListener(Event.OPEN, openHandler);
			}
		}

		private function initHandler(event : Event) : void
		{
			var original_w : Number = this.width;
			var original_h : Number = this.height;
			var content : DisplayObject = this.content;
			
			if (_w > 0 && _h > 0)
			{
				var whk : Number = original_w / original_h;
				if (_isExtend)
				{
					content.width = _w;
					content.height = _h;
				}
				else
				{
					var k : Number = _w / _h;
					if (whk > k)
					{
						content.width = _w;
						content.height = _w / whk;
					}
					else
					{
						content.width = _h * whk;
						content.height = _h;
					}
				}
			}
			if (_isCenter)
			{
				content.x = -content.width / 2;
				content.y = -content.height / 2;
			}
			else
			{
				content.x = 0;
				content.y = 0;
			}
		}
		
		private function completeHandler (e:Event):void
		{
			dispatchEvent(e);
		}
		private function ioErrorHandler(e : IOErrorEvent) : void
		{
			trace("PicLoader加载出现错误,或者找不到指定的文件");
		}

		private function openHandler(event : Event) : void
		{
			//trace("PicLoader 开始加载");
		}
	}
}