import Toybox.WatchUi;
import Toybox.Timer;

class FlashlightDelegate extends WatchUi.BehaviorDelegate {
    var timer;

    function initialize() {
        BehaviorDelegate.initialize();

        if (timer == null) {
            timer = new Timer.Timer();
            timer.start(method(:doUpdate), 1000, true);
        }
    }

    function doUpdate() {
        WatchUi.requestUpdate();
    }

    function onSelect() {
        gWichColor++;
        if (gWichColor > 2) {
            gWichColor = 0;
        }
        WatchUi.requestUpdate();

        return true;
    }

    function onTap(clickEvent) {
        gWichColor++;
        if (gWichColor > 2) {
            gWichColor = 0;
        }
        WatchUi.requestUpdate();

        return true;
    }
}