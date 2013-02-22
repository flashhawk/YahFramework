package cn.anyah.yahframework.utils.geom
{

	public class ColorUtils
	{
		//
		public static function getRed(_clr:uint):uint
		{
			return _clr >> 16 & 0xFF;
		}

		//
		public static function getGreen(_clr:uint):uint
		{
			return _clr >> 8 & 0xFF;
		}

		//
		public static function getBlue(_clr:uint):uint
		{
			return _clr & 0xFF;
		}

		//
		public static function getGrey(_clr:uint):uint
		{
			var grey:uint = 0.299 * getRed(_clr) + 0.587 * getGreen(_clr) + 0.114 * getBlue(_clr);
			grey = grey | grey << 16;
			grey = grey | grey << 8;
			return grey;
		}

		//
		public static function getRGB(_clr:uint):String
		{
			return to16(_clr);
		}

		//
		private static function to16(num:Number):String
		{
			return "0x" + Number(num).toString(16);
		}
	//
	}	
}