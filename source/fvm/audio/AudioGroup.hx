package fvm.audio;

import flixel.FlxG;
import flixel.sound.FlxSound;
import lime.utils.Assets;
import flixel.sound.FlxSoundGroup;

class AudioGroup extends FlxSoundGroup
{
	public function loadFiles(files:Array<String>)
	{
		for (file in files)
		{
			if (Assets.exists(file))
				add(new FlxSound().loadEmbedded(file));
			else
				trace('Audio File doesnt exist: $file');
		}
	}

	public function play(startTime:Float = 0, forceRestart:Bool = false)
	{
		for (sound in sounds)
			sound.play(forceRestart, startTime);
	}

	public function update(elapsed:Float)
	{
		for (i => sound in sounds)
		{
			FlxG.watch.addQuick('sound$i.time', sound.time / 1000);
		}
	}
}
