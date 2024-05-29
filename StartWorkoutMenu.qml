import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import com.company.mydatabase
import com.company.mytimer
import "ListModelFunctions.js" as Backend

Rectangle {
    color: "orange"

    ColumnLayout {
        id: col
        anchors.centerIn: parent
        spacing: 20
        Repeater {
            id: repeater
            model: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
            Button {
                text: modelData
                implicitWidth: 100
                onClicked: {
                    day = modelData
                    Backend.getWorkouts(day)
                    loader.source = "StartWorkoutPage.qml"
                }
            }
        }
    }

}
