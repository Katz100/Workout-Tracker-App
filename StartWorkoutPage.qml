import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.company.mydatabase
import com.company.mytimer
import QtMultimedia


import "ListModelFunctions.js" as Backend
Rectangle {
    color: bgColor
    property var currentWorkout: lm.get(Backend.currentWorkoutIndex).workout_name
    property var previousWorkout: Backend.previousWorkout()
    property var nextWorkout: Backend.isEmpty() ? "N/A" : Backend.nextWorkout()
    property int currentSet: Backend.currentSet
    property int currentRest: lm.get(Backend.currentWorkoutIndex).rest
    property int setsCompleted: Backend.setsCompleted
    property int workoutId: lm.get(Backend.currentWorkoutIndex).id

    GridLayout {
        id: grid
        columns: 3
        rowSpacing: 10
        columnSpacing: 10
        anchors {
            top: parent.top
            bottom: gridButtons.top
            left: parent.left
            right: parent.right
        }

        Rectangle {
            color: "#f0f0f0"
            radius: 8
            border.color: "gray"
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignCenter
            Text {
                id: previousExercise
                text: "Previous:\n" + previousWorkout
                anchors.centerIn: parent
                color: "gray"
                font.pixelSize: 16
            }
        }
        Rectangle {
            color: "#d0e1f9"
            radius: 8
            border.color: "#003366"
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignCenter
            Text {
                id: currentWorkoutTxt
                text: currentWorkout
                color: "#003366"
                font.pixelSize: 18
                font.bold: true
                anchors.centerIn: parent

            }
        }
        Rectangle {
            color: "#f0f0f0"
            radius: 8
            border.color: "gray"
            Layout.fillWidth: true
            Layout.preferredHeight: 50
            Layout.alignment: Qt.AlignCenter
            Text {
                id: nexExercise
                anchors.centerIn: parent
                text: "Next:\n" + nextWorkout
                color: "gray"
                font.pixelSize: 16
            }
        }
        Text {
            id: setsTxt
            text: "Set: " + currentSet
            Layout.columnSpan: 3
            Layout.alignment: Qt.AlignCenter
            font.pixelSize: 20
            font.bold: true
            color: "black"
        }

        ProgressBar {
            id: progressBar
            Layout.columnSpan: 3
            Layout.alignment: Qt.AlignCenter
            from: 0
            to: Database.countSets(day)-1
            value: setsCompleted

        }

        CircularSlider {
            id: slider
            interactive: false
            progressColor: "#9930cf"
            value: MyTimer.seconds / currentRest
            Text {
                id: timerText
                text: MyTimer.seconds === 0 ? "▶" : MyTimer.seconds
                anchors.centerIn: parent
                font.pixelSize: 45
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        MyTimer.setTimer(currentRest)
                        MyTimer.pause_timer = false
                    }
                }
            }
            Layout.columnSpan: 3
            Layout.alignment: Qt.AlignCenter
        }

        TextField {
            id: weightUsed
            placeholderText: workoutId
            Layout.columnSpan: 3
            Layout.alignment: Qt.AlignCenter
            font.pixelSize: 14
        }

    }

    GridLayout {
        id: gridButtons
        columns: 2
        rows: 2
        columnSpacing: 10
        rowSpacing: 10
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        Button {
            id: startTimerButton
            text: "Start Timer"
            Layout.preferredWidth: 150
            Layout.alignment: Qt.AlignCenter
            onClicked: {
                MyTimer.setTimer(currentRest)
                MyTimer.pause_timer = false
            }

            MediaPlayer {
                id: playSound
                source: settings.path
                audioOutput: AudioOutput {}
            }


            Connections {
                target: MyTimer
                function onTimerFinished() {
                    playSound.play()
                    Backend.nextSet()
                    MyTimer.resetTimer()
                    if (Backend.isWorkoutFinished()) {
                        workoutFinishedDialog.open()
                    } else {
                        updateText()
                    }
                }
            }
        }

        Button {
            id: pauseTimerButton
            icon.source: MyTimer.pause_timer? "images/icons8-play-48.png" : "images/icons8-pause-button-64.png"
            Layout.preferredWidth: 150
            Layout.alignment: Qt.AlignCenter
            onClicked: MyTimer.pauseStartTimer()
        }

        Button {
            id: previousSetButton
            text: "Previous Set"
            Layout.preferredWidth: 150
            Layout.alignment: Qt.AlignCenter
            onClicked: {
                Backend.previousSet()
                MyTimer.resetTimer()
                MyTimer.pause_timer = false;
                updateText()
            }
        }

        Button {
            id: nextSetButton
            text: "Next Set"
            Layout.preferredWidth: 150
            Layout.alignment: Qt.AlignCenter
            onClicked: {
                if (!Backend.isWorkoutFinished()){
                    Backend.nextSet()
                    MyTimer.pause_timer = false;
                }
                MyTimer.resetTimer()
                if (Backend.isWorkoutFinished()) {
                    workoutFinishedDialog.open()
                } else {
                    updateText()
                }
            }
        }
    }



    MessageDialog {
        id: workoutFinishedDialog
        text: "Workout Finished!"
        buttons: MessageDialog.Ok
        onAccepted: {
            loader.source = "Home.qml"
            close()
        }
    }

    function updateText() {
        currentWorkout = lm.get(Backend.currentWorkoutIndex).workout_name
        currentSet = Backend.currentSet
        currentRest = lm.get(Backend.currentWorkoutIndex).rest
        previousWorkout = Backend.previousWorkout()
        nextWorkout = Backend.nextWorkout()
        setsCompleted = Backend.setsCompleted
        workoutId = lm.get(Backend.currentWorkoutIndex).id
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            lm.clear()
            MyTimer.resetTimer()
            Backend.resetWorkout()
            loader.source = "Home.qml"
            event.accepted = true
        }
    }

    Component.onCompleted: forceActiveFocus()
}


