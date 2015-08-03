import QtQuick 2.0
import Sailfish.Silica 1.0

Item
{
    id: item
    property alias backColor: background.color
    property alias rightColor: rightBorder.color
    property alias leftColor: leftBorder.color
    property alias topColor: topBorder.color
    property alias bottomColor: bottomBorder.color
    property int borderWidth: 2
    Rectangle 
    {
        id: background
        anchors.fill: parent
        //anchors.rightMargin: 2
        //anchors.leftMargin: 2
        //anchors.topMargin: 2
        //anchors.bottomMargin: 2
        opacity: parent.opacity
        radius: 1
    }
    Rectangle 
    {
        id: rightBorder 
        anchors.right: background.right
        height: parent.height 
        width: parent.borderWidth
   }
    Rectangle 
    {
        id: leftBorder 
        anchors.left: background.left
        height: parent.height 
        width: parent.borderWidth
   } 
    Rectangle 
    {
        id: topBorder 
        anchors.top: background.top
        height: parent.borderWidth 
        width: parent.width
   }
     Rectangle 
    {
        id: bottomBorder 
        anchors.bottom: background.bottom
        height: parent.borderWidth 
        width: parent.width
   }  
}