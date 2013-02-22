package cn.anyah.yahframework.components.tabmenu 
{
	import flash.events.IEventDispatcher;

	public interface ITabMenu extends IEventDispatcher 
	{
		function lock():void;
		function unlock():void;
		function reset():void;
		function get selectedIndex():int;
		function set selectedIndex(index:int):void;
		function get selectedData():*;
		function set selectedId(id:String):void;
		function get selectedId():String;
		function set items(items:Array):void;
		function get items():Array;
		function getIndexById(id:String):*;
	}
}
