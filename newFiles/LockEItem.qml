import QtQuick 2.0
import Sailfish.Silica 1.0

Row {
        id: dataRow
        width: parent.width
        property alias dateLabelColor: dateLabel.color
        property alias timeLabelColor: timeLabel.color
        property alias eventLabelColor: nameLabel.color
        property alias dateLabelSize: dateLabel.font.pixelSize
        property alias timeLabelSize: timeLabel.font.pixelSize
        property alias eventLabelSize: nameLabel.font.pixelSize

    property alias eventName: nameLabel.text
    property alias allDay: timeLabel.allDay
    property alias startTime: timeLabel.startTime
    property alias endtime: timeLabel.endTime
    property alias activeDay: timeLabel.activeDay
    property alias color: rectangle.color
    spacing: Theme.paddingSmall

    Connections {
        target: lockScreen
        onLockedChanged: {
           if (!lockScreen.locked) scrollAnimation.stop()
        }
    }

    Rectangle 
    {
        id: rectangle

        radius: Theme.paddingSmall/3
        width: Theme.paddingSmall
        height: parent.height - Theme.paddingSmall/2
        anchors.verticalCenter: parent.verticalCenter
    }
    Column
    {
       id: dataCol
       spacing: -Theme.paddingSmall
       Row 
       {
            id: labelRow
            spacing: Theme.paddingSmall

            Label 
            {
               id: dateLabel
    
               function fdw(d) 
               {
                  var t = new Date
                  var t2 = new Date(d)
                  var today = new Date(t.getFullYear(), t.getMonth(), t.getDate())
                  var day = new Date(t2.getFullYear(), t2.getMonth(), t2.getDate())
                  var delta = (day - today) / 86400000
                  if (delta == 0) return qsTrId("Today")
                  else if (delta == 1) return qsTrId("Tomorrow")
                  else return capitalize(Qt.formatDate(d, qsTrId("d MMM")))
              }

              function capitalize(string)
              {
                  return string.charAt(0).toUpperCase() + string.substr(1)
              }

              text: fdw(startTime) + ":"
            }
            LockTLabel 
            {
                id: timeLabel
            }
        }
        Label 
        {
            id: nameLabel
            width: contentWidth
        }
    }
    function runAnimation()
{
scrollAnimation.initialise(nameLabel,dataRow.width  - nameLabel.width - Theme.paddingLarge)
if(nameLabel.width + Theme.paddingLarge - dataRow.width > 0 ) scrollAnimation.start()
}

        SequentialAnimation
        {
            id: scrollAnimation
            function initialise(targetItem, offset) 
            {
                target = targetItem
                range = offset
            }

            property Item target
            property real range

            loops: 3
        PauseAnimation { duration: 1000 }
            PropertyAnimation
            {
               target: scrollAnimation.target
               property: "x"
               duration:  -scrollAnimation.range*20
               to: scrollAnimation.range 
            }
            PropertyAnimation
            {
               target: scrollAnimation.target

               duration: -scrollAnimation.range * 20
               property: "x"
               to:0
            }
        }
}
