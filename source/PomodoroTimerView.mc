import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.Lang;

class PomodoroTimerView extends WatchUi.View {
    private var _typeTitleElement;
    private var _currentTimerElement;
    private var _cyclesDoneElement;

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));

        _typeTitleElement = findDrawableById("type_title");
        _currentTimerElement = findDrawableById("current_timer");
        _cyclesDoneElement = findDrawableById("cycles_done");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function setCycleType(cycleType as Lang.Number) as Void {
        var label = "";
        var color = Graphics.COLOR_WHITE;
        if (cycleType != 0 && cycleType % 8 == 0) {
            label = "LONG REST";
            color = Graphics.COLOR_GREEN;
        }
        else if (cycleType % 2 == 0) {
            label = "REST";
            color = Graphics.COLOR_GREEN;
        }
        else {
            label = "FOCUS";
            color = Graphics.COLOR_ORANGE;
            
        }
        _typeTitleElement.setText(label);
        _typeTitleElement.setColor(color);

        WatchUi.requestUpdate();
    }

    function setTimerValue(value as Lang.Number) as Void {
        var minutes = value/60;
        var seconds = value%60;
        var secondsFormatted = seconds > 9 ? seconds.toString() : "0" + seconds.toString();

        var formattedValue = minutes.toString() + ":" + secondsFormatted;

        _currentTimerElement.setText(formattedValue);

        WatchUi.requestUpdate();
    }

    function updateCyclesValue(cycles as Lang.Number) as Void {
        cycles = (cycles + 1) / 2;
        var ordinalSign = "";
        if (cycles % 100 != 11 && cycles % 100 != 12 && cycles % 100 != 13) {
            if ((cycles % 10 == 1)) {
                ordinalSign = "st";
            }
            else if ((cycles % 10 == 2)) {
                ordinalSign = "nd";
            }
            else if ((cycles % 10 == 3)) {
                ordinalSign = "rd";
            }
            else {
                ordinalSign = "th";
            }

        }
        else {
            ordinalSign = "th";
        }
        //var multipleSign = cycles == 1 ? "" : "s";
        var formattedValue = cycles.toString() + ordinalSign + " cycle";

        _cyclesDoneElement.setText(formattedValue);

        WatchUi.requestUpdate();
    }

    function switchCycleType() as Void {
        _typeTitleElement.setText("SWITCH");
        _typeTitleElement.setColor(Graphics.COLOR_WHITE);
        WatchUi.requestUpdate();
    }

}
