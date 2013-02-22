package cn.anyah.yahframework.core 
{
	import cn.anyah.yahframework.event.SiteEvent;
	import cn.anyah.yahframework.event.PageEvent;
	import cn.anyah.yahframework.templates.AbstractLoading;
	import cn.anyah.yahframework.templates.AbstractPage;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author flashhawk
	 */
	public class SiteView extends MovieClip 
	{
		public static const TOP:String = "top";
		public static const MIDDLE:String = "middle";
		public static const BOTTOM:String = "bottom";
		public static const LOADING_CONTAINER:String="loadingContainer";
		
		private static var _loading:AbstractLoading;
		private static var depths:Object;
		private static var _instance:SiteView;
		
		private var bottom:Sprite;
		private var middle:Sprite;
		private var top:Sprite;
		private var loadingContainer:Sprite;
		

		public function SiteView() 
		{
			bottom=new Sprite();
			bottom.name =BOTTOM;
			addChild(bottom);
			
			middle=new Sprite();
			middle.name =MIDDLE;
			addChild(middle);
			
			top=new Sprite();
			top.name = TOP;
			addChild(top);
			
			loadingContainer=new Sprite();
			loadingContainer.name = LOADING_CONTAINER;
			addChild(loadingContainer);
			
			depths = {};
			depths[LOADING_CONTAINER] = loadingContainer;
			depths[BOTTOM] = bottom;
			depths[MIDDLE] = middle;
			depths[TOP] =top;
			
			_instance=this;
		}
		public static function getDepthContainer(name:String):Sprite
		{
			return depths[name];
		}
		public function addPage(page : AbstractPage) : void
		{
			Sprite(depths[page.depth]).addChild(page);
		}
		
		public function addDisplayObj(obj:DisplayObject,depth:String):void
		{
			if(depths[depth]!=undefined)
			{
				Sprite(depths[depth]).addChild(obj);
			}
		}
		
		public function removeDisplayObj(obj:DisplayObject,depth:String):void
		{
			if(depths[depth]!=undefined)
			{
				Sprite(depths[depth]).removeChild(obj);
			}
		}
		public function removePage(page : AbstractPage) : void
		{
			Sprite(depths[page.depth]).removeChild(page);
		}
		public function showLoading():void
		{
			if(_loading!=null)
			{
				loadingContainer.addChild(_loading);
				_loading.addEventListener(PageEvent.TRANSITION_IN_COMPLETE, loadingInComplete);
				_loading.transitionIn();
			}else
			{
				loadingInComplete(null);
			}
		}

		private function loadingInComplete(event : PageEvent) : void
		{
			dispatchEvent(new Event(SiteEvent.LOADING_IN_COMPLETE));
		}
		public function removeLoading():void
		{
			if(_loading!=null)
			{
				_loading.addEventListener(PageEvent.TRANSITION_OUT_COMPLETE, loadingOutComplete);
				_loading.transitionOut();
				
			}else
			{
				loadingOutComplete(null);
			}
		}

		private function loadingOutComplete(event : PageEvent) : void 
		{
			if(_loading!=null)loadingContainer.removeChild(_loading);
			dispatchEvent(new Event(SiteEvent.LOADING_OUT_COMPLETE));
		}

		public static function set loading($loading : AbstractLoading) : void
		{
			_loading = $loading;
		}
		
		public static function get loading() : AbstractLoading
		{
			return _loading;
		}
		
		public static function lock():void
		{
			_instance.mouseChildren=false;
			_instance.mouseEnabled=false;
		}
		public static function unlock():void
		{
			_instance.mouseChildren=true;
			_instance.mouseEnabled=true;
		}
		
		static public function get instance() : SiteView
		{
			return _instance;
		}
	}
}