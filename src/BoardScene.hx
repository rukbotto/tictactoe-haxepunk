import com.haxepunk.Entity;
import com.haxepunk.Scene;
import com.haxepunk.graphics.Stamp;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import flash.text.TextFormatAlign;

class BoardScene extends Scene
{
    public static inline var BOARD_SIZE:Int = 3;

    private var turnLabel:Entity;
    private var slots:Array<Array<Entity>>;
    private var background:Entity;
    private var turn:String;
    private var hasWon:Bool;
    private var slotsFilled:Int;

    public function new()
    {
        super();
    }

    public override function begin()
    {
        var textOptions = {size: 50, align: TextFormatAlign.CENTER};
        var text = new Text("", 0, 0, 640, 0, textOptions);
        turnLabel = addGraphic(text, 0, 0, 50);

        var xOffset = 170;
        var yOffset = 120;
        var width = 100;
        var height = 100;

        slots = new Array<Array<Entity>>();
        for (i in 0...3)
        {
            var row = new Array<Entity>();
            for (j in 0...3)
            {
                var x = xOffset + (j * width);
                var y = yOffset + (i * height);

                var textOptions = {size: 50, align: TextFormatAlign.CENTER};
                var text = new Text("", 0, 25, width, 0, textOptions);

                var entity = addGraphic(text, 0, x, y);
                entity.setHitbox(100, 100);
                row.push(entity);
            }
            slots.push(row);
        }

        background = addGraphic(new Stamp("graphics/background.png"), 1);

        turn = "O";
        hasWon = false;
        slotsFilled = 0;
    }

    public override function update()
    {
        var wasTurnChanged = false;

        if (Input.mousePressed && !hasWon)
        {
            var mouseX = Input.mouseX;
            var mouseY = Input.mouseY;

            for (i in 0...BOARD_SIZE)
            {
                for (j in 0...BOARD_SIZE)
                {
                    var entity = slots[i][j];
                    var text = cast(entity.graphic, Text);

                    var hasCollided = entity.collidePoint(
                        entity.x, entity.y, mouseX, mouseY);

                    if (hasCollided && text.text == "")
                    {
                        text.text = turn;
                        wasTurnChanged = true;
                        slotsFilled += 1;
                    }
                }
            }

        }

        for (i in 0...BOARD_SIZE)
        {
            var rLine = 0;
            var cLine = 0;
            var sLine = 0;
            var bsLine = 0;

            for (j in 0...BOARD_SIZE)
            {
                var rText = cast(slots[i][j].graphic, Text);
                var cText = cast(slots[j][i].graphic, Text);
                var bsText = cast(slots[j][j].graphic, Text);
                var si = (BOARD_SIZE - 1) - j;
                var sText = cast(slots[si][j].graphic, Text);

                if (rText.text == turn) rLine += 1;
                if (cText.text == turn) cLine += 1;
                if (bsText.text == turn) bsLine += 1;
                if (sText.text == turn) sLine += 1;

                if (rLine == BOARD_SIZE || cLine == BOARD_SIZE ||
                    sLine == BOARD_SIZE || bsLine == BOARD_SIZE)
                {
                    hasWon = true;
                }
            }
        }

        if (wasTurnChanged && !hasWon)
        {
            if (turn == "O") turn = "X" else turn = "O";
        }

        var text = cast(turnLabel.graphic, Text);
        text.text = "It's \"" + turn + "\" turn";

        if (hasWon) text.text = "\"" + turn + "\" won!";
        if (slotsFilled == Math.pow(BOARD_SIZE, 2)) text.text = "It's a draw!";
    }
}
