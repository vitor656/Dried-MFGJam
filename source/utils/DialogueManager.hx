package utils;

import flixel.addons.text.FlxTypeText;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxTimer;
import flixel.FlxState;
import flixel.FlxBasic;
import utils.ControlsManager;
import flixel.util.FlxColor;

/*

How to use it:

Declare a Dialogue variable in the Main State class 

Ex:
_dialogue = new Dialogue();
add(_dialogue);
_dialogue.startDialogue(this, "teste");

*/

// Add this manager to the current State to manage messages properly
class DialogueManager extends FlxBasic
{

    public inline static var DELAY_NORMAL:Float = 0.02;
    public inline static var DELAY_FAST:Float = 0.02;

    public inline static var BOX_OFFSET:Int = 5;
    public inline static var FONT_SIZE:Int = 8;
	
	public var dialogueFinished : Bool = false;

    public var _typeText : FlxTypeText;
    public var _messageBox : FlxSprite;
    private var _messages : Array<String>;
    private var _currentIndex : Int;
    private var currentMessage : String;
    private var loadedDialogueId : String;

    private var isComplete : Bool;
    
    public function new()
    {
        super();
		
		loadDialogueReceiver(false);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if(_typeText != null){  
            if(isComplete){
                if(ControlsManager.justPressedConfirm())
                    loadNextmessage();
            } else {
				/*
                if(ControlsManager.pressedConfirm())
                    _typeText.delay = DELAY_FAST;
                else
                    _typeText.delay = DELAY_NORMAL;
				*/
            }
        }
    }

    public function loadDialogueReceiver(onBox:Bool)
    {
        if(onBox){
            _typeText = new FlxTypeText(0, 0, Std.int(FlxG.width * 0.8) - (BOX_OFFSET * 2), "", FONT_SIZE, true);       
        } else {
			if (_typeText != null){
				_typeText.reset(0, 0);
			} else{
				_typeText = new FlxTypeText(0, 0, Std.int(FlxG.width/2), "", FONT_SIZE, true);
			}
            
            //_typeText.screenCenter();
			//_typeText.y = FlxG.height * 0.2;
        }

        _typeText.skipKeys = [];
        _typeText.scrollFactor.set(0, 0);

    }

    public function startDialogue(?state:FlxState, ?id:String, ?onBox:Bool = true)
    {
		dialogueFinished = false;
		
        if(_typeText == null || !_typeText.alive){
            loadDialogueReceiver(onBox);
        }

        if(id != null && id != ""){
            loadDialogue(id);
        }

        if(_typeText != null){

            if(onBox){

                //Build dialogue box
                _messageBox = new FlxSprite(0, 0);
                _messageBox.makeGraphic(Std.int(FlxG.width * 0.8), Std.int(FlxG.height * 0.3), FlxColor.BLACK);
                _messageBox.screenCenter();
                _messageBox.y = (FlxG.height - _messageBox.height) - 10;
                _messageBox.scrollFactor.set(0, 0);

                _typeText.x = _messageBox.x + BOX_OFFSET;
                _typeText.y = _messageBox.y + BOX_OFFSET;
                _typeText.width = _messageBox.width - (BOX_OFFSET * 2);

                state.add(_messageBox);
            }

            //Adiciona somente se carregou a lista de mensagens pela primeira vez
            if(_currentIndex == 0)
                state.add(_typeText);
           
            if(_messages != null && _messages.length > 0){
                isComplete = false;
                _typeText.resetText(currentMessage);
                _typeText.start(DELAY_NORMAL, false, false, onCompleteWait);
            } else {
                trace("No messages loaded...");
            }
        }
    }

    private function keepDialogueGoing()
    {
        if(_messages != null && _messages.length > 0){
            isComplete = false;
            _typeText.resetText(currentMessage);
            _typeText.start(DELAY_NORMAL, false, false, onCompleteWait);
        } else {
            trace("No messages loaded...");
        }
    }

    // Load messages from some kind of file maybe?
    public function loadDialogue(id:String)
    {
        _messages = new Array<String>();

        switch(id){
            case "intro":
                _messages.push("It's been a while...");
                _messages.push("Sometimes I feel like I cannot breath");
                _messages.push("And sometimes it feels so hot...");
				_messages.push("...that I forget that I exist in a real world");
				_messages.push("with real people");
				_messages.push("that I never actually see.");
				_messages.push("I'm hungry...");
				_messages.push("thirsty...");
				_messages.push("of myself...");
			case "1":
				_messages.push("We need water.");
				_messages.push("For me and Whale....that's her name.");
				_messages.push("So we decided to check the well.");
			case "2":
				_messages.push("Maybe there is some hope.");
				_messages.push("Some of those things people of faith talk about.");
				_messages.push("An elixir.");
			case "3": 
				_messages.push("I don't know much about it. It's pretty complex.");
				_messages.push("Don't think about it...");
				_messages.push("Just do stuff. Whatever it is...");
			case "4":
				_messages.push("I'm not done yet");
				_messages.push("but I've lived it");
				_messages.push("for this event.");
				_messages.push("I'm tired...");
			case "5":
				_messages.push("Whale looks tired as well");
				_messages.push("but she has what is needed");
				_messages.push("the thinking of not needing at all.");
			case "6":
				_messages.push("Just a bit of water...");
				_messages.push("to think better, right?");
				_messages.push("We'll be fine.");
			case "start_last":
				_messages.push("We did it.");
				_messages.push("We have found the well.");
				_messages.push("Maybe it is full of life.");
				_messages.push("So I can go back to focus on really essential stuff.");
				_messages.push("All the work I haven't done...");
				_messages.push("All the dreams I have forgotten...");
				_messages.push("Myself.");
			case "end_last":
				_messages.push("Well...");
				_messages.push("It's empty.");
				_messages.push("There is nothing in here.");
				_messages.push("Only what is left of my hope.");
				_messages.push("I can't do it anymore.");
				_messages.push("...");
        }

        _currentIndex = 0;
        loadedDialogueId = id;
        currentMessage = _messages[_currentIndex];
    }

    public function onCompleteWait():Void
    {
        new FlxTimer().start(3, function(_){

            loadNextmessage();

        });
    }

    public function onCompleteClick():Void
    {
        isComplete = true;
    }

    private function loadNextmessage(){
        if(_messages != null && _typeText != null){
            _currentIndex++;
            if(_currentIndex < _messages.length){
                currentMessage = _messages[_currentIndex];
                keepDialogueGoing();
            } else {
				dialogueFinished = true;
                _typeText.kill();
                if(_messageBox != null)
                    _messageBox.destroy();
            }
        }
    }
	
	public function setTypeTextPosition(x : Float, y : Float) : Void
	{
		if (_typeText != null){
			_typeText.setPosition(x, y);
		}
	}

}