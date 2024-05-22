import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import com.company.mytimer
import com.company.mydatabase

Window {
    id: root
    width: 360
    height: 640
    color: "#77A6EE"
    visible: true
    title: qsTr("Workout Tracker")
    TopBar {
        id: topBar
    }

    Loader {
        id: loader
        anchors {
            top: topBar.bottom
            right: parent.right
            left: parent.left
            bottom: parent.bottom
        }
       source: "Home.qml"
    }


}
