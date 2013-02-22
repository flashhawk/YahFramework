package cn.anyah.yahframework.components.tabmenu 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;

	public class AbstractTabMenu extends MovieClip implements ITabMenu
	{
		//items = [{menuMC:null, data:null, id:null,overFunc:null,outFunc:null,clickFunc:null}];
		protected var _items : Array;
		protected var _selectedItem : ITabMenuItem;
		//
		protected var _selectedIndex : int = -1;
		protected var _selectedData : * = null;
		protected var _selectedId : String = "";
		private var _map : Dictionary = new Dictionary();
		private var _isLocked : Boolean = false;

		public function AbstractTabMenu()
		{
			if (this["constructor"] == ["class TabMenu"])
				throw new Error("抽象类,此类不能被实例化");
		}

		private function _init() : void
		{
			_map = new Dictionary();
			for(var i : int = 0;i < _items.length;i++)
			{
				var item : ITabMenuItem = ITabMenuItem(_items[i].menuMC);
				item.data = _items[i].data;
				item.id = _items[i].id;
				item.index = i;
				_addItemLsn(item);
				_map[String(item.id)] = item.index;
			} 
			if(_selectedIndex != -1)
				itemClick(null, _items[_selectedIndex].menuMC);
			if(_selectedId != "")
				itemClick(null, _items[getIndexById(_selectedId)].menuMC);
			if(_isLocked)
				lock();
		}

		private function _clear() : void
		{
			_selectedItem = null;
			_selectedData = null;
			_selectedIndex = -1;
			_selectedId = "";
			if(_items != null)
			{
				for(var i : int = 0;i < _items.length;i++)
				{
					var item : ITabMenuItem = ITabMenuItem(_items[i].menuMC);
					item.reset();
					_removeItemLsn(item);
				}
			}
			_map = null;
			_items = null;
		}

		private function _addItemLsn(item : ITabMenuItem) : void
		{
			item.addEventListener(MouseEvent.CLICK, itemClick, false, 1000);
			item.addEventListener(MouseEvent.ROLL_OVER, itemOver, false, 1000);
			item.addEventListener(MouseEvent.ROLL_OUT, itemOut, false, 1000);		
		}

		private function _removeItemLsn(item : ITabMenuItem) : void
		{
			item.removeEventListener(MouseEvent.CLICK, itemClick);
			item.removeEventListener(MouseEvent.ROLL_OVER, itemOver);
			item.removeEventListener(MouseEvent.ROLL_OUT, itemOut);			
		}

		protected function dispatchTabMenuEvent(e : String,item : ITabMenuItem) : void
		{
			var evt : TabMenuEvent = new TabMenuEvent(e);
			evt.id = item.id;
			evt.data = item.data;
			evt.index = item.index;	
			dispatchEvent(evt);
		}

		protected function itemClick(e : MouseEvent,target : ITabMenuItem = null) : void
		{
			var item : ITabMenuItem;
			if(e != null && target == null)
				item = ITabMenuItem(e.currentTarget);
			else if(e == null && target != null)
				item = target;
			if(item == _selectedItem && target == null)
				return;
			if(_selectedItem != null)
				_selectedItem.reset();
			item.select();
			_selectedItem = item;
			_selectedData = item.data;
			_selectedId = item.id;
			_selectedIndex = item.index;
			if(e != null)
				dispatchTabMenuEvent(TabMenuEvent.ITEM_CLICKED, _selectedItem);
			dispatchTabMenuEvent(TabMenuEvent.ITEM_CHANGED, _selectedItem);
		}

		protected function itemOver(evt : MouseEvent) : void
		{
			evt.currentTarget.over();
			dispatchTabMenuEvent(TabMenuEvent.ITEM_ROLL_OVER, ITabMenuItem(evt.currentTarget));
		}

		protected function itemOut(evt : MouseEvent) : void
		{
			evt.currentTarget.out();
			dispatchTabMenuEvent(TabMenuEvent.ITEM_ROLL_OUT, ITabMenuItem(evt.currentTarget));
		}

		public function lock() : void
		{
			_isLocked = true;
			if(_items == null)return;
			for(var i : int = 0;i < _items.length;i++)
			{
				var item : ITabMenuItem = ITabMenuItem(_items[i].menuMC);
				_removeItemLsn(item);
				item.lock();
			}
		}

		public function unlock() : void
		{
			_isLocked = false;
			if(_items == null)return;
			for(var i : int = 0;i < _items.length;i++)
			{
				var item : ITabMenuItem = ITabMenuItem(_items[i].menuMC);
				_addItemLsn(item);
				item.unlock();
			}
			_selectedItem.lock();
		}

		public function get selectedIndex() : int
		{
			return _selectedIndex;
		}

		public function set selectedIndex(i : int) : void
		{
			_selectedIndex = i;
			if(_items)
				itemClick(null, _items[_selectedIndex].menuMC);
		}

		public function getIndexById(id : String) : *
		{
			return _map[id];
		}

		public function reset() : void
		{
			_selectedIndex = -1;
			_selectedId = "";
			if(_selectedItem != null)
				_selectedItem.reset();
			_selectedItem = null;
			_selectedData = null;
		}

		public function get selectedData() : *
		{
			return _selectedData;
		}

		public function get selectedId() : String
		{
			return _selectedId;
		}

		public function set selectedId(id : String) : void
		{
			if(_selectedId==id)return;
			if(id==""||!id)return;
			if(getIndexById(id)==undefined)
			{
				reset();
				return;
			}
			_selectedId = id;
			_selectedIndex = getIndexById(_selectedId);
			if(_items)
				itemClick(null, _items[_selectedIndex].menuMC);
		}

		public function get items() : Array
		{
			return _items;
		}

		public function set items(itemsArray : Array) : void
		{
			if(_items)
				_clear();
			_items = itemsArray;
			if(_items)
				_init();
		}

		public function get selectedItem() : ITabMenuItem
		{
			return _selectedItem;
		}
	}
}
