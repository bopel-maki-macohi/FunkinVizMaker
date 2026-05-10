package fvm.audio;

import flixel.FlxG;
import flixel.sound.FlxSound;
import lime.utils.Assets;
import flixel.sound.FlxSoundGroup;

class AudioGroup extends FlxSoundGroup
{
	public function update(elapsed:Float) {}

	/**
	 * Load a list of audio files
	 * 
	 * **WILL NOT VERIFY THAT IT IS AN AUDIO FILE,
	 * ONLY THAT THE FILE EXISTS.**
	 * 
	 * @param files Audio files list
	 */
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

	/**
	 * Checks each sound to make sure that
	 * it is in sync with the primary sound
	 * or within a certain range.
	 * 
	 * @param range Range in milliseconds
	 */
	public function resyncCheck(range:Float = 20)
	{
		if (sounds.length < 2)
			return;

		for (i => sound in sounds)
		{
			if (i == 0)
				continue;

			var timeDifference:Float = sounds[0].time - sound.time;

			if (timeDifference < -range || timeDifference > range)
			{
				trace('$timeDifference ms difference');

				sound.pause();
				sound.time = sounds[0].time;
				sound.play();
			}
		}
	}
}
