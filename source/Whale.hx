package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

class Whale extends FlxSprite 
{
	
	public static inline var VELOCITY_WHALE : Float = 10;
	public var isTimeToSit : Bool;
	public var stopAtFirst : Bool;
	
	public function new(?X:Float=0, ?Y:Float=0, ?SimpleGraphic:FlxGraphicAsset) 
	{
		super(X, Y, SimpleGraphic);
		
		isTimeToSit = false;
		stopAtFirst = true;
		
		loadGraphic(AssetPaths.dog__png, true, 16, 16);
		
		animation.add("idle", [0]);
		animation.add("sit", [2]);
		animation.add("walk", [4, 5], 10, true);
		
		animation.play("idle");
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		acceleration.set(0, Reg.GRAVITY);
		
		if (FlxMath.distanceBetween(this, cast(Reg.PS, PlayState).player) > 10){
			if (cast(Reg.PS, PlayState).player.x - x > 0){
				velocity.x = VELOCITY_WHALE;
				flipX = false;
			} else {
				velocity.x = -VELOCITY_WHALE;
				flipX = true;
			}
			
			if (isOnScreen() && cast(Reg.PS, PlayState).player.triggerState > 0){
				velocity.x = velocity.x / 2;
			}
			
		} else {
			velocity.x = 0;
		}
		
		if (!cast(Reg.PS, PlayState).player.isAlive)
			isTimeToSit = true;
		
		animate();
	}
	
	public function animate() : Void
	{
		if (!isTimeToSit){
			if (velocity.x == 0){
				animation.play("idle");
			} else {
				animation.play("walk");
			}
		} else {
			
			if (isTimeToSit && FlxMath.distanceBetween(this, cast(Reg.PS, PlayState).player) <= 10){
				if (stopAtFirst){
					animation.play("idle");
					stopAtFirst = false;
					
					new FlxTimer().start(3, function(_){
						animation.play("sit");
					});
				}
				
			}
			
		}
		
	}
}