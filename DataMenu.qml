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
            color: "#333333"
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
            color: "gray"
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
                            text: name
                        }
                        Text {
                            id: typeTxt
                            text: type
                        }
                        Text {
                            id: diffTxt
                            text: difficulty
                        }
                    }
                }
            }
        }
    }

    BusyIndicator {
        running: Backend.dataIsEmpty()
        anchors.centerIn: parent
    }


}
