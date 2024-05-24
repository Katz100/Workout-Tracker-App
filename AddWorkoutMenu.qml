import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.company.mydatabase

Rectangle {
    color: "purple"

   ColumnLayout {
       id: col
       spacing: 20
       anchors.centerIn: parent
        ComboBox {
            id: day
            model: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
            Layout.preferredWidth: 200
        }
        TextField {
            id: workoutName
            placeholderText: "Name of workout"
            Layout.preferredWidth: 200
        }
        TextField {
            id: sets
            placeholderText: "Number of sets"
            Layout.preferredWidth: 200
        }
        TextField {
            id: rest
            placeholderText: "Number of rest in seconds"
            Layout.preferredWidth: 200
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
               Database.addWorkout(day.currentText, workoutName.text, parseInt(sets.text), parseInt(rest.text));
           }
       }
   }
}
