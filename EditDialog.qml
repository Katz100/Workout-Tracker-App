import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import com.company.mydatabase

Dialog {
    id: root
    property int id: -1
    property string day: "N/A"
    property alias workoutName: wf.text
    property alias sets: sf.text
    property alias rest: rf.text

    standardButtons: Dialog.Ok | Dialog.Cancel

    signal okPressed()

    ColumnLayout {
        spacing: 10

        TextField {
            id: wf
        }

        TextField {
            id: sf
        }

        TextField {
            id: rf
        }

    }

    onAccepted: {
        Database.editWorkout(id, day, wf.text, parseInt(sf.text), parseInt(rf.text))
        root.okPressed()
    }

    onRejected: root.close()

}
