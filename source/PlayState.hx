package;

import flixel.FlxObject;
import flixel.FlxState;
import flixel.effects.particles.FlxEmitter;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import utils.DialogueManager;
import utils.TiledLevelLoader;
import flixel.FlxG;
import utils.ControlsManager;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	public var player : Player;
	public var whale : Whale;
	public var sun : Sun;
	public var rain : Rain;
	public var waterWell : WaterWell;
	public var triggerGroup : FlxGroup;
	public var theEnd : FlxText;
	
	public var introSubState : IntroSubState;
	public var dialogueManager : DialogueManager;
	
	override public function create():Void
	{
		super.create();
		
		FlxG.sound.cache("music");
		openSubState(new IntroSubState(FlxColor.BLACK));
		
		Reg.PS = this;
		
		triggerGroup = new FlxGroup();
		
		theEnd = new FlxText("The End");
		theEnd.centerOrigin();
		theEnd.screenCenter();
		theEnd.y -= 20;
		theEnd.visible = false;
		theEnd.scrollFactor.set(0, 0);
		
		dialogueManager = new DialogueManager();
		dialogueManager.setTypeTextPosition(FlxG.width * 0.05, FlxG.height * 0.03);
		
		TiledLevelLoader.setupLevel(this, "level");
		
		sun = new Sun(FlxG.width * 0.7, FlxG.height * 0.05);
		
		add(player);
		add(whale);
		add(sun);
		add(dialogueManager);
		add(triggerGroup);
		add(theEnd);
		
		FlxG.camera.follow(player);
		
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		
		if (ControlsManager.justPressedFullscreen())
			FlxG.fullscreen = !FlxG.fullscreen;
			
		if (FlxG.keys.justPressed.F1)
			FlxG.resetState();
		
		FlxG.collide(player, TiledLevelLoader.currentCollidableMap);
		FlxG.collide(whale, TiledLevelLoader.currentCollidableMap);
		FlxG.overlap(player, triggerGroup, function(obj1 : FlxObject, obj2 : FlxObject){
			
			if (cast(obj2, DialogueTrigger).dialogueID == "start_last"){
				cast(obj1, Player).triggerState = 1;
			} else if(cast(obj2, DialogueTrigger).dialogueID == "end_last") {
				cast(obj1, Player).triggerState = 2;
				new FlxTimer().start(5, function(_){
					add(rain = new Rain());
				});
			}
			
			dialogueManager.startDialogue(this, cast(obj2, DialogueTrigger).dialogueID, false);
			dialogueManager.setTypeTextPosition(FlxG.width * 0.05, FlxG.height * 0.03);
			
			obj2.kill();
		});
	}
}
