using Toybox.Time as Time;
using Toybox.System as Sys;


class PowerDi2DataFiels {
    // last 60 seconds - 'current speed' samples
    hidden var lastPowers = new [3];
    hidden var curPos;
    hidden var power3s;
    hidden var timer;
    
     // public fields - usable after the user calls compute
    var powerAvgStr;
    var power3sStr;
    var currentSpeedStr;
    var timerStr;
    var rearStr;

    
    function initialize() {
        for (var i = 0; i < lastPowers.size(); ++i) {
            lastPowers[i] = 0.0;
        }

        curPos = 0;
    }
    
    function getAverage(a) {
        var count = 0;
        var sum = 0.0;
        for (var i = 0; i < a.size(); i++) {
            if (a[i] != null && a[i] > 0.0) {
                count++;
                sum += a[i];
            }
        }
        if (count > 0) {
            return Math.round(sum / count);
        } 
        return null;
    }    
    
    function compute(info) {
        lastPowers[curPos] = info.currentPower;
        curPos++;
        curPos = curPos % lastPowers.size();
        powerAvgStr = info.averagePower!=null ? Math.round(info.averagePower).format("%1d") : "---";
		power3s = getAverage(lastPowers);
        power3sStr = power3s!=null ? power3s.format("%1d") : "---";
		rearStr = info.rearDerailleurIndex!=null ? info.rearDerailleurIndex.toString() : "-";
		currentSpeedStr = info.currentSpeed!=null ? (Math.round(info.currentSpeed*3600/1000*10)/10).format("%1.1f") : "-.-";
		timer = info.timerTime != null ? info.timerTime /1000 : null;
		timerStr = timer!=null ? Lang.format("$1$:$2$:$3$",[(timer / 3600) % 24,((timer / 60) % 60).format("%02d"),(timer % 60).format("%02d")]) : "--:--:--";
    }    		
}
    