import QtQuick 2.0
import Sailfish.Silica 1.0
            ComboBox {
               function getIndex( labelSize)
{
switch(labelSize) {
                             case  Theme.fontSizeExtraSmall: return 0
                             case  Theme.fontSizeSmall: return 1  
                             case  Theme.fontSizeMedium: return 2  
                             case  Theme.fontSizeLarge: return 3  
                             case  Theme.fontSizeExtraLarge: return 4
}
} 

                   id: dateComboBox
                   property int labelToSet 
                
                   currentIndex: getIndex(labelToSet)  
                   menu: ContextMenu {
                       MenuItem {
                           property int mode: Theme.fontSizeExtraSmall
                           text: "X small"
                       }
                       MenuItem {
                           property int mode: Theme.fontSizeSmall
                           text: "Small" 
                       }
                       MenuItem {
                           property int mode: Theme.fontSizeMedium
                           text: "Medium"
                       }
                       MenuItem {
                           property int mode: Theme.fontSizeLarge
                           text: "Large"
                       }
                       MenuItem {
                           property int mode: Theme.fontSizeExtraLarge
                           text: "X large"
                       }
                   }
                   onCurrentItemChanged: {
                       if (currentItem) {
                           labelToSet  = currentItem.mode
                       }
                   }
               }