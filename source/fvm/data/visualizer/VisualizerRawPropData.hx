package fvm.data.visualizer;

typedef VisualizerRawPropData =
{
	type:VisualizerPropType,
	asset:String,

	?base:String,
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

	?bopAnim:String,
	?anims:Array<VisualizerRawAnimationData>,
	?bopType:VisualizerPropBopType,
}
