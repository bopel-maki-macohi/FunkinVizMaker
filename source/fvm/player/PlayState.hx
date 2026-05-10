package fvm.player;

import lime.utils.Assets;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import fvm.audio.ConductorState;
import fvm.audio.Conductor;
import fvm.audio.AudioGroup;
import flixel.sound.FlxSound;
import fvm.data.visualizer.VisualizerData;
import flixel.FlxState;

class PlayState extends ConductorState
{
	public var songID:String = 'test';
	public var songVisualizerData:VisualizerData;

	public var audioFiles:AudioGroup;

	public var props:FlxSpriteGroup;

	override function create()
	{
		super.create();

		songVisualizerData = new VisualizerData(songID);

		audioFiles = new AudioGroup();
		audioFiles.loadFiles([
			for (file in songVisualizerData.audioFiles)
				songID.getSongVizualizerPath('song/$file'.audioFile())
		]);
		audioFiles.play();

		conductor.setBPM(songVisualizerData.bpm);

		props = new FlxSpriteGroup();
		add(props);

		for (prop in songVisualizerData.props)
		{
			var assetPath:String = null;

			if (prop.asset == null)
				continue;

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

			if (assetPath == null)
				continue;

			switch (prop.type)
			{
				case bopper:

				case still:
					var staticSprite = new FlxSprite(0, 0, assetPath);
					staticSprite.screenCenter();
					props.add(staticSprite);
			}
		}
	}

	/**
	 * TODO: Make this open a pause state
	 */
	override function onFocusLost()
	{
		super.onFocusLost();

		audioFiles.pause();
	}

	override function onFocus()
	{
		super.onFocus();

		audioFiles.resume();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		conductor.songPosition += elapsed * 1000;
		conductor.update();
	}

	override function beatHit(beat:Int)
	{
		super.beatHit(beat);

		trace('beat: $beat');
	}
}
