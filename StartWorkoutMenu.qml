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
    ColumnLayout {
        id: col
        anchors.centerIn: parent
        spacing: 20
        Repeater {
            id: repeater
            model: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
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
    }

    MessageDialog {
        id: workoutEmptyDialog
        text: "No workouts on this day."
        buttons: MessageDialog.Ok
        onAccepted: close()
    }

    //test on android
    Keys.onReleased: {
        if (event.key == Qt.Key_Back) {
            console.log("Back button captured - wunderbar !")
            event.accepted = true
        }
    }

}
