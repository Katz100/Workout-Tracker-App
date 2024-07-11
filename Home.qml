import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    color: bgColor


    ColumnLayout {
        spacing: 20
        anchors.centerIn: parent

        Label {
            id: lbl
            text: "<b>Workout Tracker</b>"
            font.pixelSize: 25
            font.family: "serif"
            Layout.alignment: Qt.AlignCenter
            Layout.bottomMargin: 50
        }

        Image {
            source: "images/icons8-dumbell-100.png"
            Layout.alignment: Qt.AlignCenter
        }


        Button {
            Layout.preferredWidth: 200
            Layout.preferredHeight: 60
            onClicked: loader.source = "StartWorkoutMenu.qml"
            RowLayout {
                anchors.fill: parent
                Image {
                    source: "images/icons8-start-50.png"
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 40
                    Layout.leftMargin: 5
                }

                Label {
                    text: "Start Workout"
                    Layout.alignment: Qt.AlignVCenter
                    font.bold: true
                }
            }
        }



        Button {
            id: editWorkoutButton
            Layout.preferredWidth: 200
            Layout.preferredHeight: 60
            onClicked: loader.source = "EditWorkoutMenu.qml"
            RowLayout {
                anchors.fill: parent
                Image {
                    source: "images/icons8-edit-50.png"
                    Layout.preferredHeight: 40
                    Layout.preferredWidth: 40
                    Layout.leftMargin: 10
                }

                Label {
                    text: "View/Edit Routine"
                    Layout.alignment: Qt.AlignVCenter
                    font.bold: true
                }
            }
        }

        Button {
            id: addWorkoutButton
            Layout.preferredWidth: 200
            Layout.preferredHeight: 60
            onClicked: loader.source = "AddWorkoutMenu.qml"
            RowLayout {
                anchors.fill: parent
                Image {
                    source: "images/icons8-add-50.png"
                }

                Label {
                    text: "Add Exercise"
                    Layout.alignment: Qt.AlignVCenter
                    font.bold: true
                }
            }
        }

        Button {
            id: findWorkoutButton
            Layout.preferredWidth: 200
            Layout.preferredHeight: 60
            onClicked: {
                loader.source = "DataMenu.qml"
            }
            RowLayout {
                anchors.fill: parent

                Image {
                    source: "images/magnifying-glass.png"
                }

                Label {
                    text: "Find Exercise"
                    Layout.alignment: Qt.AlignVCenter
                    font.bold: true
                }
            }
        }
    }
}
