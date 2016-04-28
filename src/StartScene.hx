import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import flash.text.TextFormatAlign;

import BoardScene;

class StartScene extends Scene
{
    private var title:Entity;
    private var description:Entity;

    public function new()
    {
        super();
    }

    public override function begin()
    {
        var textOptions = {size: 50, align: TextFormatAlign.CENTER};
        var text = new Text("Tic Tac Toe", 0, 0, 640, 0, textOptions);
        title = addGraphic(text, 0, 0, 50);

        var desc_text = "Circle goes first, then is cross' turn.\n\n" +
            "Make three circles or crosses in a row for you to win.\n\n\n" +
            "Press SPACE to continue...";
        var textOptions = {size: 24, wordWrap: true};
        var text = new Text(desc_text, 0, 0, 600, 0, textOptions);
        description = addGraphic(text, 0, 20, 150);
    }

    public override function update()
    {
        if (Input.check(Key.SPACE)) {
            HXP.scene = new BoardScene();
        }
    }
}
