import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: startscreenitem
    width: 500
    height: 150
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
            text: qsTr("User-Centric Software to Assist Design for Forming")
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
        id: container
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: subtitleBar.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0

        Button {
            id: predictionButton
            width: container.width/4
            text: qsTr("Quick Prediction")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            onClicked: mainStack.replace("prediction_setup_1.qml")
        }

        Button {
            id: optimisationButton
            width: container.width/4
            text: qsTr("Optimisation")
            anchors.left: predictionButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.leftMargin: 0
            onClicked: mainStack.replace("optimisation_setup_1.qml")
            anchors.bottomMargin: 0
        }

        Button {
            id: sensitivityButton
            width: container.width/4
            text: qsTr("Sensitivity Analysis")
            anchors.left: optimisationButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            onClicked: mainStack.replace("sensitivity_setup_1.qml")
        }

        Button {
            id: developerButton
            text: qsTr("Developer Mode")
            anchors.left: sensitivityButton.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            onClicked: mainStack.replace("developer_setup_1.qml")
        }
    }

    Rectangle {
        id: subtitleBar
        height: 20
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: subtitle
            text: qsTr("Select mode to begin")
            anchors.fill: parent
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
            anchors.leftMargin: 10
        }
    }

    Connections {
        target: backend
    }


}


