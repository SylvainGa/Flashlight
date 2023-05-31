import Toybox.Graphics;
import Toybox.WatchUi;

var gWichColor = 0;

class FlashlightView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

		var width = dc.getWidth();
		var height = dc.getHeight();

        var colorArray = [Graphics.COLOR_DK_GRAY, Graphics.COLOR_LT_GRAY, Graphics.COLOR_WHITE];
        var color = colorArray[gWichColor];

        dc.setColor(color, Graphics.COLOR_BLACK);
        dc.clear();
        dc.fillRectangle(0, 0, width, height);
    }
}
