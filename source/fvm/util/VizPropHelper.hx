package fvm.util;

import flixel.util.FlxColor;
import fvm.scripting.events.visualizer.VisualizerPropParseTagEvent;
import fvm.scripting.EventManager;
import flixel.FlxSprite;
import fvm.data.visualizer.VisualizerRawPropData;

class VizPropHelper
{
	public static function parseGeneralData(sprite:FlxSprite, data:VisualizerRawPropData)
	{
		if (data == null) return;

		if (data.tags != null)
		{
			for (tag in data.tags)
			{
				switch (tag.toLowerCase())
				{
					// case 'center', 'screencenter':
					// screenCenter();
				}

				ScriptUtil.callCoreEvent('parsePropTag', EventManager.get(VisualizerPropParseTagEvent).recycle(sprite, tag));
			}
		}

		sprite.alpha = data?.alpha ?? 1;

		if (data?.position != null)
		{
			sprite.x += data?.position[0] ?? 0;
			sprite.y += data?.position[1] ?? 0;
		}

		if (data?.scale != null)
		{
			sprite.scale.x = data?.scale[0] ?? 1;
			sprite.scale.y = data?.scale[1] ?? 1;
		}

		if (data?.scrollFactor != null)
		{
			sprite.scrollFactor.x = data?.scrollFactor[0] ?? 1;
			sprite.scrollFactor.y = data?.scrollFactor[1] ?? 1;
		}

		sprite.flipX = data?.flipX ?? false;
		sprite.flipY = data?.flipY ?? false;

		if (data?.layer != null) sprite.zIndex = data?.layer;

		if (data?.color != null)
		{
			// if (Std.isOfType(color, Int)) this.color = cast(data.color, Int);
			if (Std.isOfType(sprite.color, String)) sprite.color = FlxColor.fromString(cast(data.color, String));
		}

		sprite.antialiasing = data?.antialiasing ?? true;
		// trace(zIndex);

		if (data?.width != null) sprite.setGraphicSize(data.width, sprite.height);
		if (data?.height != null) sprite.setGraphicSize(sprite.width, data.height);
	}
}
