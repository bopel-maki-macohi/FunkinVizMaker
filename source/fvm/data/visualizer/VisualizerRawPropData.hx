package fvm.data.visualizer;

typedef VisualizerRawPropData =
{
	type:VisualizerPropType,
	asset:String,

	?tags:Array<String>,

	?alpha:Float,

	?position:Array<Float>,
	?scale:Array<Float>,
	?scrollFactor:Array<Float>,
	
	?bopAnim:String,
    ?anims:Array<VisualizerRawAnimationData>,
	?bopType:VisualizerPropBopType,
}
