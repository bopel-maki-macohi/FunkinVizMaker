package fvm.data.visualizer;

typedef VisualizerRawPropData =
{
	type:VisualizerPropType,
	asset:String,
	
	?bopAnim:String,
    ?anims:Array<VisualizerRawAnimationData>,
}
