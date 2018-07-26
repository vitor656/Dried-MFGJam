package;

import flixel.FlxObject;
import flixel.effects.particles.FlxParticle;
import flixel.util.FlxColor;
import flixel.addons.effects.FlxTrail;
import flixel.FlxG;
import utils.TiledLevelLoader;
import flixel.effects.particles.FlxEmitter;

class RainDrop extends FlxParticle 
{

	public var trail : FlxTrail;
	public var hitFloor : Bool;
	
	public function new() 
	{
		super();
		
		initializeRainDrop();
	}
	
	override public function revive():Void 
	{
		super.revive();
		
		initializeRainDrop();
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (hitFloor){
			velocity.set(0, 0);
		}
		
		FlxG.collide(this, TiledLevelLoader.currentCollidableMap, function(object1 : FlxParticle, object2 : FlxObject){
			hitFloor = true;
			object1.kill();
		});
	}
	
	public function initializeRainDrop() : Void
	{
		hitFloor = false;
		makeGraphic(1, 2, FlxColor.BLUE);
	}
}