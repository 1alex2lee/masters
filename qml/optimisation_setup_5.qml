import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: item1
    width: 300
    height: 300
    Component.onCompleted: {
        window.width = width
        window.height = height
        window.x = Screen.width / 2 - width / 2
        window.y = Screen.height / 2 - height / 2
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
            text: "Optimisation Mode"
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

    Text {
        id: progressLabel
        text: "Currently on run 0/0"
        anchors.left: parent.left
        anchors.top: titleBar.bottom
        anchors.leftMargin: 10
        anchors.topMargin: 10

    }

    ProgressBar {
        id: progressBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: progressLabel.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.topMargin: 10
        value: 0
    }

    Rectangle {
        id: bestrunContent
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: progressBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 10
        anchors.topMargin: 10

        Text {
            id: header
            text: qsTr("Best Run so far")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        ListView {
            id: bestrunList
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10
            delegate: Rectangle {
                height: 20
                anchors.left: parent.left
                anchors.right: parent.right
                Text {
                    id: varname
                    x: 33
                    text: model.modelData[0]
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: 12
                    anchors.topMargin: 0
                    anchors.leftMargin: 0
                }

                Text {
                    id: varvalue
                    text: model.modelData[1].toFixed(2)
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: 12
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                }
            }
        }
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
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            visible: false
            onClicked: {
                mainStack.replace("optimisation_workspace.qml")
            }
            anchors.rightMargin: 10
            text: qsTr("Show Results")
        }

        Button {
            id: backButton
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked: {
                backend.stop_optimisation()
                mainStack.replace("optimisation_setup_3.qml")
            }
            text: qsTr("Cancel")
        }
    }

    Timer {
        interval: 1000; running: true; repeat: true
        onTriggered: {
            var progress = backend.optimisation_progress()
            progressBar.value = progress[0]/progress[1]
            if (progress[0]/progress[1] < 1) {
                progressLabel.text = "Currently on run " + progress[0] + "/" + progress[1]
                bestrunList.model = backend.getbestrun
            } else {
                stop()
                nextButton.visible = true
                backButton.visible = false
                progressLabel.text = "Done!"
            }


        }
    }

    Connections {
        target: backend
    }

}


