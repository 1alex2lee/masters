import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: renamewindow
    width: 300; height: 500
    title: "User-Centirc Software to Assist Design for Forming"
    visible: true

    MenuBar {
        id: menubar
        anchors.left: parent.left
        anchors.right: parent.right

        Menu {
            title: "File"
        }

        Menu {
            title: "Exit"
            Action {
                text: "Exit"
                onTriggered: renamewindow
        .close()
            }
        }
    }

    Text {
        id: title
        text: qsTr("Rename Variables")
        anchors.left: parent.left
        anchors.top: menubar.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 10
    }

    ListView {
        id: varList
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: title.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 30
        model: backend.load_opti_varopts()

        delegate: Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            implicitHeight: 40

            Text {
                id: oldname
                text: model.modelData
                anchors.left: parent.left
                anchors.leftMargin: 10
            }
            TextField {
            id: newname
            width: 80
            height: 20
            anchors.right: parent.right
            anchors.rightMargin: 10
            text: model.modelData
            font.pixelSize: 12
            selectByMouse: true

            onTextEdited: {
                backend.change_opti_var_name(index, oldname.text, newname.text)
                }
            }
        }


    }

    Connections {
        target: backend
    }

}
