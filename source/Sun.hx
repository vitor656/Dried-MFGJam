package;

import flixel.FlxSprite;
import utils.TiledLevelLoader;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;

class Sun extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		loadGraphic(AssetPaths.sun__png, true, 32, 32);
		
		animation.add("idle", [0, 1, 2, 3, 4], 3, true);
		animation.play("idle");
		
		scrollFactor.set(0, 0);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
	
}