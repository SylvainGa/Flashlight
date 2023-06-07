import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Attention;

var gWichIntensity = 0;
var gWichMode = 0;
var gWichColor = 0;

class FlashlightView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    function onHide() {
        if (Toybox has :Attention && Attention has :setFlashlightMode) {
            Attention.setFlashlightMode(Attention.FLASHLIGHT_MODE_OFF, null);
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        if (Toybox has :Attention && Attention has :hasFlashlightColor && Attention has :setFlashlightMode) {
            var intensityArray = [Attention.FLASHLIGHT_BRIGHTNESS_LOW, Attention.FLASHLIGHT_BRIGHTNESS_MEDIUM, Attention.FLASHLIGHT_BRIGHTNESS_HIGH];
            var colorArray = [Attention.FLASHLIGHT_COLOR_WHITE, Attention.FLASHLIGHT_COLOR_RED, Attention.FLASHLIGHT_COLOR_GREEN];
            var modeArray = [Attention.FLASHLIGHT_MODE_ON, Attention.FLASHLIGHT_MODE_STROBE];
            if (Attention.hasFlashlightColor(colorArray[gWichColor])) {
                var result = Attention.setFlashlightMode(modeArray[gWichMode], {:color => colorArray[gWichColor], :brightness => intensityArray[gWichIntensity]});
                if (result == Attention.FLASHLIGHT_RESULT_SUCCESS) {
                    return;
                }
            }
        }

        if (Toybox has :Attention && Attention has :backlight) {
            var intensityArray = [0.3, 0.7, 1.0];
            var failed = false;
            try {
                Attention.backlight(intensityArray[gWichIntensity]);
            }
            catch (e) {
                failed = true;
            }

            // If we fail, try the older method (although we might have failed because we were on for too long)
            if (failed) {
                try {
                    Attention.backlight(true);
                }
                catch (e) {} // If that one fails, don't crash.
            }
        }

		var width = dc.getWidth();
		var height = dc.getHeight();
        var colorArray;

        switch (gWichColor) {
            case 0:
                colorArray = [Graphics.COLOR_DK_GRAY, Graphics.COLOR_LT_GRAY, Graphics.COLOR_WHITE];
                break;
            case 1:
                colorArray = [Graphics.COLOR_DK_RED, Graphics.COLOR_RED];
                gWichIntensity &= 1;
                break;
            case 2:
                colorArray = [Graphics.COLOR_DK_GREEN, Graphics.COLOR_GREEN];
                gWichIntensity &= 1;
                break;
        }
        var color = colorArray[gWichIntensity];

        dc.setColor(color, Graphics.COLOR_BLACK);
        dc.clear();
        dc.fillRectangle(0, 0, width, height);
    }
}
