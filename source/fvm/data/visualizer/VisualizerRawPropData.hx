package fvm.data.visualizer;

import flixel.util.FlxColor;
import flixel.util.typeLimit.OneOfTwo;

typedef VisualizerRawPropData =
{
	type:VisualizerPropType,
	asset:String,

	?base:String,
	?baseOptions:VisualizerRawPropBaseOptionsData,

	?id:String,

	?tags:Array<String>,

	?layer:Int,
	?alpha:Float,

	?position:Array<Float>,
	?scale:Array<Float>,
	?scrollFactor:Array<Float>,

	?flipX:Bool,
	?flipY:Bool,
	?antialiasing:Bool,

	?color:OneOfTwo<FlxColor, String>,

	?bopAnim:String,
	?anims:Array<VisualizerRawAnimationData>,
	?bopType:VisualizerPropBopType,

	?waveform:VisualizerRawWaveformData,
}
