package cn.anyah.yahframework.api 
{
	import cn.anyah.yahframework.api.IPage;
	
	/**
	 * @author flashhawk
	 */
	public interface ILoading extends IPage 
	{
		function set loadedRate(rate:Number):void;
	}
}
