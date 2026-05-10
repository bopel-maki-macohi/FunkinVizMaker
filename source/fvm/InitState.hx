package fvm;

import sys.thread.Thread;
import lime.app.Application;
import flixel.FlxSprite;
import fvm.audio.Conductor;
import fvm.player.PlayState;
import flixel.FlxG;
import flixel.FlxState;

/**
 * Lorem ipsum dolor sit amet
 */
class InitState extends FlxState
{
	/**
	 * Runs initalization functions
	 * and then boots you to `PlayState`
	 */
	override public function create()
	{
		super.create();

		initInstances();

		initFlixel();

		Thread.create(genDocs);

		FlxG.switchState(() -> new PlayState());
	}

	public function initInstances()
	{
		Conductor.instance = new Conductor();
	}

	public function initFlixel()
	{
		FlxSprite.defaultAntialiasing = true;
	}

	/**
	 * If `GEN_DOCS` is defined,
	 * documentation will be generated
	 * and you will be sent to the page
	 */
	public function genDocs()
	{
		#if GEN_DOCS
		Sys.command('..\\..\\..\\..\\docs\\docs-windows');
		Sys.command('..\\..\\..\\..\\docs\\pages\\index.html');
		#end
	}
}
