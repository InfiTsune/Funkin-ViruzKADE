package options;

import flixel.FlxG;

class ControlMenu extends MusicBeatState {
    public function new()
    {
        super();
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.BACK)
        {
            FlxG.switchState(new OptionsMenu());
        }
    }
}