import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: predictionsetup2item
    width: 450
    height: 400
    Component.onCompleted: {
        window.width = predictionsetup2item.width
        window.height = predictionsetup2item.height }

    FileDialog {
        id: fileDialog
        title: "Please choose a mesh file"
        nameFilters: ["All Files (*.*)","Mesh Files (*.pc)","STL Files (*.STL)","Word Files (*.docx)"]
        onAccepted: {
            console.log("You chose: " + fileDialog.currentFile)
            selectedfileLabel.text = fileDialog.currentFile.toString().slice(fileDialog.currentFile.toString().lastIndexOf("/")+1) + qsTr(" selected")
//            Qt.quit()
        }
        onRejected: {
            console.log("Canceled")
//            Qt.quit()
        }
        //    Component.onCompleted: visible = true
    }

    Rectangle {
        id: titleBar
        height: 50
        color: "#e3e3e3"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: titleLabel
            text: qsTr("User-Centric Software to Assist Design for Forming")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pixelSize: 18
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
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Text {
            id: loadmeshTitle
            text: qsTr("Load Mesh")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Button {
            id: loadmeshButton
            width: 80
            text: qsTr("")
            anchors.verticalCenter: loadmeshTitle.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            onClicked:{
                console.log(fileDialog.currentFile)
                fileDialog.open()
        }

            Text {
                id: loadmeshLabel
                text: qsTr("Select File")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Text {
            id: selectedfileLabel
            width: content.width - 20
            text: qsTr("No file selected")
            anchors.left: parent.left
            anchors.top: loadmeshTitle.bottom
            font.pixelSize: 12
            wrapMode: Text.Wrap
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Button {
            id: nextButton
            text: qsTr("Button")
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            onClicked: mainStack.replace("prediction_setup2.qml")

            Text {
                id: nextButtonLabel
                text: qsTr("Next")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            id: backButton
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            Text {
                id: backButtonLabel
                text: qsTr("Back")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.bottomMargin: 10
        }
    }


}


