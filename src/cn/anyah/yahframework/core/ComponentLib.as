package cn.anyah.yahframework.core 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.media.Sound;

	public class ComponentLib 
	{
		private static var _instance : ComponentLib;
		private static var _isBirth : Boolean;
		private var _libmc:MovieClip;
		public function ComponentLib(libmc:MovieClip) 
		{
			if(!_isBirth)
			{
				_instance = this;
				_isBirth = true;
				this._libmc=libmc;
			}
			else
			{
				throw new Error("请使用单例获取");
			}
		}

		public static function birth(libmc:MovieClip) : ComponentLib
		{
			if (_instance == null) return _instance = new ComponentLib(libmc);
			return _instance;
		}

		public static function get instance() : ComponentLib
		{
			if(_instance != null)return _instance;
			throw new Error("ComponentLib 还没初始化!");
		}
		public  function getClass(className : String) : Class
		{
			try
			{
				return Class(_libmc.loaderInfo.applicationDomain.getDefinition(className));
			}catch (e : Error) 
			{
				throw new IllegalOperationError(className + " definition not found");
			}
			return null;
		}

		public  function getAsset(classname : String) : DisplayObject 
		{
			
			try
			{
				var c : Class = Class(_libmc.loaderInfo.applicationDomain.getDefinition(classname));
				return new c();
			}catch (e : Error) 
			{
				throw new IllegalOperationError(classname + " definition not found");
			}
			return null;
		}

		public  function getSound( classname : String) : Sound 
		{
			try
			{
				var c : Class = Class(_libmc.loaderInfo.applicationDomain.getDefinition(classname));
				return new c();
			}catch (e : Error) 
			{
				throw new IllegalOperationError(classname + " definition not found");
			}
			return null;
		}

		public  function getBitmapData(bitmap : String) : BitmapData 
		{
			try
			{
				var c : Class = Class(_libmc.loaderInfo.applicationDomain.getDefinition(bitmap));
				return new c(0, 0);
			}catch (e : Error) 
			{
				throw new IllegalOperationError(bitmap + " definition not found");
			}
			return null;
		}


	}
}