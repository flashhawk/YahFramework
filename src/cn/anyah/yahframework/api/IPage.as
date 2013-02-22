package cn.anyah.yahframework.api
{
	import flash.events.IEventDispatcher;

	public interface IPage extends IEventDispatcher
	{
		function transitionIn(): void;

		function transitionInComplete(): void;

		function transitionOut(): void;

		function transitionOutComplete(): void;
		 
		function destory():void;
	}

}