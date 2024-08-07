import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.company.mydatabase
import "ListModelFunctions.js" as Backend

Rectangle {
    color: bgColor


    Text {
        id: noWorkoutsTxt
        text: lv.model.count === 0 ? "Nothing to show." : ""
    }

    ListView {
        id: lv
        anchors.fill: parent
        anchors.topMargin: 2
        spacing: 10
        model: Database.getRoutines()
        delegate: Rectangle {
            width: parent.width * 0.9
            height: 50
            border.width: 1
            border.color: "#DDDDDD"
            radius: 5
            color: "#FFFFFF"
            anchors.horizontalCenter: lv.contentItem.horizontalCenter
            Text {
                id: routineTxt
                text: modelData
                font.pixelSize: 16
                font.bold: true
                anchors {
                    left: parent.left
                    top: parent.top
                    leftMargin: 5
                    topMargin: 5
                }
            }


            MouseArea {
                anchors.fill: parent

                onClicked: {
                    day = modelData
                    Backend.getWorkouts(modelData)
                    if(Backend.isEmpty()) {
                        workoutEmptyDialog.open()
                    } else {
                        loader.source = "EditWorkoutPage.qml"
                    }
                }
            }
        }
    }

    RoundButton {
        id: addRoutineButton
        width: 80
        height: 80
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        Image {
            id: img
            width: 50
            height: 50
            anchors.centerIn: parent
            source: "images/icons8-plus-24.png"
        }

        onClicked: loader.source = "AddWorkoutMenu.qml"
    }

    /*
        Repeater {
            id: repeater
            model: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            Button {
                text: modelData
                implicitWidth: deleteAllButton.implicitWidth
                onClicked: {
                    day = modelData
                    Backend.getWorkouts(day)
                    if (Backend.isEmpty()) {
                        workoutEmptyDialog.open()
                    } else {
                        loader.source = "EditWorkoutPage.qml"
                    }

                }
            }
        }
        */

    MessageDialog {
        id: workoutEmptyDialog
        text: "No workouts to be shown."
        buttons: MessageDialog.Ok
        onAccepted: close()
    }

    MessageDialog {
        id: msg
        informativeText: "Are you sure you want to delete all workouts?"
        buttons: MessageDialog.Yes | MessageDialog.No
        onAccepted: Database.deleteWorkouts()
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            loader.source = "Home.qml"
            event.accepted = true
        }
    }

    Component.onCompleted: forceActiveFocus()
}
