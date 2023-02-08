import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls
import Qt.labs.platform

Item {
    id: retrainsetupItem
    width: 400
    height: 450
    property alias contentHeight: content.height
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
            text: qsTr("Training Hyperparameters")
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

        ListView {
            id: hyperparameterList
            height: 200
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10

            model: ["Epochs", "Batch Size"]

            delegate: Rectangle {
                id: hyperparemeterContent
                height: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.leftMargin: 0

                Text {
                    id: hyperparameterLabel
                    text: model.modelData
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: 12
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    width: 80
                }

                Slider {
                    id: hyperparameterSlider
                    anchors.verticalCenter: hyperparameterLabel.verticalCenter
                    anchors.left: hyperparameterLabel.right
                    anchors.right: hyperparameterValue.left
                    anchors.rightMargin: 10
                    anchors.leftMargin: 10
                    value: 0.5
                }

                Text {
                    id: hyperparameterValue
                    text: hyperparameterSlider.value.toFixed(2)
                    horizontalAlignment: Text.AlignRight
                    anchors.verticalCenter: hyperparameterLabel.verticalCenter
                    anchors.right: parent.right
                    font.pixelSize: 12
                    anchors.rightMargin: 0
                    width: 50
                }
            }

        }

        Text {
            id: lossLabel
            text: qsTr("Loss Function")
            anchors.left: parent.left
            anchors.top: hyperparameterList.bottom
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        ComboBox {
            id: lossDropdown
            anchors.verticalCenter: lossLabel.verticalCenter
            anchors.left: lossLabel.right
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            model: backend.get_dev_retrain_lossfunctions()
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
            text: qsTr("Train")
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            onClicked: {
                mainStack.replace("dev_retrain_setup_3.qml")
            }
            anchors.rightMargin: 10
        }

        Button {
            id: backButton
            x: 10
            text: qsTr("Back")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            icon.color: "#ffffff"
            anchors.leftMargin: 10
            onClicked: mainStack.replace("dev_retrain_setup_1.qml")
        }
    }





}


