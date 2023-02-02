import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: predictionsetup3item
    width: 550
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
        id: independentvarContent
        width: 150
        color: "#00ffffff"
        border.width: 1
        anchors.left: parent.left
        anchors.top: titleBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        ListView {
            id: independentvarList
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: independentvarLabel.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            model: backend.load_independentvars

            ButtonGroup {
                id: independentvars
                exclusive: false
            }

            delegate: CheckBox {
                ButtonGroup.group: independentvars
                text: model.modelData
                anchors.left: parent.left
                anchors.leftMargin: 10
                onClicked: {
                    if (checked) {
                        backend.pick_independentvars(text)
                    } else {
                        backend.unpick_independentvars(text)
                    }
                }
            }
        }

        Text {
            id: independentvarLabel
            text: qsTr("Independent Variables")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }
    }

    Rectangle {
        id: dependentvarContent
        width: 150
        color: "#00ffffff"
        border.width: 1
        anchors.left: independentvarContent.right
        anchors.top: titleBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        ListView {
            id: dependentvarList
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: dependentvarLabel.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 10
            model: backend.load_dependentvars

            ButtonGroup {
                id: dependentvars
                exclusive: false
            }

            delegate: CheckBox {
                ButtonGroup.group: dependentvars
                text: model.modelData
                anchors.left: parent.left
                anchors.leftMargin: 10
                onClicked: {
                    if (checked) {
                        backend.pick_dependentvars(text)
                    } else {
                        backend.unpick_dependentvars(text)
                    }
                }
            }
        }

        Text {
            id: dependentvarLabel
            text: qsTr("Dependent Variables")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }
    }

    Rectangle {
        id: optionsContent
        color: "#ffffff"
        anchors.left: dependentvarContent.right
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Text {
            id: materialLabel
            text: qsTr("Material")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 20
        }

        ComboBox {
            id: materialDropdown
            width: 140
            anchors.verticalCenter: materialLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            model: ["Aluminium","Steel"]
        }

        Text {
            id: processLabel
            text: qsTr("Stamping Type")
            anchors.left: parent.left
            anchors.top: materialLabel.bottom
            font.pixelSize: 12
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        ComboBox {
            id: processDropdown
            width: 140
            anchors.verticalCenter: processLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            model: ["Hot Stamping","Cold Stamping"]
        }

        Text {
            id: modelLabel
            text: qsTr("Model")
            anchors.left: parent.left
            anchors.top: processLabel.bottom
            font.pixelSize: 12
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        ComboBox {
            id: modelDropdown
            width: 140
            anchors.verticalCenter: modelLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            model: ["Thinning","Displacement","Stress"]
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



