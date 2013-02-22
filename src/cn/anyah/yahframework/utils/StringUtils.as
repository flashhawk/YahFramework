package cn.anyah.yahframework.utils
{
	/**
	 * @author flashhawk
	 */
	public class StringUtils
	{
		//去掉首尾空格
		public static function trimStr(str:String):String
		{
			return str.replace(/(^\s*)|(\s*$)/g,'');
		}
		
		
		//判断是否超过140个汉字
		public static var weiboInputLimite:int=280;
		public static function checkIput(str:String):Boolean
		{
			if(cnLength(str)>weiboInputLimite)
			{
				return false;
			}
			return true;
		}
		public static function cnLength(str:String):int
		{
			return str.replace(/[^\x00-\xff]/g, "xx").length;
		}
		public static function replaceSpace(str:String):String
		{
			return str.replace(/[\s*]+/g,'');
		}
		
		public static function countInput(str:String):int
		{
			return int((weiboInputLimite-cnLength(str))/2);
		}
		
	}
	
}
