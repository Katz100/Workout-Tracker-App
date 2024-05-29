import QtQuick
import QtQuick.Controls
import "ListModelFunctions.js" as Backend
import com.company.mydatabase

Rectangle {
    color: "cyan"

    EditDialog {
        id: editDialog
        onOkPressed: Backend.getWorkouts(day)
        anchors.centerIn: parent
    }

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

        Text {
            anchors.centerIn: parent
            text: "<b>Estimated workout time: " + Backend.estimateWorkout(day) + "</b>"
            font.pointSize: 14
        }
    }


}
