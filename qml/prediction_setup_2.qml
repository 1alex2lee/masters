import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: predictionsetup2item
    width: 450
    height: 400
    Component.onCompleted: {
        window.width = width
        window.height = height
        window.x = Screen.width / 2 - width / 2
        window.y = Screen.height / 2 - height / 2}

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
        id: meshPreview
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Image {
            id: image
            anchors.verticalCenter: parent.verticalCenter
            source: "../temp/input_1.png"
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
        }

        Text {
            id: meshPreviewTitle
            text: qsTr("Mesh Preview")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
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
            text: qsTr("Next")
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            onClicked: mainStack.replace("prediction_setup_3.qml")
            anchors.rightMargin: 10
        }

        Button {
            id: backButton
            x: 10
            text: qsTr("Back")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked: mainStack.replace("prediction_setup_1.qml")
        }
    }


}


