package fvm.audio;

import flixel.util.FlxTimer;
import haxe.io.Path;
import flixel.FlxG;
import flixel.sound.FlxSound;
import lime.utils.Assets;
import flixel.sound.FlxSoundGroup;

class AudioGroup extends FlxSoundGroup
{
	public function update(elapsed:Float) {}

	/**
	 * Think of it like a mental map of file names for the audio files
	 */
	public var soundKeys:Array<String> = [];

	override function remove(sound:FlxSound):Bool
	{
		if (sounds.contains(sound))
			soundKeys.remove(soundKeys[sounds.indexOf(sound)]);

		return super.remove(sound);
	}

	/**
	 * Returns the sound key of index `index` from `soundKeys` or a dummy string 
	 * 
	 * @param index 
	 */
	public function getSoundKey(index:Int)
	{
		return soundKeys[index] ?? 'Sound #$index';
	}

	/**
	 * Load an audio file
	 * 
	 * **WILL NOT VERIFY THAT IT IS AN AUDIO FILE,
	 * ONLY THAT THE FILE EXISTS.**
	 * 
	 * @param files Audio files list
	 */
	public function addSoundFile(file:String)
	{
		if (Assets.exists(file))
		{
			soundKeys.push(Path.withoutDirectory(Path.withoutExtension(file)));
			add(new FlxSound().loadEmbedded(file));
		}
		else
			trace('Audio File doesnt exist: $file');
	}

	/**
	 * Load a list of audio files via `addSoundFile`
	 * 
	 * **WILL NOT VERIFY THAT IT IS AN AUDIO FILE,
	 * ONLY THAT THE FILE EXISTS.**
	 * 
	 * @param files Audio files list
	 */
	public function loadFiles(files:Array<String>)
	{
		for (file in files)
			addSoundFile(file);
	}

	public function play(startTime:Float = 0, forceRestart:Bool = false)
	{
		for (sound in sounds)
			sound.play(forceRestart, startTime);
	}

	/**
	 * Checks each sound to make sure that
	 * it is in sync with the `targetTime`
	 * or within a certain range.
	 * 
	 * It also turns on sounds that are paused
	 * 
	 * @param targetTime Desired song position in milliseconds
	 * @param range Range in milliseconds
	 */
	public function resyncCheck(targetTime:Float, range:Float = 3000)
	{
		for (i => sound in sounds)
		{
			var timeDifference:Float = targetTime - sound.time;

			if (Math.abs(timeDifference) > range)
			{
				trace('"${getSoundKey(i)}" : ${Math.abs(timeDifference)}ms difference');

				sound.pause();

				sound.time = targetTime;
			}

			if (!sound.playing)
				sound.resume();
		}
	}
}
