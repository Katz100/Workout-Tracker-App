import QtQuick
import QtQuick.Controls


Rectangle {
    anchors {
        top: parent.top
        right: parent.right
        left: parent.left
    }
    height: 50
    color: "#453999"

    Button {
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }

        text: "Home"

        onClicked: loader.source = "Home.qml"
    }
}
