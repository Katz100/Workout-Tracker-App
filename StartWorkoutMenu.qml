import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.company.mydatabase
import com.company.mytimer
import "ListModelFunctions.js" as Backend

Rectangle {
    color: bgColor
    //focus: true

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
                    font.bold: true
                    font.pixelSize: 16
                    anchors {
                        left: parent.left
                        top: parent.top
                        leftMargin: 5
                        topMargin: 5
                    }
                }

                Text {
                    text: "Estimated time: " + Database.findAverage(modelData) + " minutes"
                    anchors {
                        top: routineTxt.bottom
                        left: parent.left
                        leftMargin: 10
                    }
                }


                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        Backend.getWorkouts(modelData)
                        if(Backend.isEmpty()) {
                            workoutEmptyDialog.open()
                        } else {
                            loader.source = "StartWorkoutPage.qml"
                        }
                    }
                }
            }

        }

        /*
        Repeater {
            id: repeater
            model: Database.getRoutines()
            Button {
                text: modelData
                implicitWidth: 200

                onClicked: {
                    day = modelData
                    Backend.getWorkouts(day)
                    if (Backend.isEmpty()) {
                        workoutEmptyDialog.open()
                    } else {
                        loader.source = "StartWorkoutPage.qml"
                    }
                }
            }
        }
        */


    MessageDialog {
        id: workoutEmptyDialog
        text: "No workouts scheduled for this day. Please select a different day or add a workout."
        buttons: MessageDialog.Ok
        onAccepted: close()
    }

    //test on android
    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            console.log("Back button captured - wunderbar !")
            event.accepted = true
        }
    }

}
