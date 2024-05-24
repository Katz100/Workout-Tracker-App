import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "ListModelFunctions.js" as Backend
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
            Layout.preferredWidth: 200
        }

        Button {
            text: "View/Edit Workout(s)"
            Layout.preferredWidth: 200
            onClicked: loader.source = "EditWorkoutMenu.qml"
        }

        Button {
            text: "Add Workout(s)"
            Layout.preferredWidth: 200
            onClicked: loader.source = "AddWorkoutMenu.qml"

        }
    }
}
