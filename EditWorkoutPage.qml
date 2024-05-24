import QtQuick
import QtQuick.Controls

Rectangle {
    color: "cyan"
    ScrollView {
        id: sv
        width: parent.width
        height: parent.height - (bottomBar.height)
        ListView {
            id: lv
            anchors.fill: parent

            model: lm
            delegate: Rectangle {
                color: "lightblue"
                border.width: 2
                width: sv.width
                height: 100

                Text {
                    id: lmIndex
                    text: index + 1
                    anchors.left: parent.left
                    anchors.leftMargin: 4
                }

                Text {
                    id: lvTxt
                    anchors.centerIn: parent
                    text: workout_name + "\n" + sets + " sets\n" + rest + " rest"
                }
            }
        }
    }

    Rectangle {
        id: bottomBar
        anchors { bottom: parent.bottom; left: parent.left; right: parent.right }
        height: 50
        z: 1
        color: "#453999"

        Button {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 10
            }

            text: "Back"

            onClicked: loader.source = "EditWorkoutMenu.qml"
        }
    }
}
