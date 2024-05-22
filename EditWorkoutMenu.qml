import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.company.mydatabase

Rectangle {
    color: "green"

    property var day

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
            text: "Deleting workouts."
            informativeText: "Are you sure you want to delete all workouts?"
            buttons: MessageDialog.Yes | MessageDialog.No
            onAccepted: Database.deleteWorkouts()
        }

        Repeater {
            id: repeater
            model: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
            Button {
                text: modelData
                implicitWidth: deleteAllButton.implicitWidth
                onClicked: day = modelData
            }
        }

    }

}
