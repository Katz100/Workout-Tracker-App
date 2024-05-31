import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.company.mydatabase
import "ListModelFunctions.js" as Backend

Rectangle {
    color: "#77A6EE"

    ColumnLayout {
        id: col
        spacing: 20
        anchors.centerIn: parent

        Button {
            id: deleteAllButton
            text: "Delete All Workouts"
            onClicked: msg.open()
        }

        MessageDialog {
            id: msg
            informativeText: "Are you sure you want to delete all workouts?"
            buttons: MessageDialog.Yes | MessageDialog.No
            onAccepted: Database.deleteWorkouts()
        }

        Repeater {
            id: repeater
            model: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            Button {
                text: modelData
                implicitWidth: deleteAllButton.implicitWidth
                onClicked: {
                    day = modelData
                    loader.source = "EditWorkoutPage.qml"
                    Backend.getWorkouts(day)

                }
            }
        }

    }

}
