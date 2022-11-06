package options;

import Controls.KeyboardScheme;
import Controls.Control;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;

class OptionsMenu extends MusicBeatState
{
	var selector:FlxText;
	var curSelected:Int = 0;

	var controlsStrings:Array<String> = 
	[
		'Controls', 
		'Preferences', 
		'Misc'
	];
	var descOpt:Array<String> = ['Change Key Binds', 'Change the options of the game in general', 'Change things inside the game'] ;

	var sussyDescription:FlxText;

	private var grpControls:FlxTypedGroup<Alphabet>;
	var versionShit:FlxText;
	override function create()
	{
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('viruz/menuViruzDesat'));
		trace(controlsStrings);

		menuBG.color = 0xff647175;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		grpControls = new FlxTypedGroup<Alphabet>();
		add(grpControls);

		for (i in 0...controlsStrings.length)
		{
				var controlLabel:Alphabet = new Alphabet(0, 50 + (110 * i), controlsStrings[i], true, false);
				// controlLabel.isMenuItem = true;
				// controlLabel.styleMenu = 'centerX';
				// controlLabel.targetY = i;
				controlLabel.screenCenter(X);
				controlLabel.ID = i;
				grpControls.add(controlLabel);
		}


		// versionShit = new FlxText(5, FlxG.height - 18, 0, "Offset (Left, Right): ", 12);
		// versionShit.scrollFactor.set();
		// versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		// add(versionShit);

		sussyDescription = new FlxText(5, FlxG.height - 30, 0, 'Description: ' + descOpt[curSelected], 20);
		sussyDescription.scrollFactor.set();
		sussyDescription.setFormat(Paths.font("pineappleDays.ttf"), 15, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(sussyDescription);

		changeSelection();

		super.create();
	}

	private var X_DESCRIPTION:Float = 0;
	private var WIDTH_ITEM:Float = 0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.BACK)
			FlxG.switchState(new MainMenuState());
		if (controls.UP_P)
			changeSelection(-1);
		if (controls.DOWN_P)
			changeSelection(1);
		
		if (controls.RIGHT_P)
		{
			FlxG.save.data.offset++;
		}

		if (controls.LEFT_P)
		{
			FlxG.save.data.offset--;
		}

		versionShit.text = "Offset (Left, Right): " + FlxG.save.data.offset;

		if (controls.ACCEPT)
		{
			if (curSelected == 0)
				FlxG.switchState(new ControlMenu());
		}
	}

	var isSettingControl:Bool = false;

	function changeSelection(change:Int = 0)
	{		
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = grpControls.length - 1;
		if (curSelected >= grpControls.length)
			curSelected = 0;

		sussyDescription.text = 'Description: ' + descOpt[curSelected];
		// selector.y = (70 * curSelected) + 30;

		var bullShit:Int = 0;

		for (item in grpControls.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}
	}
}
