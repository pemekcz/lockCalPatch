
import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.time 1.0
import org.nemomobile.calendar 1.0
import org.nemomobile.configuration 1.0

Item
{
    ConfigurationGroup 
    {
        id: lockscreenUpcomingSettings
        path: "/desktop/lipstick-jolla-home/lockscreenUpcoming"
        property int maxEvents: 5
        property int nDaysForward: 7
        property int daysWeeksMonths: 0
        property color backgroundColor: "grey"
        property color tBorder: "white"
        property color bBorder: "white"
        property color lBorder: "white"
        property color rBorder: "white"
        property bool bgrIsTr: false
        property bool tbrIsTr: false
        property bool bbrIsTr: false
        property bool lbrIsTr: false
        property bool rbrIsTr: false
        property int borderThick: 2
        
        property int dateLabelSize: Theme.fontSizeMedium
        property int timeLabelSize: Theme.fontSizeMedium
        property int eventLabelSize: Theme.fontSizeMedium
        property color dateLabelColor: Theme.highlightColor
        property color timeLabelColor: Theme.primaryColor
        property color eventLabelColor: Theme.primaryColor
        property bool showMessage: false
        onValueChanged: 
        {
            eventUpdater.update()
        }
    }
    function getHeight ()
    {
        var height
        if( eventList.count> lockscreenUpcomingSettings.maxEvents) height =  eventList.itemHeight*lockscreenUpcomingSettings.maxEvents + 2* lockscreenUpcomingSettings.borderThick
        else if(eventList.count>0) height = eventList.itemHeight*eventList.count+ 2* lockscreenUpcomingSettings.borderThick
        else height =noEvMessage.height + 2* lockscreenUpcomingSettings.borderThick

        return height
    }

    width: 415*Screen.width/540
    height: getHeight()
    anchors.right: parent.right 
    
    Rectangle
    {
        visible: (eventList.count > 0 || lockscreenUpcomingSettings.showMessage) 
        id: background
        anchors.fill: parent
        color:lockscreenUpcomingSettings.bgrIsTr ? "transparent" : lockscreenUpcomingSettings.backgroundColor 
        opacity: lipstickSettings.lowPowerMode ? 0.0 : 0.3
        radius: 1
    }
    BRectangle 
    {
        visible: (eventList.count > 0 || lockscreenUpcomingSettings.showMessage) 
        id: borders
        anchors.fill: parent
        backColor: "transparent"
        rightColor: lockscreenUpcomingSettings.rbrIsTr ? "transparent" : (lipstickSettings.lowPowerMode ?Theme.highlightColor :lockscreenUpcomingSettings.rBorder)
        leftColor: lockscreenUpcomingSettings.lbrIsTr ? "transparent" :(lipstickSettings.lowPowerMode ?Theme.highlightColor :lockscreenUpcomingSettings.lBorder)
        topColor: lockscreenUpcomingSettings.tbrIsTr ? "transparent" :(lipstickSettings.lowPowerMode ?Theme.highlightColor :lockscreenUpcomingSettings.tBorder)
        bottomColor: lockscreenUpcomingSettings.bbrIsTr ? "transparent" :(lipstickSettings.lowPowerMode ?Theme.highlightColor :lockscreenUpcomingSettings.bBorder)
        borderWidth: lockscreenUpcomingSettings.borderThick
    }

    Label
    {
        id: noEvMessage
        x: lockscreenUpcomingSettings.borderThick + Theme.paddingSmall
y:lockscreenUpcomingSettings.borderThick
        width: parent.width
        visible: (eventList.count == 0  && lockscreenUpcomingSettings.showMessage)
        text: getMessage()
        color: lockscreenUpcomingSettings.eventLabelColor
        font.pixelSize: lockscreenUpcomingSettings.eventLabelSize


        function getMessage ()
        {
            var message = "No events for the next "

            if(lockscreenUpcomingSettings.nDaysForward > 1) message = message +  lockscreenUpcomingSettings.nDaysForward +" "

            if(lockscreenUpcomingSettings.daysWeeksMonths == 0) message = message + "day"
            else if(lockscreenUpcomingSettings.daysWeeksMonths == 1) message = message + "week"
            else message = message + "month"

            if(lockscreenUpcomingSettings.nDaysForward > 1) message = message + "s"
            return message
        } 
    }

    WallClock 
    {
        id: wallClock

        // TODO: only update when Switcher is visible
        updateFrequency: WallClock.Day
        onSystemTimeUpdated: 
        {
            eventUpdater.update()
        }
    }
    Item 
    {
        x: lockscreenUpcomingSettings.borderThick + Theme.paddingSmall
y:lockscreenUpcomingSettings.borderThick
        width: parent.width - x
        height: parent.height

        ListModel 
        {
            id: activeAndComing
        }

        Timer 
        {
            id: eventUpdater

            onTriggered: update()

            function update() 
            {
                activeAndComing.clear()

                var now = new Date
                var nextEnding = undefined
                var prevEvent = undefined

                for (var i = 0; i < allEvents.count; ++i) 
                {
                    var occurrence = allEvents.get(i, AgendaModel.OccurrenceObjectRole)
                    var event = allEvents.get(i, AgendaModel.EventObjectRole)

                    if (event.allDay || now < occurrence.endTime && event !== prevEvent) 
                    {
                        prevEvent = event
                        activeAndComing.append({ displayLabel: event.displayLabel, allDay: event.allDay, startTime: occurrence.startTime, endTime: occurrence.endTime, color: event.color })
                        if (!event.allDay && (nextEnding == undefined || occurrence.endTime < nextEnding)) 
                        {
                            nextEnding = occurrence.endTime
                        }
                    }
                }

                if (nextEnding !== undefined)
                {
                    var timeout = Math.max(0, nextEnding.getTime() - now.getTime() + 1000)
                    if (timeout > 0) 
                    {
                        eventUpdater.interval = timeout
                        eventUpdater.start()
                    }
                    else
                    {
                        eventUpdater.stop()
                    }
               }
               else
               {
                    eventUpdater.stop()
                }
            }
        }

        AgendaModel 
        {
            id: allEvents
            startDate: wallClock.time
            onUpdated: eventUpdater.update()

            function getEndDate()
            {
                switch(lockscreenUpcomingSettings.daysWeeksMonths) 
                {
                    case 0:
                    {
                        return  QtDate.addDays(wallClock.time, lockscreenUpcomingSettings.nDaysForward)
                        break
                    }
                    case 1:
                    {
                        return QtDate.addDays(wallClock.time, lockscreenUpcomingSettings.nDaysForward *7)
                        break
                    }
                    case 2:
                    {
                        var addM =lockscreenUpcomingSettings.nDaysForward
                        var addY = 0
                        if (addM >12)
                        {
                            addM = addM - 12
                            addY = 1
                        }
 
                        var endDate = new Date(wallClock.time.getFullYear()+addY, wallClock.time.getMonth() + addM, wallClock.time.getDate())
                        return endDate
                        break
                    }
                }
           
            }
            endDate: getEndDate()
        }

        ListView 
        {
            id: eventList

            property real itemHeight

            clip: true
            model:  activeAndComing
            interactive: false
            width: parent.width
            height: eventList.count> lockscreenUpcomingSettings.maxEvents ? eventList.itemHeight*lockscreenUpcomingSettings.maxEvents : eventList.itemHeight*eventList.count
            //spacing: Theme.paddingSmall
            visible: count > 0
            delegate: LockEItem
            {
                eventName: model.displayLabel
                allDay: model.allDay
                startTime: model.startTime
                endtime: model.endTime
                activeDay: wallClock.time
                color: model.color

                dateLabelColor: lockscreenUpcomingSettings.dateLabelColor
                timeLabelColor: lockscreenUpcomingSettings.timeLabelColor
                eventLabelColor: lockscreenUpcomingSettings.eventLabelColor
                dateLabelSize: lockscreenUpcomingSettings.dateLabelSize
                timeLabelSize: lockscreenUpcomingSettings.timeLabelSize
                eventLabelSize: lockscreenUpcomingSettings.eventLabelSize

                Component.onCompleted: eventList.itemHeight = height  
            }
        }
    }
    function runAnimations()
    {
    var listItems = eventList.count> lockscreenUpcomingSettings.maxEvents ? lockscreenUpcomingSettings.maxEvents :  eventList.count
        for (var i = 0; i < listItems; ++i) 
        {
            eventList.currentIndex = i
eventList.currentItem.runAnimation()
        }
    } 
}
 

