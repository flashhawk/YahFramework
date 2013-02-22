package cn.anyah.yahframework.api 
{
	import cn.anyah.yahframework.core.site_internal;

	/**
	 * @author flashhawk
	 */
	public class Site 
	{
		use namespace site_internal;		
		site_internal static var impl:IMiniSite;
		public static function get api():IMiniSite
		{
			return impl;
		}
	}
}
