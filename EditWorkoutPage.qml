import QtQuick
import QtQuick.Controls

Rectangle {
    color: "cyan"
    ScrollView {
        id: sv
        width: parent.width
        height: parent.height

        ListView {
            id: lv
            anchors.fill: parent

            model: lm
            delegate: Rectangle {
                color: "lightblue"
                border.width: 2
                width: sv.width
                height: 100

            }


        }
    }
}
