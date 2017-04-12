import QtQuick 2.0
import Sailfish.Silica 1.0

Label 
{
    property bool allDay
    property date startTime
    property date endTime
    property date activeDay


    function addSuffix(i,todayDate) 
    {

        if((i - todayDate) ==0 ) return qsTrId("calendar-today")
        if((i - todayDate) ==1 ) return qsTrId("calendar-tomorrow")
 
        var j = i % 10
        var k = i % 100
        if (j == 1 && k != 11) return i + "st" 
        if (j == 2 && k != 12) return i + "nd" 
        if (j == 3 && k != 13) return i + "rd" 
        return i + "th" 
    }
    text: 
    {
       var activeDayStart = new Date(activeDay.getFullYear(), activeDay.getMonth(), activeDay.getDate())
        var tomorrow = new Date(activeDayStart)
        tomorrow.setDate(tomorrow.getDate() + 1)

        var _start = startTime
        var _end = endTime

        if (allDay) 
        {
            //% "All day"


            if (_end.getDate() != _start.getDate()) return ( "All day - " +  addSuffix(_end.getDate(),activeDayStart.getDate())  )

            return qsTrId("All day")
        }

        if (_end.getDate() != _start.getDate()) return (Format.formatDate(_start, Formatter.TimeValue) + "-"
                +  addSuffix(_end.getDate(),activeDayStart.getDate()) + ": " + Format.formatDate(_end, Formatter.TimeValue))

        return (Format.formatDate(_start, Formatter.TimeValue) + "-"
                + Format.formatDate(_end, Formatter.TimeValue))
    }
}

