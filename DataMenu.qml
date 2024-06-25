import QtQuick
import com.company.mydata
import "ListModelFunctions.js" as Backend
Rectangle {
    color: bgColor

    ListView {
        id: lv
        anchors.fill: parent
        model: dataModel
        delegate: Rectangle{
            width: 50
            height: 50
            Text {
                text: name
            }
        }
    }

    Component.onCompleted: {
        Backend.getData("biceps")
    }
}
