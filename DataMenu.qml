import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.company.mydata
import "ListModelFunctions.js" as Backend
Rectangle {
    color: bgColor

    ListView {
        id: lv
        anchors.fill: parent
        model: dataModel
        spacing: 20
        delegate: Rectangle{
            width: parent.width
            height: 100
            border.width: 2
             ColumnLayout {
                spacing: 10
                Text {
                    id: nameTxt
                    text: name
                }
                Text {
                    id: typeTxt
                    text: type
                }
                Text {
                    id: diffTxt
                    text: difficulty
                }

            }
        }
    }

    Component.onCompleted: {
        Backend.getData("shoulders")
    }

    BusyIndicator {
        running: Backend.dataIsEmpty()
        anchors.centerIn: parent
    }

}
