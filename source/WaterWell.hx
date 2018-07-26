package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

class WaterWell extends FlxSprite 
{
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		loadGraphic(AssetPaths.waterwell__png, true, 32, 16);
		
		animation.add("idle", [0]);
		animation.add("watering", [4, 5, 6, 7], 10, true);
		
		animation.play("idle");
		
	}
	
}