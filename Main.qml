import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root
    width: 360
    height: 640
    color: "#77A6EE"
    visible: true
    title: qsTr("Workout Tracker")

    property var day

    ListModel {
        id: lm
    }

    TopBar {
        id: topBar
    }

    Loader {
        id: loader
        anchors {
            top: topBar.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
        source: "Home.qml"
    }



}



