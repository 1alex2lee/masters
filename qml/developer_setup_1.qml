import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls
 import Qt.labs.platform

Item {
    id: developersetupItem
    width: 400
    height: 400
    Component.onCompleted: {
        window.width = width
        window.height = height
        window.x = Screen.width / 2 - width / 2
        window.y = Screen.height / 2 - height / 2
    }

    FolderDialog {
        id: meshFolderDialog
        title: "Please choose a folder containing mesh files"
        onAccepted: {
            console.log("You chose: " + meshFolderDialog.folder)
            loadMeshText.text = meshFolderDialog.folder.toString().slice(meshFolderDialog.folder.toString().lastIndexOf("/")+1) + " folder selected"
//            if (edgeFileDialog.currentFile.toString() !== qsTr("")) nextButton.visible = true
        }
    }

    FolderDialog {
        id: outputFolderDialog
        title: "Please choose a folder containing output files"
        onAccepted: {
            console.log("You chose: " + outputFolderDialog.folder)
            loadOutputText.text = outputFolderDialog.folder.toString().slice(outputFolderDialog.folder.toString().lastIndexOf("/")+1) + " folder selected"
//            if (edgeFileDialog.currentFile.toString() !== qsTr("")) nextButton.visible = true
        }
    }

    Rectangle {
        id: titleBar
        height: 40
        color: "#e3e3e3"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: titleLabel
            text: qsTr("Re-Train Surrogate Model")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 0
            anchors.leftMargin: 10
            anchors.topMargin: 0
        }
    }

    Rectangle {
        id: content
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Text {
            id: modelLabel
            text: qsTr("Model")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 20
        }

        ComboBox {
            id: modelDropdown
            width: 140
            anchors.verticalCenter: modelLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            model: backend.load_modeltypes()
        }

        Text {
            id: loadMeshTitle
            x: 10
            y: 45
            text: qsTr("Mesh Files Directory")
            anchors.left: parent.left
            anchors.top: modelLabel.bottom
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 30
        }

        Button {
            id: loadMeshButton
            x: 338
            y: 48
            text: qsTr("Browse")
            anchors.verticalCenter: loadMeshTitle.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: meshFolderDialog.open()
        }

        Text {
            id: loadMeshText
            anchors.top: loadMeshButton.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 5
            text: qsTr("None Selected")
            anchors.left: parent.left
        }

        Text {
            id: loadMeshFileCount
            text: qsTr("0 files found")
            anchors.verticalCenter: loadMeshText.verticalCenter
            anchors.right: parent.right
            font.pixelSize: 12
            anchors.rightMargin: 10
        }

        Text {
            id: loadOutputTitle
            x: 10
            y: 45
            text: qsTr("Output Files Directory")
            anchors.left: parent.left
            anchors.top: loadMeshFileCount.bottom
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 30
        }

        Button {
            id: loadOutputButton
            x: 338
            y: 48
            text: qsTr("Browse")
            anchors.verticalCenter: loadOutputTitle.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: outputFolderDialog.open()
        }

        Text {
            id: loadOutputText
            anchors.top: loadOutputButton.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 5
            text: qsTr("None Selected")
            anchors.left: parent.left
        }

        Text {
            id: loadOutputFileCount
            text: qsTr("0 files found")
            anchors.verticalCenter: loadOutputText.verticalCenter
            anchors.right: parent.right
            font.pixelSize: 12
            anchors.rightMargin: 10
        }
    }

    Connections {
        target: backend
    }

    Rectangle {
        id: bottomNavBar
        height: 30
        color: "#e3e3e3"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0

        Button {
            id: backButton
            x: 10
            text: qsTr("Back")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked: mainStack.replace("start_screen.qml")
        }
    }
}


