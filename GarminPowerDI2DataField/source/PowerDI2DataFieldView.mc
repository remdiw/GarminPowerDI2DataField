using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class PowerDI2DataFieldView extends Ui.DataField {
    hidden var fields;
    hidden var lblPowerAvg;
    hidden var lblPower3s;
    hidden var lblSpeed;
    hidden var lblTimer;
    hidden var lblRear;

    function initialize() {
        DataField.initialize();
        //mValue = 0.0f;
        fields = new PowerDi2DataFiels();
        lblPowerAvg = Ui.loadResource( Rez.Strings.LblPowerAvg );
        lblPower3s = Ui.loadResource( Rez.Strings.LblPower3s );
        lblSpeed = Ui.loadResource( Rez.Strings.LblSpeed );
        lblTimer = Ui.loadResource( Rez.Strings.LblTimer );
        lblRear = Ui.loadResource( Rez.Strings.LblRear );
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {
        return true;
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
        fields.compute(info);
        return 1;
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.clear();
        
    	var heigth = dc.getHeight();
    	var width = dc.getWidth();
        var labelOffset = heigth / 40;
        var numberOffset = heigth / 7;
    	var x_left = width / 6 + 5;
    	var x_middle = width / 2;
    	var x_right = width / 6 * 5 - 5;
    	var y_top = 0;
    	var y_middle = heigth / 3;
    	var y_bottom = heigth / 3 * 2;
    	var lblFont = Graphics.FONT_TINY;
    	var valFont = Graphics.FONT_NUMBER_MEDIUM;
    	var justifyCenter = Graphics.TEXT_JUSTIFY_CENTER;

        dc.drawText(x_middle, y_top + labelOffset, lblFont, lblPowerAvg, justifyCenter);
        dc.drawText(x_middle, y_top + numberOffset, valFont,fields.powerAvgStr, justifyCenter);

        dc.drawText(x_left, y_middle + labelOffset, lblFont, lblPower3s, justifyCenter);
        dc.drawText(x_left, y_middle + numberOffset, valFont, fields.power3sStr, justifyCenter);

        dc.drawText(x_middle, y_middle + labelOffset, lblFont,  lblRear, justifyCenter);
        dc.drawText(x_middle, y_middle + numberOffset, valFont, fields.rearStr, justifyCenter);

        dc.drawText(x_right, y_middle + labelOffset, lblFont,  lblSpeed, justifyCenter);
        dc.drawText(x_right, y_middle + numberOffset, valFont, fields.currentSpeedStr, justifyCenter);

	    dc.drawText(x_middle, y_bottom + labelOffset, lblFont, lblTimer, justifyCenter);
        dc.drawText(x_middle, y_bottom + numberOffset , valFont, fields.timerStr, justifyCenter);

		
        drawLines(dc);
		drawBattery(dc);

        return true;
    }

    function drawLines(dc) {
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_WHITE);
        // horizontal lines (2pt thick)
        dc.drawRectangle(0, dc.getHeight() / 3, dc.getWidth(), 2);
        dc.drawRectangle(0, dc.getHeight() / 3 * 2, dc.getWidth(), 2);

        // vertical lines (2pt thick)
        dc.drawRectangle(dc.getWidth() / 3 + 10, dc.getHeight() / 3, 2, dc.getHeight() / 3);
        dc.drawRectangle(dc.getWidth() / 3 * 2 - 10, dc.getHeight() / 3, 2, dc.getHeight() / 3);
    }  
    
    function drawBattery(dc) {
    	var pct = Sys.getSystemStats().battery;
        var color = pct < 25 ?  Graphics.COLOR_RED : (pct < 40 ? Graphics.COLOR_YELLOW : Graphics.COLOR_GREEN);
        dc.setColor(color, Graphics.COLOR_TRANSPARENT);

        var x_topleft = dc.getHeight()/6*5;
        var y_topleft = dc.getWidth()/12*3;
        dc.drawRectangle(x_topleft, y_topleft, 18, 11);
        dc.fillRectangle(x_topleft+18, y_topleft+3, 2, 5);

		dc.fillRectangle(x_topleft+1, y_topleft+1, 16 * pct / 100, 9);
    }
}
