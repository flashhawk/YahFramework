/*
 * Copyright (c) 2007 Mark Walters
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
package cn.anyah.yahframework.utils
{
	import flash.geom.ColorTransform;
	import flash.text.TextField;
	
	/**
	 * The SelectionColor class allows for a TextField to change its selection color.
	 * 
	 * @author Mark Walters
	 * @since 2007.08.13
	 */
	public class SelectionColor
	{
		
		/**
		 * Sets the field's selection color and tries to handle changing the field's background, border and text colors to maintain their initial values.
		 * 
		 * @param	field	TextField
		 * @param	color	uint
		 */
		public static function setFieldSelectionColor( field:TextField, color:uint ):void
		{
			field.backgroundColor = invert( field.backgroundColor );
			field.borderColor = invert( field.borderColor );
			field.textColor = invert( field.textColor );
				
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.color = color;
			colorTrans.redMultiplier = -1;
			colorTrans.greenMultiplier = -1;
			colorTrans.blueMultiplier = -1;
			field.transform.colorTransform = colorTrans;
		}
		
		protected static function invert( color:uint ):uint
		{
			var colorTrans:ColorTransform = new ColorTransform();
			colorTrans.color = color;
			
			return invertColorTransform( colorTrans ).color;
		}
		
		protected static function invertColorTransform( colorTrans:ColorTransform ):ColorTransform
		{
			with( colorTrans )
			{
				redMultiplier = -redMultiplier;
				greenMultiplier = -greenMultiplier;
				blueMultiplier = -blueMultiplier;
				redOffset = 255 - redOffset;
				greenOffset = 255 - greenOffset;
				blueOffset = 255 - blueOffset;
			}
			
			return colorTrans;
		}
		
	}
	
}
