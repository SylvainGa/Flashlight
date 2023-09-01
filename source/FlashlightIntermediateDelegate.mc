using Toybox.WatchUi as Ui;

class FlashlightIntermediateDelegate extends Ui.BehaviorDelegate {
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        return true;
    }
}