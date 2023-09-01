using Toybox.WatchUi as Ui;
using Toybox.Application.Properties;

class FlashlightIntermediateView extends Ui.View {
	var _shown = false;

    function initialize() {
        View.initialize();
    }

    public function onShow() as Void {

		if (!_shown) {
			var thisMenu;
			var thisDelegate;

			//DEBUG*/ logMessage("Creating menu and delegate");
			thisMenu = new FlashlightView();
			thisDelegate = new FlashlightDelegate();

			WatchUi.pushView(thisMenu, thisDelegate, WatchUi.SLIDE_IMMEDIATE);
			_shown = true;
		}
    }
}
