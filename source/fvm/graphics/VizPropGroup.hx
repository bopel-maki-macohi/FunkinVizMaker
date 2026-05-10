package fvm.graphics;

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

		for (prop in props)
		{
			var assetPath:String = null;

			if (prop.asset != null)
			{
				final localPath = songID.getSongVizualizerPath('props/${prop.asset}'.imageFile());
				final sharedPath = prop.asset.getSharedPath().imageFile();

				if (Assets.exists(localPath) && assetPath == null)
					assetPath = localPath;
				else
				{
					if (assetPath == null)
						trace('No local prop asset path: $localPath');
				}

				if (Assets.exists(sharedPath) && assetPath == null)
					assetPath = sharedPath;
				else
				{
					if (assetPath == null)
						trace('No shared prop asset path: $localPath');
				}
			}

			loadProp(prop, assetPath);
		}
	}

	public function loadProp(prop:VisualizerRawPropData, ?assetPath:String)
	{
		var sprite:VizProp = new VizProp(prop, assetPath);

		if (sprite.loaded)
			add(sprite);
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
