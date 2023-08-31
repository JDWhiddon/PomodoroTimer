import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class PomodoroTimerApp extends Application.AppBase {

    private var _view;

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
        _view = new PomodoroTimerView();
        return [ _view, new PomodoroTimerDelegate() ] as Array<Views or InputDelegates>;
    }
    
    function getView() as PomodoroTimerView{
        return _view;
    }
}

function getView() as PomodoroTimerView {
        return Application.getApp().getView();
    }

function getApp() as PomodoroTimerApp {
    return Application.getApp() as PomodoroTimerApp;
}