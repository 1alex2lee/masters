import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: predictionsetup3item
    width: 450
    height: 210
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
        id: selectMaterialContent
        height: (predictionsetup3item.height - titleBar.height - bottomNavBar.height)/2
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.rightMargin: 0
        anchors.topMargin: 0

        Text {
            id: selectMaterialTitle
            text: qsTr("Select Material")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        ComboBox {
            id: selectMaterialDropdown
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: selectMaterialTitle.bottom
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10
            model: backend.load_materials()
        }



    }

    Rectangle {
        id: selectProcessContent
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: selectMaterialContent.bottom
        anchors.bottom: bottomNavBar.top
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.rightMargin: 0

        Text {
            id: selectProcessTitle
            text: qsTr("Select Stamping Type")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        ComboBox {
            id: selectProcessDropdown
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: selectProcessTitle.bottom
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10
            model: backend.load_processes()
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
            text: qsTr("Next")
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            icon.color: "#ffffff"
            onClicked: {
                backend.setMaterialandProcess(selectMaterialDropdown.currentValue, selectProcessDropdown.currentValue)
                mainStack.replace("prediction_workspace.qml")
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
            onClicked: mainStack.replace("prediction_setup_2.qml")
        }
    }

    Connections {
        target: backend
    }
}



