package cn.anyah.yahframework.utils.geom
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	//动态设置注册点
	public class DynamicRegistration
	{
		//需更改的注册点位置
		private var regpoint : Point;
		//更改注册的显示对象
		private var target : DisplayObject;

		function DynamicRegistration(target : DisplayObject,regpoint : Point)
		{
			this.target = target;
			this.regpoint = regpoint;
		}

		//设置显示对象的属性
		public function flush(prop : String,value : Number) : void
		{
			var mc = this.target;
			//转换为全局坐标
			var A : Point = mc.parent.globalToLocal(mc.localToGlobal(regpoint));   
			if(prop == "x" || prop == "y")
			{
				mc[prop] = value - regpoint[prop] ;   
			}
			else
			{
				mc[prop] = value;
				//执行旋转等属性后，再重新计算全局坐标
				var B : Point = mc.parent.globalToLocal(mc.localToGlobal(regpoint));
				//把注册点从B点移到A点
				mc.x += A.x - B.x;
				mc.y += A.y - B.y;
			}
		}
	}
}