import QtQuick
import QtQuick.Controls
import "ListModelFunctions.js" as Backend
import com.company.mydatabase

Rectangle {
    id: editMenu
    color: bgColor
    property real workoutTime: Backend.estimateWorkout(day)

    EditDialog {
        id: editDialog
        onOkPressed: {
            workoutTime = Backend.estimateWorkout(day)
            var updatedWorkout = Database.findWorkout(editDialog.id)
            Backend.updateListModel(editDialog.index, updatedWorkout)
            editMenu.forceActiveFocus()
        }
        anchors.centerIn: parent
    }

    ScrollView {
        id: sv
        width: parent.width
        height: parent.height - (bottomBar.height)
        ListView {
            id: lv
            anchors.fill: parent
            spacing: 1
            model: lm
            delegate: Rectangle {
                color: "#FFFFFF"
                border.width: 1
                border.color: "#DDDDDD"
                radius: 5
                width: sv.width * 0.9
                height: 100
                anchors.horizontalCenter: lv.contentItem.horizontalCenter


                Image {
                    id: trashcan
                    source: "images/trashcan.jpg"
                    width: 30
                    height: 30

                    anchors {
                        right: parent.right
                        rightMargin: 20
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            Database.deleteWorkoutAt(id)
                            workoutTime = Backend.estimateWorkout(day)
                            lm.remove(index)
                        }
                    }
                }

                Image {
                    id: edit
                    source: "images/edit.png"
                    width: 30
                    height: 30

                    anchors {
                        right: parent.right
                        top: trashcan.bottom
                        rightMargin: 20
                        topMargin: 10
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            //  delegate index
                            lv.currentIndex = index
                            editDialog.index = lv.currentIndex
                            editDialog.day = day
                            editDialog.id = id
                            editDialog.workoutName = workout_name
                            editDialog.sets = sets
                            editDialog.rest = rest
                            editDialog.open()
                        }
                    }
                }

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
        color: barColor

        Button {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 10
            }

            text: "Back"
            onClicked: loader.source = "EditWorkoutMenu.qml"
        }

        Text {
            anchors.centerIn: parent
            text: "<b>Estimated workout time: " + workoutTime + "</b>"
            color: "white"
            font.pointSize: 14
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            loader.source = "EditWorkoutMenu.qml"
            event.accepted = true
        }
    }

    Component.onCompleted: forceActiveFocus()
}
