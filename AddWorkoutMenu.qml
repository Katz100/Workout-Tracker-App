import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.company.mydatabase

Rectangle {
    color: "#77A6EE"

    property bool isFine: true
   ColumnLayout {
       id: col
       spacing: 20
       anchors.centerIn: parent
        ComboBox {
            id: day
            model: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            Layout.preferredWidth: 250
        }
        TextField {
            id: workoutName
            placeholderText: "Name of workout"
            Layout.preferredWidth: 250
        }
        TextField {
            id: sets
            placeholderText: "Number of sets"
            Layout.preferredWidth: 250
            validator: IntValidator{bottom: 1; top: 999;}
        }
        TextField {
            id: rest
            placeholderText: "Number of rest in seconds"
            Layout.preferredWidth: 250
            validator: IntValidator{bottom: 1; top: 999;}
        }
    }

   RowLayout {
       spacing: 20
       anchors.top: col.bottom
       anchors.horizontalCenter: parent.horizontalCenter
       anchors.topMargin: 20
       Button {
           id: backButton
           text: "Back"
           onClicked: loader.source = "Home.qml"
           implicitWidth: addWorkoutButton.implicitWidth
       }

       Button {
           id: addWorkoutButton
           text: "Add Workout"
           onClicked: {
               if (workoutName.length == 0 || sets.length == 0 ) {
                   isFine = false
                   okDialog.open()
               }
               else {
               Database.addWorkout(day.currentText, workoutName.text, parseInt(sets.text), parseInt(rest.text));
                   isFine = true
                   okDialog.open()
               }
           }
       }
       MessageDialog {
          id: okDialog
          text: isFine ? "Workout added." : "Error adding workout."
          buttons: MessageDialog.Ok
          onAccepted: close()
       }

   }
}
