package cn.anyah.yahframework.utils.net 
{
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * @author flashhawk
	 */
	public class Share 
	{
		public static function douban(url:String,title:String):void
		{
			//navigateToURL(new URLRequest("JavaScript:douban('"+url+"'"+",'"+title+"'"+")"),"_self");
			ExternalInterface.call("douban",url,encodeURI(title));
		}
		public static function renren(url:String,title:String):void
		{
			//navigateToURL(new URLRequest("JavaScript:renren('"+url+"'"+",'"+title+"'"+")"),"_self");
			ExternalInterface.call("renren",url,encodeURI(title));
		}
		public static function kaixin001(url:String,title:String):void
		{
			//navigateToURL(new URLRequest("JavaScript:kaixin001('"+url+"'"+",'"+title+"'"+")"),"_self");
			ExternalInterface.call("kaixin001",url,encodeURI(title));
		}
		public static function sina(url:String,title:String):void
		{
			//navigateToURL(new URLRequest("JavaScript:sina('"+url+"'"+",'"+title+"'"+")"),"_self");
			ExternalInterface.call("sina",url,encodeURI(title));
		}
		public static function qq(url:String):void
		{
			navigateToURL(new URLRequest("http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url="+url),"_blank");
		}
		public static function l39(url:String,title:String):void
		{
			navigateToURL(new URLRequest("http://www.139.com/share/share.php?tl=953010001&source=shareto139_youku&url="+url+"&title="+encodeURI(title)),"_blank");
		}
	}
}
