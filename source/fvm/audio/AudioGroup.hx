package fvm.audio;

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
		}
	}

	public function play(startTime:Float = 0, forceRestart:Bool = false)
	{
		for (sound in sounds)
			sound.play(forceRestart, startTime);
	}
}
