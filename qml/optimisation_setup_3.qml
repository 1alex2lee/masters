import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: predictionsetup1item
    width: 450
    height: 400
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
        id: selectvariableContent
        width: 180
        color: "#ffffff"
        border.width: 1
        anchors.left: parent.left
        anchors.top: titleBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: selectvariableLabel
            text: qsTr("Select Variables")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        ListView {
            id: selectvariableList
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: selectvariableLabel.bottom
            anchors.bottom: renameVariableButton.top
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10
            model: backend.load_opti_varopts()

            ButtonGroup {
                id: selectedvariables
                exclusive: false
            }

            delegate: CheckBox {
                ButtonGroup.group: selectedvariables
                text: model.modelData
                anchors.left: parent.left
                anchors.leftMargin: 10
                enabled: backend.enable_opti_vars(text, modelDropdown.currentValue)
                onClicked: {
                    if (checked) {
                        backend.pick_optivar(text)
                    } else {
                        backend.unpick_optivar(text)
                    }
                }
            }
        }

        Button {
            id: renameVariableButton
            text: qsTr("Rename Variables")
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 10
            onClicked: {
                var component = Qt.createComponent("optimisation_setup_3_rename.qml")
                var new_window    = component.createObject(window)
                new_window.show()
            }
        }
    }

    Rectangle {
        id: optionsContent
        color: "#ffffff"
        anchors.left: selectvariableContent.right
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.bottomMargin: 0
        anchors.rightMargin: 0
        anchors.leftMargin: 0
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
            id: materialLabel
            text: qsTr("Material")
            anchors.left: parent.left
            anchors.top: modelLabel.bottom
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        ComboBox {
            id: materialDropdown
            width: 140
            anchors.verticalCenter: materialLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            model: backend.load_materials()
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
            model: backend.load_processes()
        }

        Text {
            id: goalLabel
            text: qsTr("Goal Variable")
            anchors.left: parent.left
            anchors.top: processLabel.bottom
            font.pixelSize: 12
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

        ComboBox {
            id: goalDropdown
            width: 140
            anchors.verticalCenter: goalLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            model: backend.picked_optivars
        }

        TabBar {
            id: goaloptionContent
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: goalLabel.bottom
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10

            ButtonGroup {
                id: goalaim
            }

            TabButton {
                id: minimiseGoal
                anchors.left: parent.left
                anchors.top: parent.top
                text: qsTr("Minimise")
                checked: true
                ButtonGroup.group: goalaim
            }

            TabButton {
                id: maximiseGoal
                anchors.left: minimiseGoal.right
                anchors.top: parent.top
                anchors.leftMargin: 0
                text: qsTr("Maximise")
                ButtonGroup.group: goalaim
            }

            TabButton {
                id: settoGoal
                anchors.left: maximiseGoal.right
                anchors.top: parent.top
                text: qsTr("Set to")
                anchors.leftMargin: 0
                ButtonGroup.group: goalaim
            }
        }

        SpinBox {
            id: settoValue
            width: 80
            anchors.right: parent.right
            anchors.top: goaloptionContent.bottom
            anchors.topMargin: 5
            anchors.rightMargin: 10
            anchors.leftMargin: 0
            value: 1
            visible: settoGoal.checked
        }

        Text {
            id: searchmethodLabel
            text: qsTr("Searh Method")
            anchors.left: parent.left
            anchors.top: settoValue.bottom
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        ComboBox {
            id: searchmethodDropdown
            width: 140
            anchors.verticalCenter: searchmethodLabel.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            model: ["Grid","Random","Bayesian"]
        }

        Text {
            id: runsnoLabel
            text: qsTr("Number of Runs")
            anchors.left: parent.left
            anchors.top: searchmethodLabel.bottom
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        SpinBox {
            id: runsnoInput
            x: 10
            width: 80
            height: 20
            value: 20
            editable: true
            anchors.verticalCenter: runsnoLabel.verticalCenter
            anchors.right: parent.right
            font.pixelSize: 12
            anchors.rightMargin: 10
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
            onClicked: {
                backend.set_optiopts(materialDropdown.currentValue, processDropdown.currentValue, modelDropdown.currentValue, goalDropdown.currentValue,
                                     goalaim.checkedButton.text, settoValue.value, searchmethodDropdown.currentValue, runsnoInput.value)
                mainStack.replace("optimisation_setup_4.qml")
            }
            anchors.rightMargin: 10
            text: qsTr("Next")
        }

        Button {
            id: backButton
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            onClicked: mainStack.replace("optimisation_setup_2.qml")
            text: qsTr("Back")
        }
    }
    Connections {
        target: backend
        function onOpti_var_name_changed() {
            selectvariableList.model = backend.load_opti_varopts()
        }
    }
}


