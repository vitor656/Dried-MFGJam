package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class DialogueTrigger extends FlxSprite 
{
	
	public var dialogueID : String;
	
	public function new(?X:Float=0, ?Y:Float=0, id:String) 
	{
		super(X, Y);
		
		makeGraphic(8, 16, FlxColor.TRANSPARENT);
		dialogueID = id;
		
	}
	
}