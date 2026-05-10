package fvm.player;

import fvm.graphics.VizProp;
import haxe.io.Path;
import lime.utils.Assets;
import fvm.data.visualizer.VisualizerRawPropData;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class PropGroup extends FlxTypedSpriteGroup<VizProp>
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

		add(sprite);
	}
}
