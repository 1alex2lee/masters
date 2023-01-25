import QtQuick
import QtQuick.Window
import QtQuick.Controls

Item {
    id: predictionWorkspceItem
    width: 800
    height: 600
//    color: "#eeeeee"
//    visible: true
//    title: qsTr("Hello World")

    Component.onCompleted: {
        window.width = width
        window.height = height
        window.x = Screen.width / 2 - width / 2
        window.y = Screen.height / 2 - height / 2
    }

    Rectangle {
        id: topBar
        height: 20
        color: "#ffffff"
        border.color: "#000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: appName
            text: qsTr("Deep Learning based User-Centric Software to Assist Design for Forming")
            anchors.left: icon.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pixelSize: 12
            verticalAlignment: Text.AlignVCenter
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
        }

        Image {
            id: icon
            width: 25
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: "qrc:/qtquickplugin/images/template_image.png"
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: fileBar
        height: 20
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0


        Button {
            id: fileButton
            width: 50
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Text {
                id: fileButtonLabel
                text: qsTr("File")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            id: modeButton
            width: 50
            text: qsTr("Button")
            anchors.left: fileButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            onClicked: {
                modePopup.open()
//                (modeMenu.visible == false) ? modeMenu.visible = true : modeMenu.visible = false
            }

            Text {
                id: modeButtonLabel
                text: qsTr("Mode")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            id: exitButton
            width: 50
            text: qsTr("Button")
            anchors.left: modeButton.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 0

            Text {
                id: exitButtonLabel
                text: qsTr("Exit")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

    }


    Popup {
        id: modePopup
        width: 110
        height: 150
//        anchors.left: fileBar.left
//        anchors.top: fileBar.bottom
        focus: true
        dim: true
        closePolicy: Popup.CloseOnPressOutside

        Text {
            id: modeLabel
            text: qsTr("Mode")
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 12
            font.bold: true
            anchors.leftMargin: 5
            anchors.topMargin: 0
        }

        Button {
            id: predictionModeButton
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: modeLabel.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0

            Text {
                id: predictionModeLabel
                text: qsTr("Quick Prediction")
                anchors.fill: parent
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
            }
        }

        Button {
            id: optimisationModeButton
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: predictionModeButton.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            onClicked: mainStack.replace("optimisation_workspace.qml")
            Text {
                id: optimisationModeLabel
                text: qsTr("Optimisation")
                anchors.fill: parent
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
            }
            anchors.topMargin: 0
        }

        Button {
            id: sensitivityModeButton
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: optimisationModeButton.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            onClicked: mainStack.replace("sensitivity_workspace.qml")
            Text {
                id: sensitivityModeLabel
                text: qsTr("Sensitivity")
                anchors.fill: parent
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
            }
            anchors.topMargin: 0
        }

        Button {
            id: developerModeButton
            text: qsTr("Button")
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: sensitivityModeButton.bottom
            anchors.leftMargin: 0
            onClicked: mainStack.replace("developer_workspace.qml")
            Text {
                id: developerModeLabel
                text: qsTr("Developer")
                anchors.fill: parent
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: 5
            }
            anchors.topMargin: 0
            anchors.rightMargin: 0
        }
    }

//    Rectangle {
//        id: modeMenu
//        x: 0
//        width: 110
//        height: 150
//        color: "#ffffff"
//        border.width: 1
//        anchors.left: fileBar.left
//        anchors.top: fileBar.bottom
//        focus: true
//        z: 1
//        anchors.leftMargin: fileButton.width
//        anchors.topMargin: 0
//        visible: true

//        Text {
//            id: modeLabel
//            text: qsTr("Mode")
//            anchors.left: parent.left
//            anchors.top: parent.top
//            font.pixelSize: 12
//            font.bold: true
//            anchors.leftMargin: 5
//            anchors.topMargin: 0
//        }

//        Button {
//            id: predictionModeButton
//            text: qsTr("Button")
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: modeLabel.bottom
//            anchors.rightMargin: 0
//            anchors.leftMargin: 0
//            anchors.topMargin: 0

//            Text {
//                id: predictionModeLabel
//                text: qsTr("Quick Prediction")
//                anchors.fill: parent
//                font.pixelSize: 12
//                verticalAlignment: Text.AlignVCenter
//                anchors.leftMargin: 5
//            }
//        }

//        Button {
//            id: optimisationModeButton
//            text: qsTr("Button")
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: predictionModeButton.bottom
//            anchors.rightMargin: 0
//            anchors.leftMargin: 0
//            onClicked: mainStack.replace("optimisation_workspace.qml")
//            Text {
//                id: optimisationModeLabel
//                text: qsTr("Optimisation")
//                anchors.fill: parent
//                font.pixelSize: 12
//                verticalAlignment: Text.AlignVCenter
//                anchors.leftMargin: 5
//            }
//            anchors.topMargin: 0
//        }

//        Button {
//            id: sensitivityModeButton
//            text: qsTr("Button")
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: optimisationModeButton.bottom
//            anchors.rightMargin: 0
//            anchors.leftMargin: 0
//            onClicked: mainStack.replace("sensitivity_workspace.qml")
//            Text {
//                id: sensitivityModeLabel
//                text: qsTr("Sensitivity")
//                anchors.fill: parent
//                font.pixelSize: 12
//                verticalAlignment: Text.AlignVCenter
//                anchors.leftMargin: 5
//            }
//            anchors.topMargin: 0
//        }

//        Button {
//            id: developerModeButton
//            text: qsTr("Button")
//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.top: sensitivityModeButton.bottom
//            anchors.leftMargin: 0
//            onClicked: mainStack.replace("developer_workspace.qml")
//            Text {
//                id: developerModeLabel
//                text: qsTr("Developer")
//                anchors.fill: parent
//                font.pixelSize: 12
//                verticalAlignment: Text.AlignVCenter
//                anchors.leftMargin: 5
//            }
//            anchors.topMargin: 0
//            anchors.rightMargin: 0
//        }
//    }

    Rectangle {
        id: parametersMenu
        width: 200
        height: 200
        color: "#ffffff"
        border.width: 1
        anchors.left: parent.left
        anchors.top: fileBar.bottom
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: parametersLabel
            x: 5
            y: 5
            text: qsTr("Parameters")
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 0
        }

        Rectangle {
            id: force
            height: 40
            visible: true
            color: "#00ffffff"
            border.color: "#00ffffff"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parametersLabel.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 10

            Slider {
                id: forceSlider
                x: 5
                y: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: forceLabel.bottom
                anchors.rightMargin: 5
                live: true
                anchors.leftMargin: 5
                anchors.topMargin: 5
                value: 0.5
                onMoved: {
                    backend.updateParameters(forceSlider.value, velocitySlider.value, blankthicknessSlider.value, temperatureSlider.value)
                }
            }

            Text {
                id: forceLabel
                x: 5
                y: 10
                text: qsTr("Force")
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
            }

            Text {
                id: forceValue
                x: 150
                y: 30
                text: (forceSlider.value).toFixed(2) + qsTr(" kN")
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.rightMargin: 5
                anchors.topMargin: 0
            }
        }

        Rectangle {
            id: velocity
            height: 40
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
                anchors.topMargin: 5
                value: 0.5
                anchors.leftMargin: 5
                live: true
                anchors.rightMargin: 5
                onMoved: {
                    backend.updateParameters(forceSlider.value, velocitySlider.value, blankthicknessSlider.value, temperatureSlider.value)
                }
            }

            Text {
                id: velocityLabel
                x: 5
                y: 10
                text: qsTr("Velocity")
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
            }

            Text {
                id: velocityValue
                x: 150
                y: 30
                text: (velocitySlider.value).toFixed(2) + qsTr(" mm/s")
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
                anchors.rightMargin: 5
            }
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
        }

        Rectangle {
            id: blankthickness
            height: 40
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
                anchors.topMargin: 5
                value: 0.5
                anchors.leftMargin: 5
                live: true
                anchors.rightMargin: 5
                onMoved: {
                    backend.updateParameters(forceSlider.value, velocitySlider.value, blankthicknessSlider.value, temperatureSlider.value)
                }
            }

            Text {
                id: blankthicknessLabel
                x: 5
                y: 10
                text: qsTr("Blank Thickness")
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
            }

            Text {
                id: blankthicknessValue
                x: 150
                y: 30
                text: (blankthicknessSlider.value).toFixed(2) + qsTr(" mm")
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
                anchors.rightMargin: 5
            }
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
        }

        Rectangle {
            id: temperature
            height: 40
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
                anchors.topMargin: 5
                value: 0.5
                anchors.leftMargin: 5
                live: true
                anchors.rightMargin: 5
                onMoved: {
                    backend.updateParameters(forceSlider.value, velocitySlider.value, blankthicknessSlider.value, temperatureSlider.value)
                }
            }

            Text {
                id: temperatureLabel
                x: 5
                y: 10
                text: qsTr("Temperature")
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
            }

            Text {
                id: temperatureValue
                x: 150
                y: 30
                text: (temperatureSlider.value).toFixed(2) + qsTr(" °C")
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
                anchors.rightMargin: 5
            }
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
        }
    }

    Rectangle {
        id: resultsMenu
        width: 200
        height: 100
        color: "#ffffff"
        border.width: 1
        anchors.left: parent.left
        anchors.top: parametersMenu.bottom
        Text {
            id: resultsLabel
            x: 5
            y: 5
            text: qsTr("Results")
            anchors.top: parent.top
            font.pixelSize: 12
            anchors.topMargin: 0
        }

        Rectangle {
            id: manufacturbility
            height: 20
            visible: true
            color: "#00ffffff"
            border.color: "#00ffffff"
            border.width: 0
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: resultsLabel.bottom

            Text {
                id: manufacturbilityLabel
                x: 5
                y: 10
                text: qsTr("Manufacturbility")
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
            }

            Text {
                id: manufacturbilityValue
                x: 150
                y: 30
                anchors.right: parent.right
                anchors.top: parent.top
                font.pixelSize: 12
                anchors.topMargin: 0
                anchors.rightMargin: 5
            }
            anchors.topMargin: 10
            anchors.leftMargin: 0
            anchors.rightMargin: 0
        }
        anchors.topMargin: 0
        anchors.leftMargin: 0
    }

    ButtonGroup { id: resultType }

    Rectangle {
        id: resultTypeMenu
        height: 40
        color: "#ffffff"
        border.width: 1
        anchors.left: parametersMenu.right
        anchors.right: parent.right
        anchors.top: fileBar.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        RadioButton {
            id: thinningButton
            width: resultTypeMenu.width/3
            height: 20
            text: qsTr("Thinning")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 0
            ButtonGroup.group: resultType
            onClicked: backend.changeResultType(thinningButton.text)

            Text {
                id: thinningButtonLabel
                text: qsTr("Thinning")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        RadioButton {
            id: displacementButton
            width: resultTypeMenu.width/3
            height: 20
            text: qsTr("Dispalcement")
            anchors.left: thinningButton.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            ButtonGroup.group: resultType
            onClicked: backend.changeResultType(text)

            Text {
                id: displacementButtonLabel
                text: qsTr("Displacement")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.topMargin: 0
        }

        RadioButton {
            id: stressButton
            width: resultTypeMenu.width/3
            height: 20
            text: qsTr("Stress")
            anchors.left: displacementButton.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            ButtonGroup.group: resultType
            onClicked: backend.changeResultType(text)

            Text {
                id: stressButtonLabel
                text: qsTr("Stress")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            anchors.topMargin: 0
        }

        Text {
            id: text1
            text: (resultType.checkedButton === null) ? qsTr("No result type selected") : qsTr("Current result type: ") + resultType.checkedButton.text
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: thinningButton.bottom
            anchors.bottom: parent.bottom
            font.pixelSize: 12
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
        }
    }


    Rectangle {
        id: imageHolder
        color: "#ffffff"
        anchors.left: parametersMenu.right
        anchors.right: parent.right
        anchors.top: resultTypeMenu.bottom
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        Image {
            id: resultImage
            width: 400
            height: 400
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            fillMode: Image.PreserveAspectFit
            cache: false
            property bool counter: false

            function reload () {
                counter = !counter
                if (counter) {
                    source = "../temp/thinningField1.png"
                }
                else {
                    source = "../temp/thinningField2.png"
                }
            }
        }
    }

    Connections {
        target: backend

        function onUpdate (manufacturbility) {
            manufacturbilityValue.text = (manufacturbility).toFixed(2) + qsTr(" %")
            resultImage.reload()
        }

    }




}
