package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.util.FlxColor;
import utils.ControlsManager;
import openfl.Lib;

class MenuState extends FlxState 
{
	private var txtTitle : FlxText;
	private var txtStart : FlxText;
	private var txtQuit : FlxText;
	private var selectedOption : Int;

	override public function create():Void 
	{
		super.create();
		
		openSubState(new BeforeMenuSubState(FlxColor.BLACK));
		
		selectedOption = 0;
		FlxG.camera.bgColor = FlxColor.fromRGB(239, 85, 32);
		FlxG.mouse.visible = false;

		txtTitle = new FlxText();
		txtTitle.text = "DRIED";
		txtTitle.size = 32;
		txtTitle.centerOrigin();
		txtTitle.screenCenter();
		txtTitle.y -= 20;
		
		txtStart = new FlxText();
		txtStart.text = "Start";
		txtStart.centerOrigin();
		txtStart.screenCenter();
		txtStart.y += 15;
		txtStart.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1);
		
		txtQuit = new FlxText();
		txtQuit.text = "Quit";
		txtQuit.centerOrigin();
		txtQuit.screenCenter();
		txtQuit.y += 30;
		txtQuit.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 1);
		txtQuit.borderSize = 0;
		
		add(txtTitle);
		add(txtStart);
		add(txtQuit);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (ControlsManager.justPressedFullscreen()){
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		
		if (ControlsManager.justPressedDown()){
			FlxG.sound.play("blip");
			selectedOption = 1;
		}
		
		if (ControlsManager.justPressedUp()){
			FlxG.sound.play("blip");
			selectedOption = 0;
		}
			
		if (ControlsManager.justPressedConfirm()){
			if (selectedOption == 0){
				FlxG.sound.play("select");
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function(){
					FlxG.switchState(new PlayState());
				});
			} else if (selectedOption == 1){
				Lib.application.window.close();
			}
		}
			
		switch(selectedOption){
			case 0:
				txtStart.borderSize = 1;
				txtQuit.borderSize = 0;
			case 1:
				txtStart.borderSize = 0;
				txtQuit.borderSize = 1;
		}
	}
}