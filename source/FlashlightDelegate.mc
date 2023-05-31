import Toybox.WatchUi;

class FlashlightDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
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