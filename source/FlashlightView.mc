import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Attention;
using Toybox.Application.Storage;

var gWichIntensity = 0;
var gWichMode = 0;
var gWichColor = 0;
var gDelayChanged = false;

class FlashlightView extends WatchUi.View {

    function initialize() {
        View.initialize();

        gWichIntensity = Storage.getValue("wichIntensity");
        if (gWichIntensity == null) {
            gWichIntensity = 0;
        }
        gWichMode = Storage.getValue("whichMode");
        if (gWichMode == null) {
            gWichMode = 0;
        }
        gWichColor = Storage.getValue("wichColor");
        if (gWichColor == null) {
            gWichColor = 0;
        }
    }

    function onHide() {
        if (Toybox has :Attention && Attention has :setFlashlightMode) {
            Attention.setFlashlightMode(Attention.FLASHLIGHT_MODE_OFF, null);
        }

        if (Toybox has :Attention && Attention has :backlight) {
            Attention.backlight(true);
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        var useScreen = $.getProperty("useScreen", 2, method(:validateNumber));

        if (Toybox has :Attention && Attention has :hasFlashlightColor && Attention has :setFlashlightMode && (useScreen & 2)) {
            var intensityArray = [Attention.FLASHLIGHT_BRIGHTNESS_LOW, Attention.FLASHLIGHT_BRIGHTNESS_MEDIUM, Attention.FLASHLIGHT_BRIGHTNESS_HIGH];
            var colorArray = [Attention.FLASHLIGHT_COLOR_WHITE, Attention.FLASHLIGHT_COLOR_RED, Attention.FLASHLIGHT_COLOR_GREEN];
            var modeArray = [Attention.FLASHLIGHT_MODE_ON, Attention.FLASHLIGHT_MODE_STROBE];
            if (gWichColor > 2) {
                gWichColor = 0; // Reset to white if we overflew over our array size
            }
            if (Attention.hasFlashlightColor(colorArray[gWichColor])) {
                var result = Attention.setFlashlightMode(modeArray[gWichMode], {:color => colorArray[gWichColor], :brightness => intensityArray[gWichIntensity]});
            }
        }
        else {
            useScreen = 1;
        }

        if (useScreen & 1) {
            if (Toybox has :Attention && Attention has :backlight) {
                var maxPower = $.getProperty("maxPower", 10, method(:validateNumber)) / 10.0;
                var intensityArray = [maxPower / 3.0, (maxPower * 2.0) / 3.0, maxPower];
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
                case 3:
                    colorArray = [Graphics.COLOR_DK_BLUE, Graphics.COLOR_BLUE];
                    gWichIntensity &= 1;
                    break;
                case 4:
                    colorArray = [Graphics.COLOR_ORANGE, Graphics.COLOR_YELLOW];
                    gWichIntensity &= 1;
                    break;
            }
            var color = colorArray[gWichIntensity];

            dc.setColor(color, Graphics.COLOR_BLACK);
            dc.clear();
            dc.fillRectangle(0, 0, width, height);
        }

        if (gDelayChanged) {
            gDelayChanged = false;
            dc.setColor(Graphics.COLOR_BLACK, color);
			var waitLaunch = Storage.getValue("waitLaunch");
            var text = "Delay " + (waitLaunch ? "On" : "Off");
            dc.drawText(width / 2, height / 2, Graphics.FONT_MEDIUM, text, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        }
    }
}
