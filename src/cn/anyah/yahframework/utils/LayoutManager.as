package cn.anyah.yahframework.utils 
{
	import flash.utils.Dictionary;	
	import flash.display.DisplayObject;
	import flash.events.Event;	

	/**
	 * @author flashhawk 适用于
	 * stage.align = StageAlign.TOP_LEFT;
	   stage.scaleMode = StageScaleMode.NO_SCALE;
	   都是相对于注册点来说的,跟物体的大小没关系.
	 * $container的注册点也是在TOP_LEFT
	 * T:top;B:bottom;L:left;R:right;C:center;
	 * 可以任意组合例如:
	 * LayoutManager.autoFit(target,{align:"TL",margin:{top:0,left:0},onComplete:function,onStart:function});
	 * LayoutManager.autoFit(target,{align:"TL",margin:{top:"0.5",left:20}});
	 * LayoutManager.autoFit(target,{align:"C",margin:{x:"0.5",y:20}});
	 * LayoutManager.autoFit(target,{align:"TC",margin:{top:10,x:"0.5"}});
	 * 如果是字符传是按百分比.
	 * 特殊说明一下center;margin:{x:"0.5",y:20}}是让场景中心为原点,坐标系和flash场景坐标系一直.
	 */
	public class LayoutManager 
	{
		private static var _targetDit : Dictionary = new Dictionary();
		public static function killAutoFitOf($target : DisplayObject) : void 
		{
			if(_targetDit[$target] !== undefined) 
			{
				$target.removeEventListener(Event.ADDED_TO_STAGE, _targetDit[$target].initPlace);
				if($target.stage != null) 
				{
					$target.stage.removeEventListener(Event.RESIZE, _targetDit[$target].replace);
				}
				delete _targetDit[$target];
			}
		}

		public static function autoFit($target : DisplayObject,$vars : Object,$container : DisplayObject = null) : void 
		{
			var  removeStageListener : Function = function(e : Event):void 
			{
				$target.stage.removeEventListener(Event.RESIZE, replace);
			};
			var initPlace : Function = function(e : Event):void 
			{
				replace(null);
				$target.stage.addEventListener(Event.RESIZE, replace,false,-1);
			};
			var  replace : Function = function(e : Event):void 
			{
				var endx : Number;
				var endy : Number;
				var boundWidth : Number;
				var boundHeight : Number;
				if($container != null) 
				{
					boundWidth = $container.width;
					boundHeight = $container.height;
					/*
					if($container.width > $target.stage.stageWidth)boundWidth = $target.stage.stageWidth;
					if($container.height > $target.stage.stageHeight)boundHeight = $target.stage.stageHeight;
					*/
				} 
				else 
				{
					boundWidth = $target.stage.stageWidth;
					boundHeight = $target.stage.stageHeight;
				}
				if($vars.onStart != null) 
				{
					$vars.onStart();
				}
				//--------------start replace-------------------
				if(String($vars.align).indexOf("T") != -1) 
				{
					if($vars.margin.top is String) endy = boundHeight * Number($vars.margin.top);
					if($vars.margin.top is Number) endy = $vars.margin.top;
				}
				if(String($vars.align).indexOf("B") != -1) 
				{
					if($vars.margin.bottom is String) endy = boundHeight * (1 - Number($vars.margin.bottom));
					if($vars.margin.bottom is Number) endy = boundHeight - $vars.margin.bottom;
				}
				if(String($vars.align).indexOf("L") != -1) 
				{
					if($vars.margin.left is String) endx = boundWidth * Number($vars.margin.left);
					if($vars.margin.left is Number) endx = $vars.margin.left;
				}
				if(String($vars.align).indexOf("R") != -1) 
				{
					if($vars.margin.right is String) endx = boundWidth * (1 - Number($vars.margin.right));
					if($vars.margin.right is Number) endx = boundWidth - $vars.margin.right;
				}
				if(String($vars.align).indexOf("C") != -1) 
				{
					if($vars.margin.x is Number) endx = boundWidth*0.5 + $vars.margin.x;
					if($vars.margin.x is String) endx = boundWidth*0.5 +boundWidth*0.5*Number($vars.margin.x);
					if($vars.margin.y is Number) endy = boundHeight*0.5 + $vars.margin.y;
					if($vars.margin.y is String) endy = boundHeight*0.5 +boundHeight*0.5*Number($vars.margin.y);
				}
				if($container != null) 
				{
					$target.x = endx + $container.x;
					$target.y = endy + $container.y;
					if($container.width > $target.stage.stageWidth)$target.x = endx;
					if($container.height > $target.stage.stageHeight)$target.y = endy;
				} 
				else 
				{
					if(!isNaN(endx))$target.x = endx;
					if(!isNaN(endy))$target.y = endy;
				}
				if($vars.onComplete != null) 
				{
					$vars.onComplete();
				}
			};
			//--------------end replace-------------------
			if($target.stage != null) 
			{
				initPlace(null);
			} 
			else 
			{
				$target.addEventListener(Event.ADDED_TO_STAGE, initPlace);
			}
			$target.addEventListener(Event.REMOVED_FROM_STAGE, removeStageListener);
			
			_targetDit[$target] = {replace:replace, initPlace:initPlace};
		};
	}
}
