package;

import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxTimer;
import utils.ControlsManager;

class BeforeMenuSubState extends FlxSubState 
{

	private var txtMade : FlxText;
	private var txtFull : FlxText;
	
	public function new(BGColor:FlxColor=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		
		txtMade = new FlxText();
		txtMade.text = "Made by Vitor Rabelo";
		txtMade.centerOrigin();
		txtMade.screenCenter();
		
		txtFull = new FlxText();
		txtFull.text = "Press F to fullscreen";
		txtFull.centerOrigin();
		txtFull.screenCenter();
		txtFull.y = FlxG.height * 0.8;
		new FlxTimer().start(0.5, function(_){ txtFull.visible = !txtFull.visible; }, 0);
		
		add(txtMade);
		
		#if !html5
		add(txtFull);
		#end
		
		new FlxTimer().start(5, function(_){
			close();
		});
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (ControlsManager.justPressedFullscreen()){
			FlxG.fullscreen = !FlxG.fullscreen;
		}
	}
	
}