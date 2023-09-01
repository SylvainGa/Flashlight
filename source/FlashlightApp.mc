import Toybox.Application;
import Toybox.Background;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Complications;
import Toybox.Attention;
using Toybox.Application.Storage;

//(:background)
class FlashlightApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        if (state != null) {
            if (state.get(:launchedFromComplication) != null) {
                Storage.setValue("SkipIntermediateView", true);
                if (Attention has :vibrate) {
                    var vibeData = [ new Attention.VibeProfile(50, 200) ]; // On for half a second
                    Attention.vibrate(vibeData);
                }
            }
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        if (Storage.getValue("SkipIntermediateView")) { // Swipe gestures only work when launched from Glance for the main view, hence why we need a subview with watches that don't support Glance or not launched from Glance
            Storage.setValue("SkipIntermediateView", false); // In case we stop launching from Glance
            return [ new FlashlightView(), new FlashlightDelegate() ] as Array<Views or InputDelegates>;
        }
        else {
            return [ new FlashlightIntermediateView(), new FlashlightIntermediateDelegate() ] as Array<Views or InputDelegates>;
        }
    }

    (:glance)
    function getGlanceView() {
        Storage.setValue("SkipIntermediateView", true);
        return [ new GlanceView() ];
    }
}

function getApp() as FlashlightApp {
    return Application.getApp() as FlashlightApp;
}