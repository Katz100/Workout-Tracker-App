import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Dialog {
    id: root
    property alias instructionTxt: instrTxt.text
    property alias exerciseNameTxt: nameTxt.text
    standardButtons: Dialog.Ok
    signal okPressed()


    TextEdit {
        id: nameTxt
        readOnly: true
        anchors {
            top: parent.top
            left: parent.left
        }
    }

    RowLayout {
        id: row
        anchors {
            top: nameTxt.bottom
            left: parent.left
            right: parent.right
        }

        Text {
            id: txt
            text: "<b>Instructions</b>"
            font.pixelSize: 18
        }

        Image {
            id: img
            source: "images/icons8-clipboard-24.png"
            Layout.alignment: Qt.AlignRight

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    nameTxt.selectAll()
                    nameTxt.copy()
                    nameTxt.deselect()
                }
            }

        }
    }
    ScrollView {
        anchors {
            top: row.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        TextArea {
            id: instrTxt
            readOnly: true
            font.pixelSize: 16
            wrapMode: "WordWrap"
        }
    }


    onAccepted: {
        root.okPressed()
    }
}
