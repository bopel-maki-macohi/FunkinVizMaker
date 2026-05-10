package fvm;

import fvm.scripting.Script;
import fvm.util.macro.DefineMacro;
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

		switchState();
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

	public function switchState()
	{
		if (DefineMacro.isDefined('HSCRIPT_TESTING'))
		{
			var scriptTeser:Script = new Script('assets/TestScript.hx');
		}

		FlxG.switchState(() -> new PlayState());
	}
}
