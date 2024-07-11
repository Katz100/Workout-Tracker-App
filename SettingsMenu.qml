import QtQuick
import QtQuick.Controls
import QtCore
import QtQuick.Layouts

Rectangle {
    id: settingsMenu
    color: bgColor


    RowLayout {

        Text {
            text: "Select timer sound"
            font.bold: true
            font.pixelSize: 16
        }

        ComboBox {
            model: settingsModel
            textRole: "name"
            currentIndex: settings.soundIndex
            onCurrentIndexChanged: {
                settings.soundIndex = currentIndex
                settings.path = settingsModel.get(currentIndex).path
            }
        }
    }
    Label {
        id: copyright
        text: "Icons by Icons8"
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
    }

    ListModel {
        id: settingsModel
        ListElement {
            name: "Sound 1"
            path: "audio/timer-sound.mp3"
        }
        ListElement {
            name: "Sound 2"
            path: "audio/beep-beep-2.mp3"
        }
        ListElement {
            name: "Sound 3"
            path: "audio/beep-sound-1.mp3"
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            loader.source = "Home.qml"
            event.accepted = true
        }
    }

    Component.onCompleted: forceActiveFocus()

}
