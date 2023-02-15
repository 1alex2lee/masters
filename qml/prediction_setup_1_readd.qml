import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls
import Qt.labs.platform

Item {
    id: predictionsetup1item
    width: 450
    height: 300
    Component.onCompleted: {
//        window.x = Screen.width / 2 - width / 2
//        window.y = Screen.height / 2 - height / 2
        window.x = window.x + window.width/2 - width/2
        window.y = window.y + window.height/2 - height/2
        window.width = width
        window.height = height
    }

//Window {
//    id: window
//    width: 450; height: 500
//    title: "User-Centirc Software to Assist Design for Forming"
//    visible: true

    FileDialog {
        id: dieFileDialog
        title: "Please choose a mesh file"
        nameFilters: ["All Files (*.*)","Mesh Files (*.pc)","STL Files (*.STL)","Word Files (*.docx)"]
        onAccepted: {
            console.log("You chose: " + dieFileDialog.currentFile)
            selectedDieLabel.text = dieFileDialog.currentFile.toString().slice(dieFileDialog.currentFile.toString().lastIndexOf("/")+1) + qsTr(" selected")
//            if (edgeFileDialog.currentFile.toString() !== qsTr("")) nextButton.visible = true
        }
    }

    FileDialog {
        id: dieEdgeFileDialog
        title: "Please choose a mesh file"
        nameFilters: ["All Files (*.*)","Mesh Files (*.pc)","STL Files (*.STL)","Word Files (*.docx)"]
        onAccepted: {
            console.log("You chose: " + dieEdgeFileDialog.currentFile)
            selectedDieEdgeLabel.text = dieEdgeFileDialog.currentFile.toString().slice(dieEdgeFileDialog.currentFile.toString().lastIndexOf("/")+1) + qsTr(" selected")
//            if (dieFileDialog.currentFile.toString() !== qsTr("")) nextButton.visible = true
        }
    }

    FileDialog {
        id: punchFileDialog
        title: "Please choose a mesh file"
        nameFilters: ["All Files (*.*)","Mesh Files (*.pc)","STL Files (*.STL)","Word Files (*.docx)"]
        onAccepted: {
            console.log("You chose: " + punchFileDialog.currentFile)
            selectedPunchLabel.text = punchFileDialog.currentFile.toString().slice(punchFileDialog.currentFile.toString().lastIndexOf("/")+1) + qsTr(" selected")
//            if (edgeFileDialog.currentFile.toString() !== qsTr("")) nextButton.visible = true
        }
    }

    FileDialog {
        id: punchEdgeFileDialog
        title: "Please choose a mesh file"
        nameFilters: ["All Files (*.*)","Mesh Files (*.pc)","STL Files (*.STL)","Word Files (*.docx)"]
        onAccepted: {
            console.log("You chose: " + edgeFileDialog.currentFile)
            punchEdgeLabel.text = punchEdgeFileDialog.currentFile.toString().slice(punchEdgeFileDialog.currentFile.toString().lastIndexOf("/")+1) + qsTr(" selected")
//            if (dieFileDialog.currentFile.toString() !== qsTr("")) nextButton.visible = true
        }
    }

    FileDialog {
        id: blankFileDialog
        title: "Please choose a mesh file"
        nameFilters: ["All Files (*.*)","Mesh Files (*.pc)","STL Files (*.STL)","Word Files (*.docx)"]
        onAccepted: {
            console.log("You chose: " + blankFileDialog.currentFile)
            selectedBlankLabel.text = blankFileDialog.currentFile.toString().slice(blankFileDialog.currentFile.toString().lastIndexOf("/")+1) + qsTr(" selected")
        }
    }

    MessageDialog {
        id: errorDialog
        text: "Not enough mesh files selected."
        buttons: MessageDialog.Ok
        onOkClicked: {
            console.log("ok")
//            errorDialog.close()
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
            text: qsTr("Quick Prediction Mode")
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
        height: 80
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
        id: loadDieEdgeContent
        height: loadDieContent.height
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: loadDieContent.bottom
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.rightMargin: 0

        Text {
            id: loadDieEdgeTitle
            text: qsTr("Load Die Edge Mesh")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Button {
            id: loadDieEdgeButton
            text: qsTr("Select File")
            anchors.verticalCenter: loadDieEdgeTitle.verticalCenter
            anchors.right: parent.right
            onClicked: dieEdgeFileDialog.open()
            anchors.rightMargin: 10
        }

        Text {
            id: selectedDieEdgeLabel
            width: loadDieEdgeContent.width - 20
            text: qsTr("No file selected")
            anchors.left: parent.left
            anchors.top: loadDieEdgeTitle.bottom
            font.pixelSize: 12
            wrapMode: Text.Wrap
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }
    }

    Rectangle {
        id: loadPunchContent
        height: 80
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: loadDieEdgeContent.bottom
        anchors.rightMargin: 0
        anchors.topMargin: 0

        Text {
            id: loadPunchTitle
            text: qsTr("Load Punch Mesh")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Button {
            id: loadPuncheutton
            text: qsTr("Select File")
            anchors.verticalCenter: loadPunchTitle.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: punchFileDialog.open()
        }

        Text {
            id: selectedPunchLabel
            width: loadPunchContent.width - 20
            text: qsTr("No file selected")
            anchors.left: parent.left
            anchors.top: loadPunchTitle.bottom
            font.pixelSize: 12
            wrapMode: Text.Wrap
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }



    }

    Rectangle {
        id: loadPunchEdgeContent
        height: loadPunchContent.height
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: loadPunchContent.bottom
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.rightMargin: 0

        Text {
            id: loadPunchEdgeTitle
            text: qsTr("Load Punch Edge Mesh")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Button {
            id: loadPunchEdgeButton
            text: qsTr("Select File")
            anchors.verticalCenter: loadPunchEdgeTitle.verticalCenter
            anchors.right: parent.right
            onClicked: punchEdgeFileDialog.open()
            anchors.rightMargin: 10
        }

        Text {
            id: selectedPunchEdgeLabel
            width: loadPunchEdgeContent.width - 20
            text: qsTr("No file selected")
            anchors.left: parent.left
            anchors.top: loadPunchEdgeTitle.bottom
            font.pixelSize: 12
            wrapMode: Text.Wrap
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }
    }

    Rectangle {
        id: loadBlankContent
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: loadPunchEdgeContent.bottom
        anchors.bottom: bottomNavBar.top
        anchors.topMargin: 0
        anchors.rightMargin: 0
        Text {
            id: loadBlankTitle
            text: qsTr("Load Blank Mesh (optional)")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        Button {
            id: loadBlankButton
            text: qsTr("Select File")
            anchors.verticalCenter: loadBlankTitle.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked: blankFileDialog.open()
        }

        Text {
            id: selectedBlankLabel
            width: loadBlankContent.width - 20
            text: qsTr("No file selected")
            anchors.left: parent.left
            anchors.top: loadBlankTitle.bottom
            font.pixelSize: 12
            wrapMode: Text.Wrap
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }
        anchors.bottomMargin: 0
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
            visible: true
            text: qsTr("Next")
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            onClicked: {
                if (dieFileDialog.currentFile == qsTr("") || dieEdgeFileDialog.currentFile == qsTr("") || dieFileDialog.currentFile == qsTr("") || punchFileDialog.currentFile == qsTr("") || punchEdgeFileDialog.currentFile == qsTr("")) {
                    errorDialog.open()
                }
                else {
//                    backend.loadPredictionMesh(dieFileDialog.currentFile.toString(), edgeFileDialog.currentFile.toString(), blankFileDialog.currentFile.toString())
    //                backend.loadPredictionMesh("file:///Users/alexlee/OneDrive - Imperial College London/Year 4/Masters/code/masters/temp/sample_die.nas", "file:///Users/alexlee/OneDrive - Imperial College London/Year 4/Masters/code/masters/temp/sample_die_edge.nas", blankFileDialog.currentFile.toString())
    //                mainStack.replace("prediction_setup_2.qml")
                    window.close()
                    var component = Qt.createComponent("prediction_setup_2.qml")
                    var new_window = component.createObject(window)
                    new_window.show()
                    new_window.x = window.x + window.width/2 - new_window.width/2
                    new_window.y = window.y + window.height/2 - new_window.height/2
                }
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
//            onClicked: mainStack.replace("start_screen.qml")
            onClicked: {
                window.close()
                var component = Qt.createComponent("prediction_workspace.qml")
                var new_window = component.createObject(window)
                new_window.show()
                new_window.x = window.x + window.width/2 - new_window.width/2
                new_window.y = window.y + window.height/2 - new_window.height/2
            }
        }
    }
}


