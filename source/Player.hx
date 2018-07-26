package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxTimer;
import utils.ControlsManager;
import flixel.FlxG;
import utils.TiledLevelLoader;

class Player extends FlxSprite 
{
	
	public static inline var VELOCITY : Float = 15;
	public var isAlive : Bool;
	public var triggerState : Int;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		isAlive = true;
		triggerState = 0;
		
		loadGraphic(AssetPaths.sertaoguy__png, true, 16, 16);
		
		animation.add("idle", [0]);
		animation.add("walk", [8, 9, 10, 11, 12, 13, 14, 15], 10, true);
		animation.add("walkSlow", [8, 9, 10, 11, 12, 13, 14, 15], 5, true);
		animation.add("lamento", [16, 17, 18, 19], 2, false);
		animation.add("dead", [20, 21], 2, false);
		
		animation.play("idle");
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		acceleration.set(0, Reg.GRAVITY);
		
		if (isAlive){
			
			if (triggerState == 0){
				
				if (ControlsManager.pressedRight() && this.x < TiledLevelLoader.currentTiledMap.fullWidth - 10){
					velocity.x = VELOCITY;
					flipX = false;
				} else if (ControlsManager.pressedLeft() && this.x > 0){
					velocity.x = -VELOCITY;
					flipX = true;
				} else {
					velocity.x = 0;
				}
			} else if (triggerState == 1){
				velocity.x = VELOCITY / 3;
				animation.play("walkSlow");
			} else if (triggerState == 2){
				velocity.x = 0;
				animation.play("lamento");
				triggerState = 3;
			} else if (triggerState == 3){
				if (cast(Reg.PS, PlayState).rain != null && cast(Reg.PS, PlayState).rain.firstThunder){
					isAlive = false;
					animation.play("dead");
					triggerState == 4;
				}
			}
			
		} else {
			velocity.x = 0;
		}
		
		animate();
	}
	
	public function animate() : Void
	{
		
		if (isAlive){
			if (velocity.x == 0){
				if(triggerState == 0)
					animation.play("idle");
			} else{
				if(triggerState == 0)
					animation.play("walk");
				else if (triggerState == 1)
					animation.play("walkSlow");
			}
		}
		
	}
	
}