/*****************************************************************************************************
* Gaia Framework for Adobe Flash ©2007-2009
* Author: Steven Sacks
*
* blog: http://www.stevensacks.net/
* forum: http://www.gaiaflashframework.com/forum/
* wiki: http://www.gaiaflashframework.com/wiki/
* 
* By using the Gaia Framework, you agree to keep the above contact information in the source code.
* 
* Gaia Framework for Adobe Flash is released under the GPL License:
* http://www.opensource.org/licenses/gpl-2.0.php 
*****************************************************************************************************/

package cn.anyah.yahframework.debug
{
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import flash.system.Security;
	
	public class Debug
	{	
		//XXX:Fixed to give debugger a switch.
		public static const DEBUG:int = 1;
		public static const SILENCE:int = 0;
		public static var STATUS:int = DEBUG;
		public static var isBrowser:Boolean = (Capabilities.playerType == "ActiveX" || Capabilities.playerType == "PlugIn");
		public static var isConsole:Boolean = ExternalInterface.available && (Security.sandboxType == "remote" || Security.sandboxType == "localTrusted");
		
		public static function log(...args):void
		{
			//XXX:Fixed to give debugger a switch.
			if(STATUS==SILENCE)return;
			try
			{
				MonsterDebugger.trace(Debug, args.join(", "));
				if (isBrowser && isConsole) ExternalInterface.call("console.log" , args);
			}
			catch (error:Error)
			{
				//
			}
			trace.apply(null, args);
		}
		public static function error(...args):void
		{
			//XXX:Fixed to give debugger a switch.
			if(STATUS==SILENCE)return;
			try
			{
				MonsterDebugger.trace(Debug, args.join(", "), 0xCC0000);
				if (isBrowser && isConsole) ExternalInterface.call("console.error" , args);
			}
			catch (error:Error)
			{
				//
			}
			trace.apply(null, args);
		}
		public static function warn(...args):void
		{
			//XXX:Fixed to give debugger a switch.
			if(STATUS==SILENCE)return;
			try
			{
				MonsterDebugger.trace(Debug, args.join(", "), 0xFF8800);
				if (isBrowser && isConsole) ExternalInterface.call("console.warn" , args);
			}
			catch (error:Error)
			{
				//
			}
			trace.apply(null, args);
		}
	}
}