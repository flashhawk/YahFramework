package  cn.anyah.yahframework.utils.ds
{
	/**
	 * @author form aswing 
	 */
	import flash.utils.Dictionary;
	public class HashMap 
	{
		private var length:int;
		private var content:Dictionary;
		public function HashMap() 
		{
			length = 0;
			content = new Dictionary();
			
		}
		//---------------------------public methods---------------------------
		/**
		 * 
		 *@return  返回keys的个数
		 */
		public function size():int
		{
			return length;
		}
		
		/**
		 * 
		 *@return  返回是hashMap是否为空
		 */
		public function isEmpty():Boolean
		{
			return (length == 0);
		}
		
		/**
		 * 
		 * @return 返回keys的数组
		 */
		public function keys():Array
		{
			var temp:Array = new Array(length);
			var index:int = 0;
			for (var i:* in content)
			{
				temp[index] = i;
				index++;
			}
			return temp;
		}
		
		/**
		 * Call func(key) for each key.
		 * @param func the function to call
		 */
		public function eachKey(func:Function):void
		{
			for (var i:* in content)
			{
				func(i);
			}
		}
		
		/**
		 * Call func(value) for each value.
		 * @param func the function to call
		 */
		public function eachValue(func:Function):void
		{
			for each(var i:* in content)
			{
				func(i);
			}
		}
		
		/**
		 * 
		 * @return 返回value的数组
		 */
		public function values():Array
		{
			var temp:Array=new Array(length);
			var index:int = 0;
			for each(var i:* in content)
			{
				temp[index] = i;
				index++;
			}
			return temp;
		}
		
		/**
		 * 
		 * @param	value ....
		 * @return 返回是否有这个value
		 */
		public function containsValue(value:*):Boolean
		{
			for each(var i:* in content)
			{
				if (i === value)
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		 * Tests if the specified object is a key in this HashMap.
		 * This operation is very fast if it is a string.
		 * @param   key   The key whose presence in this map is to be tested
		 * @return <tt>true</tt> if this map contains a mapping for the specified
		 */
		
		public function containsKey(key:*):Boolean
		{
		    if (content[key] == undefined)
			{
				return false;
			}
			return true;	
		}
		/**
		 * Returns the value to which the specified key is mapped in this HashMap.
		 * Return null if the key is not mapped to any value in this HashMap.
		 * This operation is very fast if the key is a string.
		 * @param   key the key whose associated value is to be returned.
		 * @return  the value to which this map maps the specified key, or
		 *          <tt>null</tt> if the map contains no mapping for this key
		 *           or it is null value originally.
		 */
		public function get(key:*):*
		{
			var value:* = content[key];
			if (value !== undefined)
			{
				return value;
			}
			return null;
		}
		/**
		 * Same functionity method with different name to <code>get</code>.
		 * 
		 * @param   key the key whose associated value is to be returned.
		 * @return  the value to which this map maps the specified key, or
		 *          <tt>null</tt> if the map contains no mapping for this key
		 *           or it is null value originally.
		 */
		public function getValue(key:*):*
		{
			return get(key);
		}
		
		
		public function put(key:*, value:*):*
		{
			if (key == null)
			{
				throw new ArgumentError("cannot put a value with undefined or null key!");
				return undefined;
			}else if (value == null)
			{
				remove(key);
			}else
			{
				var exit:Boolean = containsKey(key);
				if (!exit)
				{
					length++;
				}
				var oldValue:* = this.get(key);
				content[key] = value;
				return oldValue;
			}
		}
		
		public function remove(key:*):*
		{
			var exit:Boolean = containsKey(key);
			if (!exit)
			{
				return null;
			}
			var temp:* = content[key];
			delete content[key];
			length--;
			return temp;
		}
		
		/**
		 * Clears this HashMap so that it contains no keys no values.
		 */
		public function clear():void
		{
			length = 0;
			content = new Dictionary();
		}
		
		/**
		 * Return a same copy of HashMap object
		 */
		public function clone():HashMap
		{
			var temp:HashMap;
			for (var i:* in content)
			{
				temp.put(i, content[i]);
			}
			return temp;
		}
		public function toString():String
		{
			var ks:Array = keys();
			var vs:Array = values();
			var temp:String = "HashMap Content:\n";
			for (var i:int = 0; i < ks.length; i++)
			{
				temp += ks[i] + "-> " + vs[i] + "\n";
			}
			return temp;
			
		}
	}
	
}