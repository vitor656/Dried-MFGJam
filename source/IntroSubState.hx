package;

import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.FlxG;
import utils.DialogueManager;
import flixel.util.FlxTimer;
import utils.ControlsManager;

class IntroSubState extends FlxSubState 
{
	
	public var dialogueManager : DialogueManager;
	
	public function new(BGColor:FlxColor=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		
		dialogueManager = new DialogueManager();
		dialogueManager.setTypeTextPosition(FlxG.width / 2 - 10, FlxG.height / 2 - 10);
		add(dialogueManager);
		
		new FlxTimer().start(2, function(_){
			dialogueManager.startDialogue(this, Reg.DIALOGUE_INTRO, false);
		});
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (ControlsManager.justPressedFullscreen()){
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		
		if (dialogueManager.dialogueFinished){
			new FlxTimer().start(2, function(_){
				close();
				FlxG.sound.playMusic("music", 0.7, true);
			});
		}
	}
}