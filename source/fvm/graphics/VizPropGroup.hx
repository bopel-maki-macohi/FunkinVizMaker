package fvm.graphics;

import flixel.util.FlxSort;
import fvm.util.SortUtil;
import fvm.graphics.VizSpriteProp;
import haxe.io.Path;
import lime.utils.Assets;
import fvm.data.visualizer.VisualizerRawPropData;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class VizPropGroup extends FlxSpriteGroup
{
	public function loadProps(songID:String, props:Array<VisualizerRawPropData>)
	{
		if (songID == null) songID = '';
		if (props == null) return;

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

		for (i => prop in props) loadProp(prop, i, songID);

		refresh();
	}

	public function loadProp(prop:VisualizerRawPropData, propNum:Int, ?songID:String)
	{
		var sprite:VizSpriteProp = new VizSpriteProp(prop, propNum, songID);

		if (sprite.loaded)
		{
			trace('Adding sprite prop: "${sprite.id}"');
			add(sprite);
			return;
		}
		else sprite.destroy();

		var waveform:VizWaveformSprite = new VizWaveformSprite(prop, propNum, songID);

		if (waveform.loaded)
		{
			trace('Adding waveform prop: "${waveform.id}"');
			add(waveform);

			return;
		}
		else waveform.destroy();

		trace('I dont know what class to use for ${prop.type} prop');
	}

	public function onBeatHit(curBeat:Int)
	{
		for (sprite in members)
		{
			if (Std.isOfType(sprite, VizSpriteProp))
			{
				var prop = cast(sprite, VizSpriteProp);

				if (prop.bopType == beat) prop.dance();

				if (prop.bopType == otherbeat && curBeat % 2 == 0) prop.dance();
			}
		}
	}

	public function onStepHit(curStep:Int)
	{
		for (sprite in members)
		{
			if (Std.isOfType(sprite, VizSpriteProp))
			{
				var prop = cast(sprite, VizSpriteProp);

				if (prop.bopType == step) prop.dance();

				if (prop.bopType == otherstep && curStep % 2 == 0) prop.dance();
			}
		}
	}

	public function getIVisProps()
	{
		return members.filter(function(prop)
		{
			return Std.isOfType(prop, IVizProp);
		});
	}

	public function getWaveformProps()
	{
		return getIVisProps().filter(function(prop)
		{
			return Std.isOfType(prop, VizWaveformSprite);
		});
	}

	public function getPropsOfID(propID:String)
	{
		return getIVisProps().filter(function(prop)
		{
			return cast(prop, IVizProp).id == propID;
		});
	}

	public function getWaveformOfID(propID:String)
	{
		return getWaveformProps().filter(function(prop)
		{
			return cast(prop, VizWaveformSprite).id == propID;
		});
	}

	public function propExists(propID:String):Bool
	{
		return getPropsOfID(propID).length > 0;
	}

	public function getProp(propID:String)
	{
		if (!propExists(propID)) return null;

		return getPropsOfID(propID)[0];
	}

	public function getWaveformProp(propID:String)
	{
		if (!propExists(propID)) return null;

		var prop:VizWaveformSprite = cast(getWaveformOfID(propID)[0], VizWaveformSprite);
		if (prop != null) return prop;

		return null;
	}
}
