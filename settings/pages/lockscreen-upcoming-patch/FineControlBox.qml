import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0

Item 
{
    id: fcBox
    ConfigurationGroup
    {
        id: posSettings
        path: "/desktop/lipstick-jolla-home/lockscreenUpcoming"
        property int xPos: 0
        property int yPos: 0
    }

    property bool isVisible
    property Item targetRt 
    
    function initialise( targetRect) 
    {
        targetRt = targetRect
    }

    MouseArea
    {
        height: Screen.height 
        width: Screen.width
        enabled: fcBox.isVisible
        onClicked: isVisible = false
    }
      
    Rectangle 
    {
        width: 300
        height: 300
        color: 'black'
        opacity: 0.3
        visible: fcBox.isVisible
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        Image
        {
            anchors.top: parent.top
            anchors.horizontalCenter:parent.horizontalCenter 
            width: 100
            height: 100
            source: "image://theme/icon-m-up"
            visible: fcBox.isVisible
            MouseArea
            {
                enabled:fcBox.isVisible
                anchors.fill: parent
                onClicked: {
                    posSettings.yPos = posSettings.yPos-1
                    fcBox.targetRt.y = fcBox.targetRt.y-1
                }
            }
        }
        Image
        {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter:parent.horizontalCenter 
            width: 100
            height: 100
            source: "image://theme/icon-m-down"
            visible: fcBox.isVisible
            MouseArea
            {
                enabled:fcBox.isVisible
                anchors.fill: parent
                onClicked: {
                    posSettings.yPos = posSettings.yPos+1
                    fcBox.targetRt.y = fcBox.targetRt.y+1
                }
            }
        }
        Image
        {
            anchors.right: parent.right
            anchors.verticalCenter:parent.verticalCenter 
            width: 100
            height: 100
            source: "image://theme/icon-m-right"
            visible: fcBox.isVisible
            MouseArea
            {
                enabled:fcBox.isVisible
                anchors.fill: parent
                onClicked: {
                    posSettings.xPos = posSettings.xPos+1
                    fcBox.targetRt.x = fcBox.targetRt.x+1
                }
            }
        }
        Image
        {
            anchors.left: parent.left
            anchors.verticalCenter:parent.verticalCenter 
            width: 100
            height: 100
            source: "image://theme/icon-m-left"
            visible: fcBox.isVisible
            MouseArea
            {
                enabled:fcBox.isVisible
                anchors.fill: parent
                onClicked: {
                    posSettings.xPos= posSettings.xPos-1
                    fcBox.targetRt.x = fcBox.targetRt.x-1
                }
            }
        }
    }
}