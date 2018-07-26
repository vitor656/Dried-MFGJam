package;

import flixel.FlxObject;
import flixel.effects.particles.FlxEmitter;
import flixel.FlxG;
import flixel.effects.particles.FlxParticle;
import flixel.system.FlxSound;
import utils.TiledLevelLoader;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Rain extends FlxEmitter 
{
	
	public static inline var MIN_FREQUENCY : Float = 0.01;
	public static inline var RATE_FREQUENCY : Float = 0.003;
	public static inline var DROPS_AMOUNT : Int = 300;
	private var dropsFrequency : Float = 3;
	
	private var timer : FlxTimer;
	private var timerStarted : Bool;
	private var firstLightning : Bool;
	public var firstThunder : Bool;
	
	public function new() 
	{
		super();

		FlxG.sound.cache("rain");
		
		timer = new FlxTimer();
		timerStarted = false;
		firstLightning = false;
		firstThunder = false;
		
		setSize(FlxG.width, 0);
		acceleration.set(0, 0, 0, 0, -100, 200, -100, 400);
		launchAngle.set(90, 90);
		lifespan.set(2);
		solid = true;
		
		for (i in 0...DROPS_AMOUNT) {
			add(new RainDrop());
		}
		
		start(false, dropsFrequency);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);

		x = cast(Reg.PS, PlayState).player.x - (FlxG.width / 2) + 25;
		
		if (x < 0) 
			x = 0;
		if (x >= TiledLevelLoader.currentTiledMap.fullWidth - FlxG.width) 
			x = TiledLevelLoader.currentTiledMap.fullWidth - FlxG.width;
		
		if (dropsFrequency > MIN_FREQUENCY){
			dropsFrequency -= RATE_FREQUENCY;
			frequency = dropsFrequency;
		} else {
			
			if (!firstLightning){
				
				if (!firstThunder){
					FlxG.sound.play("rain", 1, true);
					firstThunder = true;
					
					new FlxTimer().start(15, function(_){
						cast(Reg.PS, PlayState).theEnd.visible = true;
					});
				}
				
				
				Reg.PS.camera.flash(FlxColor.WHITE, 10, function(){
					firstLightning = true; 
				});
				
				if (cast(Reg.PS, PlayState).sun != null)
					cast(Reg.PS, PlayState).sun.kill();
					
				if (cast(Reg.PS, PlayState).waterWell != null)
					cast(Reg.PS, PlayState).waterWell.animation.play("watering");
					
				Reg.PS.bgColor = FlxColor.GRAY;
			
			}
			
			if (!timerStarted && firstLightning){
				timerStarted = true;
				timer.start(1, function(_){
					var lightningChance = FlxG.random.int(0, 10);
					if (lightningChance == 1){
						Reg.PS.camera.flash(FlxColor.WHITE, 0.3);
					} else if (lightningChance == 2){
						Reg.PS.camera.flash(FlxColor.WHITE, 0.3, function(){
							Reg.PS.camera.flash(FlxColor.WHITE, 0.3);
						});
					}
				
				}, 0);	
			}
			
			
		}
	}
	
}