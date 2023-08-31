import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Attention;

class PomodoroTimerDelegate extends WatchUi.BehaviorDelegate {
    private static var cycles = 1;
    private static var focusCycleTime = 1500;
    private static var restCycleTime = 300;
    private static var longRestCycleTime = 1200;
    var profile = new Attention.VibeProfile(200, 1250);
    private var _currentTime = 0;
    private var _currentCycle = cycles;

    private var _timer;
    private var _view = getView();

    private var _inProgress = false;


    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {
        _view.setCycleType(_currentCycle);
        if (_inProgress == false) {
            _inProgress = true;
            startCountdown();
        }
        else {
            _inProgress = false;
            _timer.stop();
        }

        return true;
    }

    function startCountdown() as Void{
        if (_currentTime == 0) {
            _view.updateCyclesValue(_currentCycle);
            if (_currentCycle != 0 && _currentCycle % 8 == 0) {
                _currentTime = longRestCycleTime;
            }
            else if (_currentCycle % 2 == 0) {
                _currentTime = restCycleTime;
            }
            else {
                _currentTime = focusCycleTime;
            }
        }
        _timer = new Timer.Timer();
        _timer.start(method(:updateCountdownValue), 1000, true);
    }


    function updateCountdownValue() as Void{
        if (_currentTime == 0) {
            _view.updateCyclesValue(_currentCycle);
            _currentCycle++;
            switchCycle();
            return;
        }
        _currentTime--;
        _view.setTimerValue(_currentTime);
    }

    function switchCycle() as Void {
        if (_currentTime == 0) {
            Attention.vibrate([profile]);
            _timer.stop();
            _view.switchCycleType();
            _inProgress = false;
        }
    }
}