import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.company.mydatabase
import com.company.mytimer
import QtMultimedia

import "ListModelFunctions.js" as Backend

Rectangle {
    color: "#77A6EE"
    property var currentWorkout: lm.get(Backend.currentWorkoutIndex).workout_name
    property int currentSet: Backend.currentSet
    property int currentRest: lm.get(Backend.currentWorkoutIndex).rest
    ColumnLayout {
        id: col
        spacing: 30
        anchors.centerIn: parent
        Text {
            id: currentWorkoutTxt
            text: currentWorkout
        }
        Text {
            id: setsTxt
            text: "Set: " + currentSet
        }
        Text {
            id: timerText
            text: MyTimer.seconds
        }

        GridLayout {
            rows: 2
            columns: 2
            Button {
                id: startTimerButton
                text: "Start Timer"
                Layout.preferredWidth: 150
                onClicked: {
                    MyTimer.setTimer(currentRest)
                    MyTimer.pause_timer = false
                }

                MediaPlayer {
                    id: playSound
                    source: "audio/timer-sound.mp3"
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
                            currentWorkout = lm.get(Backend.currentWorkoutIndex).workout_name
                            currentSet = Backend.currentSet
                            currentRest = lm.get(Backend.currentWorkoutIndex).rest
                        }
                    }
                }
            }

            Button {
                id: pauseTimerButton
                icon.source: MyTimer.pause_timer? "images/icons8-play-48.png" : "images/icons8-pause-button-64.png"
                Layout.preferredWidth: 150
                onClicked: MyTimer.pauseStartTimer()
            }

            Button {
                id: previousSetButton
                text: "Previous Set"
                Layout.preferredWidth: 150
                onClicked: {
                    Backend.previousSet()
                    MyTimer.resetTimer()
                    currentWorkout = lm.get(Backend.currentWorkoutIndex).workout_name
                    currentSet = Backend.currentSet
                    currentRest = lm.get(Backend.currentWorkoutIndex).rest
                }
            }

            Button {
                id: nextSetButton
                text: "Next Set"
                Layout.preferredWidth: 150
                onClicked: {
                    if (!Backend.isWorkoutFinished()){
                        Backend.nextSet()
                    }
                    MyTimer.resetTimer()
                    if (Backend.isWorkoutFinished()) {
                        workoutFinishedDialog.open()
                    } else {
                        currentWorkout = lm.get(Backend.currentWorkoutIndex).workout_name
                        currentSet = Backend.currentSet
                        currentRest = lm.get(Backend.currentWorkoutIndex).rest
                    }
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
}


