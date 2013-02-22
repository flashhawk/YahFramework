package cn.anyah.yahframework.components.media 
{
	import flash.events.IEventDispatcher;
	
	public interface IVideoPlayer extends IEventDispatcher 
	{
		function set source(file:String):void;
		function get source():String;
		function play():void;
		function stop():void;
		function pause():void;
		function seek(ms:Number):void;
	}
}
