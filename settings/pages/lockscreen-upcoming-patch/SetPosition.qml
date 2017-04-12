import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0

Page 
{
    id: page
    ConfigurationGroup
    {
        id: posSettings
        path: "/desktop/lipstick-jolla-home/lockscreenUpcoming"
        property int xPos: 0
        property int yPos: 0
        property int dateLabelSize: Theme.fontSizeMedium
        property int timeLabelSize: Theme.fontSizeMedium
        property int eventLabelSize: Theme.fontSizeMedium
        property int maxEvents: 5
        property int borderThick: 2
    }

    Column
    {
        spacing: 49
        id: horLines
        Repeater
        {
            model: Math.ceil(page.height/(horLines.spacing+1))

            Rectangle
            {
                width: page.width
                height:1
                color: "yellow"
                opacity: 0.5
            }
        }
    }

    Row
    {
        spacing: 49
        id: verLines
        Repeater
        {  
            model:Math.ceil( page.width/(verLines.spacing+1))
            Rectangle
            {
                width: 1
                height:page.height
                color: "yellow"
                opacity:0.5
            }
        }
    }
    Rectangle
    {
        width: page.width
        height:1
        color: "red"
        opacity: 1.0
        y: page.height/2
    }
    Rectangle
    {
        width: 1
        height:page.height
        color: "red"
        opacity: 1.0
        x: page.width/2
    }

    FineControlBox
    {
        id: fcBox 
        z: 100
        isVisible: false
        anchors.fill: parent
    } 
  
    Rectangle
    {
        id: statBar
        height: Theme.paddingMedium + Theme.paddingSmall + Theme.iconSizeExtraSmall
        width: Screen.width
        color: "transparent"
        border.color: Theme.primaryColor
        Label
        {
            text: "status bar"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        anchors.top: parent.top
    }
    
    Rectangle
    {
        id: clockBox
        height: Theme.fontSizeHuge*2+ Theme.fontSizeLarge*2.1 + Theme.paddingMedium*2
        width: Screen.width*0.5
        color: "transparent"
        border.color: Theme.primaryColor
        Label
        {
            text: "clock"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        anchors.top: statBar.bottom
        anchors.horizontalCenter: statBar.horizontalCenter
    }
            
    Rectangle
     {
        id: rect
        height: posSettings.maxEvents* (Math.max(posSettings.dateLabelSize, posSettings.timeLabelSize) + posSettings.eventLabelSize) + 2*posSettings.borderThick  
        width: 415*Screen.width/540
        x: posSettings.xPos
        y: posSettings.yPos + statBar.height -1
        color: "transparent"
        border.color: Theme.primaryColor
        Label
        {
            text: "Long press for arrows to nudge by 1px"
            width: parent.width - Theme.paddingLarge 
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
            anchors.verticalCenter : parent.verticalCenter 
        }        
        MouseArea
        {   
            anchors.fill: parent          
            drag.target: rect
            onReleased: 
            {
                posSettings.xPos = Math.round(rect.x)
                posSettings.yPos = Math.round(rect.y) - statBar.height + 1
            }
            onPressAndHold:
            {
                fcBox.isVisible = true
                var item = posSettings
                fcBox.initialise (rect)                    
            }
        }
        Rectangle 
        {
            width: 1
            height: 20
           color: "red"
           opacity: 1.0
           anchors
           {
               top: parent.top
               horizontalCenter: parent.horizontalCenter 
            }
        }
        Rectangle
         {
             width: 20
             height: 1
             color: "red"
             opacity: 1.0
             anchors
              {
                left: parent.left
                verticalCenter: parent.verticalCenter 
            }
        }
        Rectangle 
        {
            width: 1
            height: 20
            color: "red"
            opacity: 1.0
            anchors
            {              
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle
        {
            width: 20
            height: 1
            color: "red"
            opacity: 1.0
            anchors
            {
                right: parent.right
                verticalCenter: parent.verticalCenter 
            }
        }
    }
}
    
