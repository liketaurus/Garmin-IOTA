//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi;
using Toybox.Graphics;

class WebRequestView extends WatchUi.View {
    hidden var mMessage = "Press menu button";
    hidden var mModel;
    var IOTA;
    var mNote=" ";
	
    function initialize() {    
        WatchUi.View.initialize();        
        IOTA= new WatchUi.Bitmap({:rezId=>Rez.Drawables.IOTAIcon,:locX=>88,:locY=>30});                
    }

    // Load your resources here
    function onLayout(dc) {
        mMessage = "Touch screen or\npress a button";
    }

    // Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {   	
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        IOTA.draw(dc);                
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2+20, Graphics.FONT_MEDIUM, mMessage, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
        dc.setColor(Graphics.COLOR_LT_GRAY, Graphics.COLOR_WHITE);
        dc.drawText(dc.getWidth()/2, dc.getHeight()/2+70, Graphics.FONT_SYSTEM_XTINY, mNote, Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);               
    }

    // Called when this View is removed from the screen. Save the
    // state of your app here.
    function onHide() {
    }

    function onReceive(args) {
    	mNote="touch to update...";
        if (args instanceof Lang.String) {
            mMessage = args;
        }
        else if (args instanceof Dictionary) {
            var ticker = args.get("ticker");
            var keys = ticker.keys();
                
                mMessage = "";
       		
                mMessage += Lang.format("M$1$ to $2$\n", [ticker[keys[0]], ticker[keys[2]]]);
                var price = Lang.format("$2$\n", [keys[1], ticker[keys[1]]]);
                mMessage += "$"+ price.substring(0,4);
        }
               
        WatchUi.requestUpdate();
    }
}
