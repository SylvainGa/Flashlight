import Toybox.Application;
import Toybox.Background;
import Toybox.Lang;
import Toybox.WatchUi;

//(:background)
class FlashlightApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new FlashlightView(), new FlashlightDelegate() ] as Array<Views or InputDelegates>;
    }

    (:glance)
    function getGlanceView() {
        return [ new GlanceView() ];
    }
}

function getApp() as FlashlightApp {
    return Application.getApp() as FlashlightApp;
}