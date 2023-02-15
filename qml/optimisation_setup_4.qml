import QtQuick
import QtQuick.Dialogs
import QtQuick.Window
import QtQuick.Controls

Item {
    id: predictionsetup1item
    width: 450
    height: 300
    Component.onCompleted: {
        window.x = window.x + window.width/2 - width/2
        window.y = window.y + window.height/2 - height/2
        window.width = width
        window.height = height
    }

//Window {
//    id: window
//    width: 450; height: 300
//    title: "User-Centirc Software to Assist Design for Forming"
//    visible: true
    
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
        id: content
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: titleBar.bottom
        anchors.bottom: bottomNavBar.top
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Text {
            id: contentLabel
            text: qsTr("Set Variable Bounds")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Rectangle {
            id: varboundHeader
            x: 20
            y: 45
            height: 30
            visible: true
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: contentLabel.bottom
            anchors.topMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10

            Text {
                id: varnameLabel
                width: varboundHeader.width/4
                text: "Variable"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.leftMargin: 0
            }

            Text {
                id: lowerboundLabel
                width: varboundHeader.width/4
                text: qsTr("Lower Bound")
                anchors.left: varnameLabel.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.leftMargin: 0
                anchors.topMargin: 0
            }

            Text {
                id: upperboundLabel
                width: varboundHeader.width/4
                text: qsTr("Upper Bound")
                anchors.left: lowerboundLabel.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.leftMargin: 0
                anchors.topMargin: 0
            }

            Text {
                id: unitLabel
                width: varboundHeader.width/4
                text: qsTr("Unit")
                anchors.left: upperboundLabel.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.leftMargin: 0
                anchors.topMargin: 0
            }
        }

        ListView {
            id: variableboundsList
            x: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: varboundHeader.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 0
            model: backend.picked_optivars

            delegate: Rectangle {

                id: varboundRow
                height: 25
                anchors.left: parent.left
                anchors.right: parent.right
                //                anchors.top: varboundHeader.bottom
                anchors.leftMargin: 10
                Component.onCompleted: backend.setvarbounds(varboundLabel.text, varlowerbound.value, varupperbound.value, unitDropdown.currentValue)

                Text {
                    id: varboundLabel
                    width: varboundRow.width/4
                    text: model.modelData
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                }

                TextField {
                    id: varlowerbound
                    selectByMouse: true
                    text: backend.get_optivar_lowerbound(varboundLabel.text)
                    validator: DoubleValidator {
                        bottom: parseFloat(backend.get_optivar_lowerbound(varboundLabel.text))
                        top: parseFloat(backend.get_optivar_upperbound(varboundLabel.text))
                        decimals: backend.get_optivar_decimals(varboundLabel.text)
                    }
                    anchors.verticalCenter: varboundLabel.verticalCenter
                    anchors.left: varboundLabel.right
                    onTextEdited: backend.setvarbounds(varboundLabel.text, parseFloat(varlowerbound.text), parseFloat(varupperbound.text), unitDropdown.currentValue)
                }

                TextField {
                    id: varupperbound
                    width: varboundRow.width/4
                    selectByMouse: true
                    text: parseFloat(backend.get_optivar_upperbound(varboundLabel.text))
                    validator:  DoubleValidator {
                        bottom: parseFloat(backend.get_optivar_lowerbound(varboundLabel.text))
                        top: parseFloat(backend.get_optivar_upperbound(varboundLabel.text))
                        decimals: parseInt(backend.get_optivar_decimals(varboundLabel.text))
                    }
                    anchors.verticalCenter: varboundLabel.verticalCenter
                    anchors.left: varlowerbound.right
                    onTextEdited: backend.setvarbounds(varboundLabel.text, parseFloat(varlowerbound.text), parseFloat(varupperbound.text), unitDropdown.currentValue)
                }

                ComboBox {
                    id: unitDropdown
                    width: varboundRow.width/4
                    anchors.verticalCenter: varboundLabel.verticalCenter
                    anchors.left: varupperbound.right
                    anchors.leftMargin: 0
                    model: backend.get_optivar_units(varboundLabel.text)
//                    onActivated: backend.setvarbounds(varboundLabel.text, parseFloat(varlowerbound.text), parseFloat(varupperbound.text), unitDropdown.currentValue)
                }
                anchors.rightMargin: 10
                anchors.topMargin: 0
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
            anchors.rightMargin: 10
            text: qsTr("Next")
            onClicked: {
                backend.start_optimisation()
                mainStack.replace("optimisation_setup_5.qml")
//                window.close()
//                var component = Qt.createComponent("optimisation_setup_5.qml")
//                var new_window = component.createObject(window)
//                new_window.show()
//                new_window.x = window.x + window.width/2 - new_window.width/2
//                new_window.y = window.y + window.height/2 - new_window.height/2
            }
        }

        Button {
            id: backButton
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            text: qsTr("Back")
            onClicked: {
                mainStack.replace("optimisation_setup_3.qml")
//                window.close()
//                var component = Qt.createComponent("optimisation_setup_3.qml")
//                var new_window = component.createObject(window)
//                new_window.show()
//                new_window.x = window.x + window.width/2 - new_window.width/2
//                new_window.y = window.y + window.height/2 - new_window.height/2
            }
        }
    }

    Connections {
        target: backend
    }

}


