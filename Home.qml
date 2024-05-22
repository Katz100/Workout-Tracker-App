import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: "red"
    Text {
        text: "Home page"
    }

    ColumnLayout {
        spacing: 20
        anchors.centerIn: parent
        Button {
            text: "Start Workout"
            Layout.preferredWidth: 100
        }

        Button {
            text: "Edit Workout"
            Layout.preferredWidth: 100
            onClicked: loader.source = "EditWorkoutMenu.qml"
        }

        Button {
            text: "Add Workout"
            Layout.preferredWidth: 100
            onClicked: loader.source = "AddWorkoutMenu.qml"
        }
    }
}
