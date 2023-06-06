import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Attention;

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
            if (Attention.hasFlashlightColor(Attention.FLASHLIGHT_COLOR_WHITE)) {
                var result = Attention.setFlashlightMode(Attention.FLASHLIGHT_MODE_ON, {:color => Attention.FLASHLIGHT_COLOR_WHITE, :brightness => intensityArray[gWichColor]});
                if (result == Attention.FLASHLIGHT_RESULT_SUCCESS) {
                    return;
                }
            }
        }

        if (Toybox has :Attention && Attention has :backlight) {
            var intensityArray = [0.3, 0.7, 1.0];
            var failed = false;
            try {
                Attention.backlight(intensityArray[gWichColor]);
            }
            catch (e) {
                failed = true;
            }

            // If we fail, try the older method
            if (failed) {
                try {
                    Attention.backlight(true);
                }
                catch (e) {} // If that one fails, don't crash.
            }
        }

		var width = dc.getWidth();
		var height = dc.getHeight();

        var colorArray = [Graphics.COLOR_DK_GRAY, Graphics.COLOR_LT_GRAY, Graphics.COLOR_WHITE];
        var color = colorArray[gWichColor];

        dc.setColor(color, Graphics.COLOR_BLACK);
        dc.clear();
        dc.fillRectangle(0, 0, width, height);
    }
}
