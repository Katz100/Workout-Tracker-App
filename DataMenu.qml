import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Dialogs
import com.company.mydata 1.0
import "ListModelFunctions.js" as Backend

Rectangle {
    color: bgColor

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        TextField {
            id: searchField
            placeholderText: "Enter muscle"
            Layout.preferredWidth: parent.width * 0.9
            Layout.topMargin: 5
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 16
        }

        Button {
            text: "Search"
            width: parent.width
            Layout.alignment: Qt.AlignHCenter
            font.pointSize: 16
            Material.background: Material.Green
            onClicked: {
                Backend.getData(searchField.text)
            }
        }

        Rectangle {
            color: "lightgray"
            width: parent.width
            height: 1
        }

        ScrollView {
            id: sv
            height: 0
            Layout.fillHeight: true
            Layout.fillWidth: true
            ListView {
                id: lv
                anchors.fill: parent
                model: dataModel
                spacing: 20
                clip: true
                delegate: Rectangle {
                    width: sv.width * 0.9
                    height: 100
                    border.width: 1
                    border.color: "#DDDDDD"
                    radius: 5
                    color: "#FFFFFF"
                    anchors.horizontalCenter: lv.contentItem.horizontalCenter
                    ColumnLayout {
                        spacing: 10
                        Text {
                            id: nameTxt
                            text: "<b>Name: </b>" + name
                        }
                        Text {
                            id: typeTxt
                            text: "<b>Type: </b>" + type
                        }
                        Text {
                            id: diffTxt
                            text:"<b>Difficulty: </b>" + difficulty
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            instructionDialog.instructionTxt = instructions
                            instructionDialog.exerciseNameTxt = name
                            instructionDialog.open()
                        }
                    }
                }
            }
        }
    }

    InstructionsDialog {
        id: instructionDialog
        width: parent.width * 0.8
        height: parent.height * 0.8
        anchors.centerIn: parent
        onClosed: parent.forceActiveFocus()
    }

    BusyIndicator {
        running: Backend.dataIsEmpty()
        anchors.centerIn: parent
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            loader.source = "Home.qml"
            event.accepted = true
        }
    }

    Component.onCompleted: forceActiveFocus()
}
