import Toybox.Application;
import Toybox.Background;
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Complications;

//(:background)
class FlashlightApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        if (state != null) {
            if (state.get(:launchedFromComplication) != null) {
                var vibeData = [ new Attention.VibeProfile(50, 200) ]; // On for half a second
                Attention.vibrate(vibeData);				
            }
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new FlashlightView(), new FlashlightDelegate() ] as Array<Views or InputDelegates>;
    }

    // function getServiceDelegate(){
    //     return [ new ServiceDelegate() ];
    // }

    (:glance)
    function getGlanceView() {
        // Background.registerForTemporalEvent(new Time.Duration(60 * 60));

    	// if (Toybox has :Complications) {
        //     var comp = {
        //         :value => 25,
        //         :shortLabel => "FL",
        //         :longLabel => "FLASHLIGHT",
        //         :units => "%",
        //     };
        //     try {
        //         Complications.updateComplication(0, comp);
        //     }
        //     catch (e) {}
        // }
        return [ new GlanceView() ];
    }

    // function onBackgroundData(data) {
    // 	if (Toybox has :Complications) {
    //         var comp = {
    //             :value => 25,
    //             :shortLabel => "FL",
    //             :longLabel => "FLASHLIGHT",
    //             :units => "%",
    //         };
    //         try {
    //             Complications.updateComplication(0, comp);
    //         }
    //         catch (e) {}
    //     }
    // }
}

function getApp() as FlashlightApp {
    return Application.getApp() as FlashlightApp;
}