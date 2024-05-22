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
        }
        TextField {
            id: workoutName
            placeholderText: "Name of workout"
        }
        TextField {
            id: sets
            placeholderText: "Number of sets"
        }
        TextField {
            id: rest
            placeholderText: "Number of rest in seconds"
        }
    }

   RowLayout {
       spacing: 20
       anchors.top: col.bottom

       Button {
           id: backButton
           text: "Back"
           onClicked: loader.source = "Home.qml"
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
