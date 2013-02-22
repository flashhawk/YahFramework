package cn.anyah.yahframework.utils 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.errors.IllegalOperationError;
	import flash.media.Sound;
	import flash.utils.getDefinitionByName;

	public class Lib 
	{
		public static function getClass(doc :DisplayObjectContainer,className : String) : Class
		{
			try
			{
				return Class(doc.loaderInfo.applicationDomain.getDefinition(className));
			}catch (e : Error) 
			{
				throw new IllegalOperationError(className + " definition not found");
			}
			return null;
		}

		public static function getAsset(doc : DisplayObjectContainer, classname : String) : DisplayObject 
		{
			
			try
			{
				var c : Class = Class(doc.loaderInfo.applicationDomain.getDefinition(classname));
				return new c();
			}catch (e : Error) 
			{
				throw new IllegalOperationError(classname + " definition not found");
			}
			return null;
		}

		public static function getSound(doc : DisplayObjectContainer, classname : String) : Sound 
		{
			try
			{
				var c : Class = Class(doc.loaderInfo.applicationDomain.getDefinition(classname));
				return new c();
			}catch (e : Error) 
			{
				throw new IllegalOperationError(classname + " definition not found");
			}
			return null;
		}

		public static function getBitmapData(doc : DisplayObjectContainer, bitmap : String) : BitmapData 
		{
			try
			{
				var c : Class = Class(doc.loaderInfo.applicationDomain.getDefinition(bitmap));
				return new c(0, 0);
			}catch (e : Error) 
			{
				throw new IllegalOperationError(bitmap + " definition not found");
			}
			return null;
		}

		public static function getClassObject(classname : String) : * 
		{
			try
			{
				var c : Class = Class(getDefinitionByName(classname));
				return new c();
			}catch (e : Error) 
			{
				throw new IllegalOperationError(classname + " definition not found");
			}
			return null;
		}
	}
}