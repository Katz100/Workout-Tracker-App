import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
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

        Button {
            id: startTimerButton
            text: "Start Timer"
            Layout.preferredWidth: 200
            onClicked: MyTimer.setTimer(currentRest)

            MediaPlayer {
                id: playSound
                source: "audio/timer-sound.mp3"
                audioOutput: AudioOutput {}
            }
            Connections {
                target: MyTimer
                function onTimerFinished() {
                    playSound.play()
                }
            }
        }

        Button {
            id: nextSetButton
            text: "Next Set"
            Layout.preferredWidth: 200
            onClicked: {
                Backend.nextSet()
                MyTimer.resetTimer()
                currentWorkout = lm.get(Backend.currentWorkoutIndex).workout_name
                currentSet = Backend.currentSet
                currentRest = lm.get(Backend.currentWorkoutIndex).rest
            }
        }
    }

}


