package cn.anyah.yahframework.components.tabmenu 
{
	import flash.display.MovieClip;

	public class AbstractTabMenuItem extends MovieClip implements ITabMenuItem 
	{
		private var _id : String = "";
		private var _data : * = null;
		private var _index : int = 0;
		private var _isLocked : Boolean = false;

		public function AbstractTabMenuItem()
		{
		}

		public function reset() : void
		{
		}

		public function select() : void
		{
		}

		public function over() : void
		{
			//
		}

		public function out() : void
		{
			//
		}

		public function click() : void
		{
			//
		}

		public function lock() : void
		{
			_isLocked = true;
		}

		public function unlock() : void
		{
			_isLocked = false;
		}

		public function set id(i : String) : void
		{
			_id = i;
		}

		public function get id() : String
		{
			return _id;
		}

		public function set index(n : int) : void
		{
			_index = n;
		}

		public function get index() : int
		{
			return _index;
		}

		public function set data(d : *) : void
		{
			_data = d;
		}

		public function get data() : *
		{
			return _data;
		}

		public function get isLocked() : Boolean
		{
			return _isLocked;
		}

		public function set isLocked(b : Boolean) : void
		{
			_isLocked = isLocked;
		}
	}
}
