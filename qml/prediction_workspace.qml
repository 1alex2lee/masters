import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick3D

Item {
    id: predictionWorkspceItem
    width: 800
    height: 600

    Component.onCompleted: {
        window.width = width
        window.height = height
        window.x = Screen.width / 2 - width / 2
        window.y = Screen.height / 2 - height / 2
    }

    MenuBar {
        id: menubar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom

        Menu {
            title: qsTr("File")
        }

        Menu {
            title: qsTr("Mode")
            Action {
                text: qsTr("Quick Prediction")
                enabled: false
            }
            Action {
                text: qsTr("Optimisation")
                onTriggered: mainStack.replace("optimisation_workspace.qml")
            }
            Action {
                text: qsTr("Sensitivity")
                onTriggered: mainStack.replace("sensitivity_workspace.qml")
            }
        }

        Menu {
            title: qsTr("Exit")
        }
    }
    Rectangle {
        id: parametersContent
        width: 200
        color: "#00ffffff"
        border.width: 1
        anchors.left: parent.left
        anchors.top: menubar.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: parametersLabel
            y: 5
            text: qsTr("Parameters")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }

        Rectangle {
            id: force
            height: 50
            visible: true
            color: "#00ffffff"
            border.color: "#00ffffff"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parametersLabel.bottom
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.topMargin: 10

            Slider {
                id: forceSlider
                x: 5
                y: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: forceLabel.bottom
                anchors.rightMargin: 0
                live: true
                anchors.leftMargin: 0
                anchors.topMargin: 10
                value: 50
                to: 100
                onMoved: {
                    backend.updateParameters(forceSlider.value, velocitySlider.value, blankthicknessSlider.value, temperatureSlider.value)
                }
            }

            Text {
                id: forceLabel
                y: 10
                text: qsTr("Force (kN)")
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.leftMargin: 0
                anchors.topMargin: 5
            }

            SpinBox {
                id: forceValue
                x: 150
                y: 30
                width: 80
                value: forceSlider.value
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.rightMargin: 0
                anchors.topMargin: 0
                editable: true
                onValueModified: {
                    if (forceSlider.value !== value) {
                        forceSlider.value = value
                    }
                }
            }
        }

        Rectangle {
            id: velocity
            height: force.height
            visible: true
            color: "#00ffffff"
            border.color: "#00ffffff"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: force.bottom

            Slider {
                id: velocitySlider
                x: 5
                y: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: velocityLabel.bottom
                anchors.topMargin: 10
                value: 50
                to: 100
                anchors.leftMargin: 0
                live: true
                anchors.rightMargin: 0
                onMoved: {
                    backend.updateParameters(forceSlider.value, velocitySlider.value, blankthicknessSlider.value, temperatureSlider.value)
                }
            }

            Text {
                id: velocityLabel
                y: 10
                text: qsTr("Velocity (mm/s)")
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.leftMargin: 0
                anchors.topMargin: 5
            }

            SpinBox {
                id: velocityValue
                x: 150
                y: 30
                width: forceValue.width
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.rightMargin: 0
                anchors.topMargin: 0
                value: velocitySlider.value
                editable: true
                onValueModified: {
                    if (velocitySlider.value !== value) {
                        velocitySlider.value = value
                    }
                }
            }
            anchors.topMargin: 0
            anchors.leftMargin: 10
            anchors.rightMargin: 10
        }

        Rectangle {
            id: blankthickness
            height: force.height
            visible: true
            color: "#00ffffff"
            border.color: "#00ffffff"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: velocity.bottom
            Slider {
                id: blankthicknessSlider
                x: 5
                y: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: blankthicknessLabel.bottom
                anchors.topMargin: 10
                value: 50
                to: 100
                anchors.leftMargin: 0
                live: true
                anchors.rightMargin: 0
                onMoved: {
                    backend.updateParameters(forceSlider.value, velocitySlider.value, blankthicknessSlider.value, temperatureSlider.value)
                }
            }

            Text {
                id: blankthicknessLabel
                y: 10
                text: qsTr("Blank Thickness")
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.leftMargin: 0
                anchors.topMargin: 5
            }

            SpinBox {
                id: blankthicknessValue
                x: 150
                y: 30
                width: forceValue.width
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.rightMargin: 0
                anchors.topMargin: 0
                value: blankthicknessSlider.value
                editable: true
                onValueModified: {
                    if (blankthicknessSlider.value !== value) {
                        blankthicknessSlider.value = value
                    }
                }
            }
            anchors.topMargin: 0
            anchors.leftMargin: 10
            anchors.rightMargin: 10
        }

        Rectangle {
            id: temperature
            height: force.height
            visible: true
            color: "#00ffffff"
            border.color: "#00ffffff"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: blankthickness.bottom
            Slider {
                id: temperatureSlider
                x: 5
                y: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: temperatureLabel.bottom
                anchors.topMargin: 10
                value: 50
                to: 100
                anchors.leftMargin: 0
                live: true
                anchors.rightMargin: 0
                onMoved: {
                    backend.updateParameters(forceSlider.value, velocitySlider.value, blankthicknessSlider.value, temperatureSlider.value)
                }
            }

            Text {
                id: temperatureLabel
                y: 10
                text: qsTr("Temperature")
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.leftMargin: 0
                anchors.topMargin: 5
            }

            SpinBox {
                id: temperatureValue
                x: 150
                y: 30
                width: forceValue.width
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.rightMargin: 0
                anchors.topMargin: 0
                value: temperatureSlider.value
                editable: true
                onValueModified: {
                    if (temperatureSlider.value !== value) {
                        temperatureSlider.value = value
                    }
                }
            }
            anchors.topMargin: 0
            anchors.leftMargin: 10
            anchors.rightMargin: 10
        }

        Text {
            id: resultsLabel
            x: 10
            text: qsTr("Results")
            anchors.left: parent.left
            anchors.top: temperature.bottom
            font.pixelSize: 12
            anchors.topMargin: 20
            anchors.leftMargin: 10
        }

        Rectangle {
            id: manufacturbility
            x: 0
            y: 0
            height: 100
            color: "#00ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: resultsLabel.bottom
            anchors.rightMargin: 10

            Text {
                id: manufacturbilityLabel
                y: 0
                text: qsTr("Manufacturbility")
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.leftMargin: 0
                anchors.topMargin: 0
            }

            Text {
                id: manufacturbilityValue
                x: 42
                y: 0
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
                anchors.rightMargin: 0
            }
            anchors.topMargin: 10
            anchors.leftMargin: 10
        }

    }

    ButtonGroup { id: resultType }

    TabBar {
        id: resultTypeBar
        anchors.left: parametersContent.right
        anchors.right: parent.right
        anchors.top: menubar.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        TabButton {
            id: thinningButton
            text: qsTr("Thinning")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 0
            ButtonGroup.group: resultType
            onClicked: backend.changeResultType(thinningButton.text)
        }

        TabButton {
            id: stressButton
            text: qsTr("Stress")
            anchors.left: displacementButton.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            ButtonGroup.group: resultType
            onClicked: backend.changeResultType(text)
            anchors.topMargin: 0
        }

        TabButton {
            id: displacementButton
            x: 0
            y: 0
            text: qsTr("Displacement")
            anchors.left: thinningButton.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            ButtonGroup.group: resultType
            onClicked: backend.changeResultType(text)
            anchors.topMargin: 0
        }
    }

    Text {
        id: resultTypeLabel
        text: (resultTypeBar.currentItem === null) ? qsTr("No result type selected") : qsTr("Current result type: ") + resultType.checkedButton.text
        anchors.left: parametersContent.right
        anchors.right: parent.right
        anchors.top: resultTypeBar.bottom
        font.pixelSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
    }


    Rectangle {
        id: imageHolder
        color: "#ffffff"
        anchors.left: parametersContent.right
        anchors.right: parent.right
        anchors.top: resultTypeLabel.bottom
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        View3D {

        }

//        Image {
//            id: resultImage
//            width: 400
//            height: 400
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.horizontalCenter: parent.horizontalCenter
//            fillMode: Image.PreserveAspectFit
//            cache: false
//            property bool counter: false

//            function reload () {
//                counter = !counter
//                if (counter) {
//                    source = "../temp/outputfield1.png"
//                }
//                else {
//                    source = "../temp/outputfield2.png"
//                }
//            }
//        }
    }

    Connections {
        target: backend

        function onUpdate (manufacturbility) {
            manufacturbilityValue.text = (manufacturbility).toFixed(2) + qsTr(" %")
            resultImage.reload()
        }

    }




}
