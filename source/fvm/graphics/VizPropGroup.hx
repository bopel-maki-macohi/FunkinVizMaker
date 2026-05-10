package fvm.graphics;

import flixel.util.FlxSort;
import fvm.util.SortUtil;
import fvm.graphics.VizProp;
import haxe.io.Path;
import lime.utils.Assets;
import fvm.data.visualizer.VisualizerRawPropData;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class VizPropGroup extends FlxTypedSpriteGroup<VizProp>
{
	public function loadProps(songID:String, props:Array<VisualizerRawPropData>)
	{
		if (songID == null)
			songID = '';
		if (props == null)
			return;

		if (members.length > 0)
		{
			for (sprite in members)
			{
				members.remove(sprite);
				sprite.destroy();
				sprite = null;
			}

			clear();
		}

		for (i => prop in props)
			loadProp(prop, i, songID);

		refresh();
	}

	public function loadProp(prop:VisualizerRawPropData, propNum:Int, ?songID:String)
	{
		var sprite:VizProp = new VizProp(prop, propNum, songID);

		if (sprite.loaded)
		{
			trace('Adding prop: "${sprite.id}"');
			add(sprite);
		}
		else
			sprite.destroy();
	}

	public function onBeatHit(curBeat:Int)
	{
		for (prop in members)
		{
			if (prop.bopType == beat)
				prop.dance();

			if (prop.bopType == otherbeat && curBeat % 2 == 0)
				prop.dance();
		}
	}

	public function onStepHit(curStep:Int)
	{
		for (prop in members)
		{
			if (prop.bopType == step)
				prop.dance();

			if (prop.bopType == otherstep && curStep % 2 == 0)
				prop.dance();
		}
	}
}
