import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: predictionsetup1item
    width: 450
    height: 250
    Component.onCompleted: {
        window.width = width
        window.height = height
        window.x = Screen.width / 2 - width / 2
        window.y = Screen.height / 2 - height / 2
    }

    FileDialog {
        id: dieFileDialog
        title: "Please choose a mesh file"
        nameFilters: ["All Files (*.*)","Mesh Files (*.pc)","STL Files (*.STL)","Word Files (*.docx)"]
        onAccepted: {
            console.log("You chose: " + dieFileDialog.currentFile)
            selectedDieLabel.text = dieFileDialog.currentFile.toString().slice(dieFileDialog.currentFile.toString().lastIndexOf("/")+1) + qsTr(" selected")
            if (edgeFileDialog.currentFile.toString() !== qsTr("")) nextButton.visible = true
        }
    }

    FileDialog {
        id: edgeFileDialog
        title: "Please choose a mesh file"
        nameFilters: ["All Files (*.*)","Mesh Files (*.pc)","STL Files (*.STL)","Word Files (*.docx)"]
        onAccepted: {
            console.log("You chose: " + edgeFileDialog.currentFile)
            selectedEdgeLabel.text = edgeFileDialog.currentFile.toString().slice(edgeFileDialog.currentFile.toString().lastIndexOf("/")+1) + qsTr(" selected")
            if (dieFileDialog.currentFile.toString() !== qsTr("")) nextButton.visible = true
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
            text: qsTr("Optimisation Mode")
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
        id: loadDieContent
        height: (predictionsetup1item.height - titleBar.height - bottomNavBar.height)/2
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.rightMargin: 0
        anchors.topMargin: 0

        Text {
            id: loadDieTitle
            text: qsTr("Load Die Mesh")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Button {
            id: loadDieutton
            text: qsTr("Select File")
            anchors.verticalCenter: loadDieTitle.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: dieFileDialog.open()
        }

        Text {
            id: selectedDieLabel
            width: loadDieContent.width - 20
            text: qsTr("No file selected")
            anchors.left: parent.left
            anchors.top: loadDieTitle.bottom
            font.pixelSize: 12
            wrapMode: Text.Wrap
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }



    }

    Rectangle {
        id: loadEdgeContent
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: loadDieContent.bottom
        anchors.bottom: bottomNavBar.top
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.rightMargin: 0

        Text {
            id: loadEdgeTitle
            text: qsTr("Load Edge Mesh")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Button {
            id: loadEdgeButton
            text: qsTr("Select File")
            anchors.verticalCenter: loadEdgeTitle.verticalCenter
            anchors.right: parent.right
            onClicked: edgeFileDialog.open()
            anchors.rightMargin: 10
        }

        Text {
            id: selectedEdgeLabel
            width: loadEdgeContent.width - 20
            text: qsTr("No file selected")
            anchors.left: parent.left
            anchors.top: loadEdgeTitle.bottom
            font.pixelSize: 12
            wrapMode: Text.Wrap
            anchors.leftMargin: 10
            anchors.topMargin: 10
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
            id: nextButton
            x: 398
            visible: false
            text: qsTr("Next")
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            onClicked: {
//                backend.loadPredictionMesh(dieFileDialog.currentFile.toString(), edgeFileDialog.currentFile.toString())
                mainStack.replace("optimisation_setup_2.qml")
            }
            anchors.rightMargin: 10
        }

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


