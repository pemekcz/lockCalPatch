import QtQuick 2.0
import Sailfish.Silica 1.0
import org.nemomobile.configuration 1.0

Page {
    id: page
 
    ConfigurationGroup {
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
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: mainCol.height
        //interactive: contentHeight > height 
        Column {
            id: mainCol
            width: parent.width
            spacing: Theme.paddingSmall
            PageHeader {
                title: "Lockscreen Calendar settings"
            }
            SectionHeader {
                text: "Events to show"
            }
            Slider {
                width: parent.width
                label: "Max events"
                maximumValue: 7
                minimumValue: 1
                stepSize: 1
                value: lockscreenUpcomingSettings.maxEvents
                valueText: value

                onValueChanged: lockscreenUpcomingSettings.maxEvents = Math.round(value)
                onPressAndHold: cancel()
            }

           Row {
                width: parent.width
                Label {
                    id: nDaysLabel
                    text: "Show next:"
                     anchors.verticalCenter: nDaysSlider.verticalCenter 
                } 

                Slider {
                    id: nDaysSlider
                    width: 265
                    maximumValue: 31
                    minimumValue: 1
                   stepSize: 1
                   value: lockscreenUpcomingSettings.nDaysForward
                   valueText: value

                   onValueChanged: lockscreenUpcomingSettings.nDaysForward = Math.round(value)
                   onPressAndHold: cancel()
                }
 
                ComboBox {
                   id: dwmComboBox
                   anchors.verticalCenter: nDaysSlider.verticalCenter 
                   //width: parent.width
                   currentIndex: lockscreenUpcomingSettings.daysWeeksMonths 
                   menu: ContextMenu {
                       MenuItem {
                           property int mode: 0
                           text: "Days"
                       }
                       MenuItem {
                           property int mode: 1
                           text: "Weeks" 
                       }
                       MenuItem {
                           property int mode: 2
                           text: "Months"
                       }
                   }
                   onCurrentItemChanged: {
                       if (currentItem) {
                           lockscreenUpcomingSettings.daysWeeksMonths = currentItem.mode
                       }
                   }
               }
            }

            TextSwitch {
                width: parent.width
                text: "Show no events message"
                checked: lockscreenUpcomingSettings.showMessage
                onClicked: lockscreenUpcomingSettings.showMessage = checked
            }

            SectionHeader {
                text: "Background"
            }

            Component {
                id: colorPicker

                ColorPickerPage {
                   id: cpPage

                      colors: ["transparent",Theme.primaryColor,Theme.secondaryColor,Theme.highlightColor,  "#0000FF","#FF0000","#F0F8FF","#FAEBD7","#00FFFF","#7FFFD4","#F0FFFF","#F5F5DC","#FFE4C4","#000000",
                    "#FFEBCD","#8A2BE2","#A52A2A","#DEB887","#5F9EA0","#7FFF00","#D2691E","#FF7F50","#6495ED","#FFF8DC",
                    "#DC143C","#00FFFF","#00008B","#008B8B","#B8860B","#A9A9A9","#006400","#BDB76B","#8B008B","#556B2F",
                    "#FF8C00","#9932CC","#8B0000","#E9967A","#8FBC8F","#483D8B","#2F4F4F","#00CED1","#9400D3","#FF1493",
                    "#00BFFF","#696969","#1E90FF","#B22222","#FFFAF0","#228B22","#FF00FF","#DCDCDC","#E0E0E0","#FFD700",
                    "#DAA520","#808080","#008000","#ADFF2F","#CC5500","#FF69B4","#CD5C5C","#4B0082","#FFFFF0","#F0E68C",
                    "#E6E6FA","#FFF0F5","#7CFC00","#FFFACD","#ADD8E6","#F08080","#E0FFFF","#FAFAD2","#D3D3D3","#90EE90",
                    "#FFB6C1","#FFA07A","#20B2AA","#87CEFA","#778899","#B0C4DE","#FFFFE0","#00FF00","#32CD32","#FAF0E6",
                    "#FF00FF","#800000","#66CDAA","#0000CD","#BA55D3","#9370D8","#3CB371","#7B68EE","#00FA9A","#48D1CC",
                    "#C71585","#191970","#F5FFFA","#FFE4E1","#FFE4B5","#FFDEAD","#000080","#FDF5E6","#808000","#6B8E23",
                    "#FFA500","#FF4500","#DA70D6","#EEE8AA","#98FB98","#AFEEEE","#D87093","#FFEFD5","#FFDAB9","#CD853F",
                    "#FFC0CB","#DDA0DD","#B0E0E6","#800080","#BC8F8F","#4169E1","#8B4513","#FA8072","#F4A460","#2E8B57",
                    "#FFF5EE","#A0522D","#C0C0C0","#87CEEB","#6A5ACD","#708090","#FFFAFA","#00FF7F","#4682B4","#D2B48C",
                    "#008080","#D8BFD8","#FF6347","#40E0D0","#EE82EE","#F5DEB3","#A86363","#F5F5F5","#FFFF00","#9ACD32",
                    ]
                 }
            }
            Rectangle {
                  id: topColorPicker
                  anchors.horizontalCenter: parent.horizontalCenter
                  height: Theme.itemSizeExtraSmall
                  width: Theme.itemSizeExtraSmall
                  radius: Theme.paddingSmall/2
                  color:lockscreenUpcomingSettings.tbrIsTr ? "transparent" :  lockscreenUpcomingSettings.tBorder 
                  border.color: "white"
                  MouseArea {
                            //enabled: enabledSwitch.checked
                      anchors { margins: -Theme.paddingLarge; fill: parent }
                      onClicked:{
                          var page = pageStack.push(colorPicker)

                          page.colorClicked.connect (function(color) { 
                             if(color.a == 0) { 
                                 lockscreenUpcomingSettings.tbrIsTr = true
                             }
                             else {
                                 lockscreenUpcomingSettings.tBorder = color
                                 lockscreenUpcomingSettings.tbrIsTr = false
                             }
                             pageStack.pop()
                         })
                     }
                 }
            } 
            Row {
               anchors.horizontalCenter: parent.horizontalCenter 
               spacing: Theme.paddingLarge
                Rectangle {
                      id: leftColorPicker
                      height: Theme.itemSizeExtraSmall
                      width: Theme.itemSizeExtraSmall
                      radius: Theme.paddingSmall/2
anchors.verticalCenter: middleRec.verticalCenter  
                      color:lockscreenUpcomingSettings.lbrIsTr ? "transparent" : lockscreenUpcomingSettings.lBorder 
                  border.color: "white"
                     MouseArea {
                                //enabled: enabledSwitch.checked
                          anchors { margins: -Theme.paddingLarge; fill: parent }
                          onClicked:{
var page = pageStack.push(colorPicker)

                          page.colorClicked.connect (function(color) { 
                             if(color.a == 0) { 
                                 lockscreenUpcomingSettings.lbrIsTr = true
                             }
                             else {
                                 lockscreenUpcomingSettings.lBorder = color
                                 lockscreenUpcomingSettings.lbrIsTr = false
                             }
                             pageStack.pop()
                         })
                          }
                      }
                }
                Item {
id: middleRec
height: Theme.itemSizeExtraLarge
                      width: 300
Rectangle {
                      id: backRectangle
                      height: Theme.itemSizeExtraLarge
                      width: 300
                      radius: Theme.paddingSmall/2
                      color:lockscreenUpcomingSettings.bgrIsTr ? "transparent" : lockscreenUpcomingSettings.backgroundColor  
                      opacity: 0.3
                }
                BorderRectangle {
                      id: backColorPicker
                      height: Theme.itemSizeExtraLarge
                      width: 300
                      backColor: "transparent"
                      rightColor: lockscreenUpcomingSettings.rbrIsTr ? "transparent" :lockscreenUpcomingSettings.rBorder
                      leftColor: lockscreenUpcomingSettings.lbrIsTr ? "transparent" :lockscreenUpcomingSettings.lBorder
                      topColor: lockscreenUpcomingSettings.tbrIsTr ? "transparent" :lockscreenUpcomingSettings.tBorder
                      bottomColor: lockscreenUpcomingSettings.bbrIsTr ? "transparent" :lockscreenUpcomingSettings.bBorder
                      borderWidth: lockscreenUpcomingSettings.borderThick
                      MouseArea {
                                //enabled: enabledSwitch.checked
                          anchors { margins: -Theme.paddingLarge; fill: parent }
                          onClicked:{
var page = pageStack.push(colorPicker)

                          page.colorClicked.connect (function(color) { 
                             if(color.a == 0) { 
                                 lockscreenUpcomingSettings.bgrIsTr = true
                             }
                             else {
                                 lockscreenUpcomingSettings.backgroundColor = color
                                 lockscreenUpcomingSettings.bgrIsTr = false
                             }
                             pageStack.pop()
                         })
                          }
                      }
                }
Column{
                          y: lockscreenUpcomingSettings.borderThick +  Theme.paddingSmall
width: parent.width
            spacing: Theme.paddingSmall
Row {
                          x: lockscreenUpcomingSettings.borderThick +  Theme.paddingSmall
spacing: Theme.paddingMedium
                      Label {

                          id: dLabel
                          text: "Date:"
                          font.pixelSize:lockscreenUpcomingSettings.dateLabelSize
                          color:  lockscreenUpcomingSettings.dateLabelColor
                      } 

                      Label {
                          //x: Theme.paddingSmall
                          id: tLabel
                          text: "Time"
                          font.pixelSize:lockscreenUpcomingSettings.timeLabelSize
                          color:  lockscreenUpcomingSettings.timeLabelColor
                      } 
}
                      Label {
                          x:lockscreenUpcomingSettings.borderThick + Theme.paddingSmall
                          id: evLabel
                          text: "Event"
                          font.pixelSize:lockscreenUpcomingSettings.eventLabelSize
                          color:  lockscreenUpcomingSettings.eventLabelColor
                      } 
}
}
                Rectangle {
                      id: rightColorPicker
                      height: Theme.itemSizeExtraSmall
                      width: Theme.itemSizeExtraSmall
                      radius: Theme.paddingSmall/2
anchors.verticalCenter: middleRec.verticalCenter 
                      color:lockscreenUpcomingSettings.rbrIsTr ? "transparent" : lockscreenUpcomingSettings.rBorder 
                  border.color: "white" 

                      MouseArea {
                                //enabled: enabledSwitch.checked
                          anchors { margins: -Theme.paddingLarge; fill: parent }
                          onClicked:{
var page = pageStack.push(colorPicker)

                          page.colorClicked.connect (function(color) { 
                             if(color.a == 0) { 
                                 lockscreenUpcomingSettings.rbrIsTr = true
                             }
                             else {
                                 lockscreenUpcomingSettings.rBorder = color
                                 lockscreenUpcomingSettings.rbrIsTr = false
                             }
                             pageStack.pop()
                         })
                           }
                      }
                }
            }

            Rectangle {
                  id: bottomColorPicker
                  anchors.horizontalCenter: parent.horizontalCenter
                  height: Theme.itemSizeExtraSmall
                  width: Theme.itemSizeExtraSmall
                  radius: Theme.paddingSmall/2
                  color:lockscreenUpcomingSettings.bbrIsTr ? "transparent" : lockscreenUpcomingSettings.bBorder 
                  border.color: "white" 
                  MouseArea {
                            //enabled: enabledSwitch.checked
                      anchors { margins: -Theme.paddingLarge; fill: parent  }
                      onClicked:{
                         var page = pageStack.push(colorPicker)

                          page.colorClicked.connect (function(color) { 
                             if(color.a == 0) { 
                                 lockscreenUpcomingSettings.bbrIsTr = true
                             }
                             else {
                                 lockscreenUpcomingSettings.bBorder = color
                                 lockscreenUpcomingSettings.bbrIsTr = false
                             }
                             pageStack.pop()
                         })
                      }
                  }
            }
            Slider {
                width: parent.width
                label: "Border thickness"
                maximumValue: 10
                minimumValue: 1
                stepSize: 1
                value: lockscreenUpcomingSettings.borderThick
                valueText: value

                onValueChanged: lockscreenUpcomingSettings.borderThick = Math.round(value)
                onPressAndHold: cancel()
            }
            SectionHeader {
                text: "Text"
            }
           Grid {
               id: labelCombos
               width: parent.width
columns: 3
Label{
 id: a
 text: "Date"
}
Label{
 id: b
 text: "Time"
}
Label{
 id: c
 text: "Event"
}
            Rectangle {
                  id: dateColorPicker
                  height: Theme.itemSizeExtraSmall
                  width: parent.width/3
                  color: lockscreenUpcomingSettings.dateLabelColor 
                  MouseArea {
                            //enabled: enabledSwitch.checked
                      anchors { margins: -Theme.paddingLarge; fill: parent  }
                      onClicked:{
                         var page = pageStack.push(colorPicker)

                          page.colorClicked.connect (function(color) { 
                                 lockscreenUpcomingSettings.dateLabelColor = color
                             
                             pageStack.pop()
                         })
                      }
                  }
            }
            Rectangle {
                  id: timeColorPicker
                  height: Theme.itemSizeExtraSmall
                  width: parent.width/3
                  color: lockscreenUpcomingSettings.timeLabelColor 
                  MouseArea {
                            //enabled: enabledSwitch.checked
                      anchors { margins: -Theme.paddingLarge; fill: parent  }
                      onClicked:{
                         var page = pageStack.push(colorPicker)

                          page.colorClicked.connect (function(color) { 
                                 lockscreenUpcomingSettings.timeLabelColor = color
                             
                             pageStack.pop()
                         })
                      }
                  }
            }
            Rectangle {
                  id: eventColorPicker
                  height: Theme.itemSizeExtraSmall
                  width: parent.width/3
                  color: lockscreenUpcomingSettings.eventLabelColor 
                  MouseArea {
                            //enabled: enabledSwitch.checked
                      anchors { margins: -Theme.paddingLarge; fill: parent  }
                      onClicked:{
                         var page = pageStack.push(colorPicker)

                          page.colorClicked.connect (function(color) { 
                                 lockscreenUpcomingSettings.eventLabelColor = color
                             
                             pageStack.pop()
                         })
                      }
                  }
            }
 Item{
    width: parent.width / 3
    height: 150
               LabelCombo {
                 id: dateLabel
                 labelToSet: lockscreenUpcomingSettings.dateLabelSize
onCurrentItemChanged:lockscreenUpcomingSettings.dateLabelSize = labelToSet 
               }

}
       Item{
    width: parent.width / 3
    height: 150
        LabelCombo {
                 id: timeLabel
                 labelToSet: lockscreenUpcomingSettings.timeLabelSize
onCurrentItemChanged:lockscreenUpcomingSettings.timeLabelSize = labelToSet 
               }
}
       Item{
    width: parent.width / 3
    height: 150
        LabelCombo {
                 id: eventLabel
                 labelToSet: lockscreenUpcomingSettings.eventLabelSize
onCurrentItemChanged:lockscreenUpcomingSettings.eventLabelSize = labelToSet 
               }
}
}
        }
    }
}
