import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Attention;
using Toybox.Application.Storage;

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
        gWichIntensity++;
        if (gWichIntensity > 2) {
            gWichIntensity = 0;
        }
        WatchUi.requestUpdate();

        return true;
    }

    function onNextPage() {
        gWichColor++;
        if (gWichColor > 4) {
            gWichColor = 0;
        }
        WatchUi.requestUpdate();

        return true;
    }

    function onPreviousPage() {
        gWichMode = (gWichMode + 1) & 1;

        WatchUi.requestUpdate();

        return true;
    }

    function onTap(clickEvent) {
        onSelect();
        return true;
    }

    function onSwipe(swipeEvent) {
        var dir = swipeEvent.getDirection();

        switch (dir) {
            case WatchUi.SWIPE_UP:
                onNextPage();
                return true;
            
            case WatchUi.SWIPE_DOWN:
                onPreviousPage();
                return true;
            
            default:
                return false;
        }
    }

    function onHold(click) {
        onMenu();
    }

    function onMenu() {
        if (Attention has :vibrate) {
            var vibeData = [ new Attention.VibeProfile(50, 200) ]; // On for half a second
            Attention.vibrate(vibeData);
        }

        var waitLaunch = Storage.getValue("waitLaunch");
        if (waitLaunch == null) {
            waitLaunch = true;
        }

        waitLaunch = !waitLaunch;

        Storage.setValue("waitLaunch", waitLaunch);
        gDelayChanged = true;
    }
}
