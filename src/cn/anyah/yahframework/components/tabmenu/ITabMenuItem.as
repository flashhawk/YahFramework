package cn.anyah.yahframework.components.tabmenu 
{
	import flash.events.IEventDispatcher;

	public interface ITabMenuItem extends IEventDispatcher
	{
		function get id() : String;

		function set id(i : String) : void;

		function get index() : int;

		function set index(i : int) : void;

		function get data() : *;

		function set data(d : *) : void;

		function reset() : void;

		function select() : void;

		function over() : void;

		function out() : void;

		function click() : void;

		function lock() : void;

		function unlock() : void;
	}
}
