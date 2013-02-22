package cn.anyah.yahframework.utils 
{
	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.utils.Dictionary;

	/**
	 * @author flashhawk
	 */
	public class FrameScript 
	{
		public static function addFrameScriptByLabel(mc:MovieClip,label:String,target:Function):void
		{
			var labelDit:Dictionary = new Dictionary();
			var labels : Array = mc.currentLabels;

			for (var i : uint = 0;i < labels.length;i++) 
			{
				var fl : FrameLabel = labels[i];
				labelDit[fl.name] = fl.frame;
			}
			if(labelDit[label] == undefined)return;
			var frame : int = labelDit[label] - 1;
			mc.addFrameScript(frame, target);
		}
	}
}
