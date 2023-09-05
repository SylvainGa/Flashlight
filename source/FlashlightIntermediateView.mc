using Toybox.WatchUi as Ui;
using Toybox.Application.Storage;
using Toybox.Timer;

class FlashlightIntermediateView extends Ui.View {
	var _shown = false;

    function initialize() {
        View.initialize();
    }

    public function onShow() as Void {

		if (!_shown) {
			var waitLaunch = Storage.getValue("waitLaunch");
			if (waitLaunch == null) {
				waitLaunch = true;
				Storage.setValue("waitLaunch", true);
			}

			if (waitLaunch) {
				var timer;
				timer = new Timer.Timer();
				timer.start(method(:viewTimer), 1000, false);
			}
			else {
				viewTimer();
			}
			_shown = true;
		}
    }

	function viewTimer() {
		var thisMenu;
		var thisDelegate;

		//DEBUG*/ logMessage("Creating menu and delegate");
		thisMenu = new FlashlightView();
		thisDelegate = new FlashlightDelegate();

		WatchUi.pushView(thisMenu, thisDelegate, WatchUi.SLIDE_IMMEDIATE);
	}
}
