import QtQuick
import QtQuick.Controls
import "ListModelFunctions.js" as Backend
import com.company.mytimer

Rectangle {
    id: topBar
    anchors {
        top: parent.top
        right: parent.right
        left: parent.left
    }
    height: 50
    z: 1
    color: "#453999"

    Button {
        id: homeButton
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: 10
        }

        icon.source: "images/icons8-home-24.png"

        onClicked: {
            clear("Home.qml")
        }
    }

    Button {
        id: settingsButton
        anchors {
            left: homeButton.right
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }

        icon.source: "images/icons8-settings-24.png"

        onClicked: {
            clear("")
        }
    }

    function clear(source) {
        lm.clear()
        MyTimer.resetTimer()
        Backend.resetWorkout()
        loader.source = source
    }
}
