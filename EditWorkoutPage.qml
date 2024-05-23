import QtQuick

Rectangle {
    color: "cyan"

    ListView {
        id: lv
        anchors.fill: parent
        model: lm
        delegate: Text {
            text: "id: " + id.toString() + " "+day + ": " + workout_name + ", sets: " + sets.toString() + ", rest: " + rest.toString()
        }
    }
}
