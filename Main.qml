import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root
    width: 360
    height: 640
    color: bgColor
    visible: true
    title: qsTr("Workout Tracker")

    property var day
    property string bgColor: "white"
    property string barColor: "black"
    ListModel {
        id: lm
    }

    ListModel {
        id: dataModel
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
        asynchronous: true

        BusyIndicator {
                 anchors.centerIn: parent
                 running: loader.status == Loader.Loading
            }

    }
}



