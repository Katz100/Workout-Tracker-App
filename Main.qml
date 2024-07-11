import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCore
Window {
    id: root
    width: 360
    height: 640
    color: bgColor
    visible: true
    title: qsTr("Workout Tracker")

    property var day
    property string bgColor: "white"
    property string barColor: "#5F5C6D"

    Settings {
        id: settings
        property string path: "audio/timer-sound.mp3"
        property int soundIndex: 0
    }

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



